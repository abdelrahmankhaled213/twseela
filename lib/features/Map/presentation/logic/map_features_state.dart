import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:twseela/features/Map/Data/model/direction_place.dart';
import '../../Data/model/auto_complete_response.dart';
import '../../Data/model/place_details.dart';

enum MapsStateEnum {
  initial,
  getCurrentLocation,
  getCurrentLocationError,
  refreshGoogleMap,
  isShownDistanceAndTime,
  getTheSuggestionsLoading,
  getTheSuggestionsSuccess,
  getTheSuggestionsSuccessEmpty,
  getTheSuggestionsError,
  getPlaceDetailsLoading,
  getPlaceDetailsSuccess,
  getPlaceDetailsError,
  getDirectionsLoading,
  getDirectionsSuccess,
  getDirectionsError,
  getLatLongFromStartSuccess,
  getLatLongFromStartFailed,

}

class MapFeaturesState extends Equatable {

  final MapsStateEnum mapsState;
  final String? errorMsg;
  final int? statusCode;
  final Position? currentLocation;
  final List<PlaceSuggestion>? suggestions;
  final PlaceDetails? placeDetails;
  final Set<Marker>? markers;
  final DirectionPlace? directionPlace;
  final List<LatLng>? polyLinesPoints;
  final bool? isShownTimeAndDistance;
  final double? getLatFromStart;
  final double? getLongFromStart;

  const MapFeaturesState({
    this.mapsState = MapsStateEnum.initial,
    this.errorMsg,
    this.statusCode,
    this.currentLocation,
    this.suggestions,
    this.placeDetails,
    this.markers = const {},
    this.directionPlace,
    this.polyLinesPoints,
    this.isShownTimeAndDistance = false,
    this.getLatFromStart,
    this.getLongFromStart,
  });

  MapFeaturesState copyWith({
    MapsStateEnum? mapsState,
    String? errorMsg,
    int? statusCode,
    Position? currentLocation,
    List<PlaceSuggestion>? suggestions,
    PlaceDetails? placeDetails,
    Set<Marker>? markers,
    DirectionPlace? directionPlace,
    List<LatLng>? polyLinesPoints,
    bool clearPolyLines = false,
    bool? isShownTimeAndDistance,
    double? getLatFromStart,
    double? getLongFromStart,
  }) {
    return MapFeaturesState(
      mapsState: mapsState ?? this.mapsState,
      errorMsg: errorMsg ?? this.errorMsg,
      statusCode: statusCode ?? this.statusCode,
      currentLocation: currentLocation ?? this.currentLocation,
      suggestions: suggestions ?? this.suggestions,
      placeDetails: placeDetails ?? this.placeDetails,
      markers: markers ?? this.markers,
      directionPlace: directionPlace ?? this.directionPlace,
      polyLinesPoints: clearPolyLines ? [] : (polyLinesPoints ?? this.polyLinesPoints),
      isShownTimeAndDistance: isShownTimeAndDistance ?? this.isShownTimeAndDistance,
      getLatFromStart: getLatFromStart ?? this.getLatFromStart,
      getLongFromStart: getLongFromStart ?? this.getLongFromStart,
    );
  }

  @override
  List<Object?> get props => [
    mapsState,
    errorMsg,
    statusCode,
    suggestions,
    placeDetails,
    markers,
    directionPlace,
    polyLinesPoints,
    isShownTimeAndDistance,
    currentLocation,
    getLatFromStart,
    getLongFromStart,
  ];

  @override
  String toString() {
    return 'mapsState: $mapsState, '
        'errorMsg: $errorMsg, '
        'statusCode: $statusCode, '
        'suggestions: $suggestions, '
        'placeDetails: $placeDetails, '
        'polyLinesPoints: ${polyLinesPoints?.length ?? 0} points';
  }
}
