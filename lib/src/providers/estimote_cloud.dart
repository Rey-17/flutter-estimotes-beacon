import 'dart:convert';

import 'package:flutter_test_beacon2/src/modelos/beacon_single_identifier.dart';
import 'package:flutter_test_beacon2/src/modelos/beacons_attachments.dart';
import 'package:http/http.dart' as http;

String url = 'cloud.estimote.com';
String apiVersion = '/v3/';

// Credenciales de estimote cloud
String username = "***************";
String password = "************************";

String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));


class EstimoteCloudProvider {

  Future<BeaconSingleByIdentifier> _procesarRespuesta(Uri url) async {
  
    final resp = await http.get(url, headers: <String, String>{'authorization': basicAuth});

    if( resp.statusCode == 200 ){
      final decodeData = json.decode( resp.body );

      final beaconData = new BeaconSingleByIdentifier( data: decodeData['data'], meta: decodeData['meta'] );

      return beaconData;
    }

    else {
      return null;
    }
    

  }

  Future<BeaconsAttachments> _procesarRespuestaAttachment( Uri url ) async {

    final resp = await http.get(url, headers: <String, String>{ 'authorization': basicAuth });

    

    final decodeData = json.decode( resp.body );
    final beaconAttachmentsData = new BeaconsAttachments.fromJson(decodeData);

    return beaconAttachmentsData;


  }

  Future<BeaconSingleByIdentifier>getBeaconByIdentifier( String identifier ) async {

    final _url = Uri.https(url, '${apiVersion}devices/$identifier/attachment');

    return await _procesarRespuesta(_url);

  }

  Future<BeaconsAttachments> getBeaconsAttachments(  ) async {

    final _url = Uri.https( url , '${apiVersion}attachments' );

    return await _procesarRespuestaAttachment(_url);

  }

}