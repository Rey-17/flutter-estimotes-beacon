import 'dart:async';

import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:flutter_test_beacon2/src/modelos/beacons_attachments.dart';
import 'package:flutter_test_beacon2/src/providers/estimote_cloud.dart';
import 'package:rxdart/rxdart.dart';

/// Clase BeaconBloc que se encarga de manejar el plugin de escaneo de beacons.
class BeaconBloc {

  ///variables
  final regions = <Region>[];
  StreamSubscription<RangingResult> _streamRanging;
  BeaconsAttachments _beaconsAttachments;

  final _beaconRanging = new BehaviorSubject<List<Beacon>>();

  /// instancia del EstimoteCloudProvider
  final _estimoteCloudProvider = EstimoteCloudProvider();

  /// Se escuchan los Streams
  Stream<List<Beacon>> get beaconsRangingStream => _beaconRanging.stream;
  
  /// Inicializa el escaneo de beacons. Se activa el bluetooth
  void inicializarScann() async {
    //print( 'inicializar scann' );
    getAttachments();
    try {
      await flutterBeacon.initializeScanning;
    } catch (e) {
      print(e);
      // library failed to initialize, check code and message
    }
  }

  /// Se agrega el identificador del paquete y el UUID de proximidad
  void addRegions( String proximityUUID, String identifier ) {
    //print( 'Agregar regiones' );
    regions.add(Region(identifier: identifier, proximityUUID: proximityUUID));
  }

  void rangingBeacon() {
    
    _streamRanging =
        flutterBeacon.ranging(regions).listen((RangingResult result) {
      // result contains a region and list of beacons found
      // list can be empty if no matching beacons were found in range
      if( result.beacons.toString() != '[]' ){
        int cont = 0;

        result.beacons.forEach((f){
          if( f.proximity == Proximity.near || f.proximity == Proximity.immediate ){
            _beaconRanging.sink.add(result.beacons);
            cont ++;
          }
        });

        if( cont > 0 ){
          pauseRangingBeacon( result.beacons );
        }

      }
    });
  }

  void pauseRangingBeacon( List<Beacon> beacons ){
    //print('pause ranging');
    _streamRanging.pause();

    _beaconsAttachments.data.forEach( (beaconA){
      beacons.forEach((beacon){
        if( beacon.macAddress.split(':').join().toLowerCase() == beaconA.identifier ){
         // print( '${beaconA.payload.empresa} - ${beaconA.payload.posicion}' );
        }
      });
    });

    Future.delayed(Duration(seconds: 4), resumeRangingBeacon);

  }

  void resumeRangingBeacon(){
    //print( 'resume ranging' );
    _streamRanging.resume();

  }

  void cancelRanging() {
    _streamRanging.cancel();
  }

  dispose(){
    _beaconRanging?.close();
  }

  /// Métodos para la clase EstimoteCloudProvider
  Future<BeaconsAttachments> getAttachments() async {
    //print( 'getAttachments' );
    _beaconsAttachments = await _estimoteCloudProvider.getBeaconsAttachments();
    return _beaconsAttachments;
  }


}
