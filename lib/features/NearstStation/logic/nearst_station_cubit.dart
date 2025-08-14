import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:twseela/features/NearstStation/model/Metro_lat_and_long.dart';

part 'nearst_station_state.dart';

class NearestStationCubit extends Cubit<NearestStationState> {

  NearestStationCubit() : super(
      NearestStationState(
    status: NearestStationStatus.initial,
  ) );


  void getNearestStations(double lat ,double long) {

    emit(
      state.copyWith(
      status: NearestStationStatus.loading,

      ));


    List<Stations> nearestStations = _findNearestStations(lat,long);

    emit(

        state.copyWith(

      status: NearestStationStatus.loaded,
      nearestStations: List.from(nearestStations),

    )
    );
  }


  void getNearestStationFromYourLocation(Position? position) {

    print("getNearestStationFromYourLocation ${position?.latitude}");

    if (position == null) {
      emit(state.copyWith(
        status: NearestStationStatus.locationError,
        errorMsg: "location not found",
      ));
      return;
    }

    emit(
        state.copyWith(
      status: NearestStationStatus.locationLoading,

    ));

Future.delayed(Duration(seconds: 3));

    List<Stations> nearestStations =
    _findNearestStations(position.latitude,position.longitude);


    emit(
        state.copyWith(
      status: NearestStationStatus.locationLoaded,
      nearestStationsFromLocation: List.from(nearestStations),
    )
    );

  }



  }



List<Stations> _findNearestStations(double lat, double long) {

  final List<Stations> stationListCopy =

  List.from(Stations.stationList
      .map((station) => station) // assumes Station has copy()
      .toList());

  debugPrint("$lat.....$long");

  for(var station in stationListCopy){

    station.distance=
        _calculateDistance(station.lat, station.long, lat, long);

  }

  stationListCopy.sort((a, b) {


return a.distance!.compareTo(b.distance!);

  });

  return stationListCopy.take(5).toList(); // nearest two stations

}

  double _calculateDistance(double lat1, double lon1
      , double lat2, double lon2) {
    const R = 6371; // Radius of the Earth in km
    final dLat = _deg2rad(lat2 - lat1);
    final dLon = _deg2rad(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) *
            sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }
  double _deg2rad(double deg) => deg * (pi / 180);






