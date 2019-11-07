
import 'package:flutter/material.dart';

import 'package:flutter_test_beacon2/src/bloc/beacon_bloc.dart';
export 'package:flutter_test_beacon2/src/bloc/beacon_bloc.dart';

class Provider extends InheritedWidget {

  /// Unica instancia del beaconBloc a llamar en toda la aplicación
  final _beaconBloc = BeaconBloc();

  static Provider _instancia;

  factory Provider({ Key key, Widget child }){

    if( _instancia == null ){

      _instancia = new Provider._internal(key: key, child: child);
      
    }

    return _instancia;

  }


  Provider._internal({Key key, Widget child})
  :super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;


  static BeaconBloc beaconBloc(BuildContext context) {

    return (context.inheritFromWidgetOfExactType(Provider) as Provider )._beaconBloc;
  
  }


  
  
}