import 'package:flutter/material.dart';
import 'package:flutter_test_beacon2/src/bloc/provider.dart';
import 'package:flutter_test_beacon2/src/pages/home_page.dart';
import 'package:flutter_test_beacon2/src/pages/mensaje_page.dart';
import 'package:flutter_test_beacon2/src/providers/push_notifications_provider.dart';
import 'package:flutter_test_beacon2/src/shared_prefs/preferencias_usuarios.dart';

void main() async {
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(FlutterTestBeacon());
}

class FlutterTestBeacon extends StatefulWidget {
  @override
  _FlutterTestBeaconState createState() => _FlutterTestBeaconState();
}

class _FlutterTestBeaconState extends State<FlutterTestBeacon> {

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final pushProvider = new PushNotificationProvider();

    pushProvider.initNotifications();

    pushProvider.mensajes.listen((data){
      // Navigator.pushNamed(context, 'mensaje');
      // print('Argumento del push');
      // print(argumento);

      navigatorKey.currentState.pushNamed('mensaje', arguments: data );
    });

  }

  @override
  Widget build(BuildContext context) {

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'home'    : (BuildContext context) => HomePage(),
          'mensaje' : (BuildContext context) => MensajePage(),
        },
      ),
    );
  }
}
