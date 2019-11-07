import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:flutter_test_beacon2/src/bloc/provider.dart';
import 'package:flutter_test_beacon2/src/modelos/beacons_attachments.dart';
import 'package:flutter_test_beacon2/src/shared_prefs/preferencias_usuarios.dart';

//EstimoteCloudProvider estimoteProvider = new EstimoteCloudProvider();

class HomePage extends StatelessWidget {
  final _prefs = new PreferenciasUsuario();

  BeaconsAttachments listaEstimotes;
  @override
  Widget build(BuildContext context) {
    final beaconBl = Provider.beaconBloc(context);
    beaconBl.getAttachments().then((v) {
      listaEstimotes = v;
    });
    beaconBl.inicializarScann();
    beaconBl.addRegions("0EDC0062-54B3-DD73-FFEF-F0E942611666", 'com.beacon');
    beaconBl.rangingBeacon();

    //_getAttachments();
    //_activarScann();
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME'),
      ),
      body: _verBacons(beaconBl),
    );
  }

  Widget _verBacons(BeaconBloc beaconBloc) {
    return StreamBuilder(
      stream: beaconBloc.beaconsRangingStream,
      builder: (BuildContext context, AsyncSnapshot<List<Beacon>> snapshot) {
        if (snapshot.hasData) {
          //beaconBloc.pauseRangingBeacon();
          final beacons = snapshot.data;

          return ListView.builder(
            itemCount: beacons.length,
            itemBuilder: (BuildContext context, i) {
              return Column(
                children: <Widget>[
                  Text(beacons[i].macAddress),
                  MaterialButton(
                    child: Text('CONTINUAR'),
                    onPressed: (){
                      beaconBloc.resumeRangingBeacon();
                    },
                  )
                ],
              );
                 //mostrarAlerta(context, beacons[i].macAddress, beaconBloc);
              /* listaEstimotes.data.forEach((f) {
                      
                      return Column(
                        children: <Widget>[
                          Text( f.payload.posicion ),
                          MaterialButton(
                            child: Text('continuar'),
                            onPressed: (){
                              beaconBloc.resumeRangingBeacon();
                            },
                          )
                        ],
                      );
                      
 /*  */

                    
                  }); */

              //return Container();
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void mostrarAlerta( BuildContext context, String mensaje, BeaconBloc beaconBloc ){
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Información incorrecta'),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: (){
              Navigator.of(context).pop();
              beaconBloc.resumeRangingBeacon();
            },
          )
        ],
      );
    }
  );
}

  /* void _getAttachments(){
    estimoteProvider.getBeaconsAttachments().then((v) {
      beaconsAttachmentsData = v;
      
    });
  } */

  /* void _activarScann() async {
        try {
          await flutterBeacon.initializeScanning;
          
        } catch(e) {
    
          print(e);
          // library failed to initialize, check code and message
        }
      } */
}
