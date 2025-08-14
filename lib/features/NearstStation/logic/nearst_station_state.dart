part of 'nearst_station_cubit.dart';

enum NearestStationStatus {

  initial,
  loading,
  loaded,
  isEmpty,
  error,
  locationLoading,
  locationLoaded,
  locationError

}

class NearestStationState extends Equatable {


  final NearestStationStatus status;
  final String? errorMsg;
  final List<Stations>? nearestStations;
  final List<Stations>? nearestStationsFromLocation;

const NearestStationState({

  this.status = NearestStationStatus.initial,
  this.errorMsg,
  this.nearestStations,
  this.nearestStationsFromLocation

})
;

NearestStationState copyWith({

  NearestStationStatus? status,
  String? errorMsg,
  List<Stations>? nearestStations,
  List<Stations>? nearestStationsFromLocation,
})
=> NearestStationState(
  status: status ?? this.status,
  errorMsg: errorMsg ?? this.errorMsg,
  nearestStations: nearestStations ?? this.nearestStations,
  nearestStationsFromLocation: nearestStationsFromLocation ?? this.nearestStationsFromLocation

);


  @override
  // TODO: implement props

  List<Object?> get props => [status
    ,errorMsg
    ,nearestStations,
    nearestStationsFromLocation];


}