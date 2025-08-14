import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:twseela/core/helpers/flutter_toast_helper.dart';

class LocationHelper {


  static Future<Position?> determinePosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        FlutterToastHelper.showToast(
          'Location services are disabled',
          color: Colors.red,
        );
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          FlutterToastHelper.showToast(
            'Location permissions are denied',
            color: Colors.red,
          );
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        FlutterToastHelper.showToast(
          'Location permissions are permanently denied, we cannot request permissions.',
          color: Colors.red,
        );
        return null;
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      FlutterToastHelper.showToast(
        'Failed to get location: $e',
        color: Colors.red,
      );
      return null;
    }
  }

//   static Stream<Position>? getStreamLatLong(){
//
//
//
//  return Geolocator.getPositionStream(
//   locationSettings: LocationSettings(
//     accuracy: LocationAccuracy.best,
//     distanceFilter: 10,
//   ),
// );
//
//  }
//

}
