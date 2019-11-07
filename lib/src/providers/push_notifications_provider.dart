
import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';


class PushNotificationProvider {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;
  
  initNotifications(){

    _firebaseMessaging.requestNotificationPermissions();


    _firebaseMessaging.getToken().then((token){

      print('+++++++ FCM TOKEN ==========');
      print(token);

    });


    _firebaseMessaging.configure(

      // Al recibir la notificacion con la pantalla activa
      onMessage: ( info ) async {
        print('============ On Message ===============');
        print(info);

        String argumento = 'no-data';
        if ( Platform.isAndroid ){
          argumento = info['data']['comida'] ?? 'no-data';
        }

        _mensajesStreamController.sink.add(argumento);

        // _mensajesStreamController.sink.add(event);

      },

      onLaunch: ( info ) async {
        print('============ On Launch ===============');
        print(info);

        String argumento = 'no-data';

        if ( Platform.isAndroid ){
          argumento = info['data']['comida'] ?? 'no-data';
        }

        _mensajesStreamController.sink.add(argumento);

      },

      // al hacer click desde el appbar
      onResume: ( info ) async {
        print('============ On Resume ===============');
        print(info);

        String argumento = 'no-data';

        if ( Platform.isAndroid ){
           argumento = info['data']['comida'] ?? 'no-data';
        }

        _mensajesStreamController.sink.add(argumento);

        // final noti = info['data']['comida'];
        // print( noti );


      },

    );

  }

  void dispose(){
    _mensajesStreamController?.close();
  }

}