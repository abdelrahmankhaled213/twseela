import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class DirectionPlace{

final MapBounds ? bounds;
final List<PointLatLng>? polyLines;
final String? totalDistance;
final String? totalDuration;

DirectionPlace({
  required this.bounds
  ,required this.polyLines
  ,required this.totalDistance
  ,required this.totalDuration
});


factory DirectionPlace.fromJson(Map<String, dynamic> json) {

  if((json['routes'] as List).isEmpty){

    return DirectionPlace(

      bounds: null,
      polyLines: [],
      totalDistance: "0.0",
      totalDuration: "0.0",

    );

  }

  if((json['routes'][0]['legs'] as List).isEmpty){

    return DirectionPlace(
   bounds: MapBounds.fromJson(json['routes'][0]['bounds']),
   totalDistance: "0",
   totalDuration: "0",
   polyLines: [],
    );
    }


final List<PointLatLng> polyLines =

PolylinePoints().decodePolyline
  (json['routes'][0]['overview_polyline']['points']);

  return DirectionPlace(

    bounds:MapBounds.fromJson(json['routes'][0]['bounds']),
    polyLines:polyLines,
    totalDistance: json['routes'][0]['legs'][0]['distance']['text']??'',
    totalDuration: json['routes'][0]['legs'][0]['duration']['text']??'',

  );

}




}

class MapBounds{

final NorthEast? northEast;
final SouthWest? southWest;


MapBounds({required this.northEast,required this.southWest});

factory MapBounds.fromJson(Map<String, dynamic> json) {

return MapBounds(

  northEast:  json['northeast']==null? null:NorthEast.fromJson(json['northeast']),

  southWest: json['southwest']==null? null:SouthWest.fromJson(json['southwest']),

);

}
}

class NorthEast{

  final double? lat;
  final double? lng;


  const NorthEast({required this.lat,required this.lng});

  factory NorthEast.fromJson(Map<String, dynamic> json) {

    return NorthEast(

lat: json['lat']??0,
lng: json['lng']??0,

    );

  }
}

class SouthWest{

  final double? lat;
  final  double? lng;

SouthWest({required this.lat,required this.lng});

  factory SouthWest.fromJson(Map<String, dynamic> json) {

    return SouthWest(

       lat: json['lat']??0,
       lng: json['lng']??0,

    );

  }

}


