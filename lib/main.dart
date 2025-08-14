import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:twseela/core/Di/service_locator.dart';
import 'package:twseela/core/Hive/hive_services.dart';
import 'package:twseela/twseela.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();


  await HiveService.hiveInit();

   setUpServiceLocator();

  Bloc.observer = MyBlocObserver();


  runApp(const Twseela());

}



class MyBlocObserver extends BlocObserver {

  @override
  void onCreate(BlocBase<dynamic> bloc) {

    super.onCreate(bloc);

    log('onCreate -- ${bloc.runtimeType}');

  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {

    super.onChange(bloc, change);

    log('onChange -- ${bloc.runtimeType}, $change');

  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {

    super.onError(bloc, error, stackTrace);

    log('onError -- ${bloc.runtimeType}, $error');

  }

  @override
  void onClose(BlocBase<dynamic> bloc) {

    super.onClose(bloc);

    log('onClose -- ${bloc.runtimeType}');

  }
}