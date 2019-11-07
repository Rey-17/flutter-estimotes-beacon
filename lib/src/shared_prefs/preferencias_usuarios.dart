


import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario(){
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences prefs;

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  //Ninguna de estas propiedades se usa

  // bool _colorSecundario;
  // int _genero;
  // String _nombre;

 /*  get genero {
    return prefs.getInt('genero') ?? 1;
  }

  set genero( int value ){
    prefs.setInt('genero', value);
  } */

  get flagNotificationBeacon {
    return prefs.getInt('flagNotification');
  }

  set flagNotificationBeacon( int value ){
    prefs.setInt('flagNotification', value);
  }


}