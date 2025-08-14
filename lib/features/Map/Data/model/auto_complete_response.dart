class PlaceSuggestion{

  final String? description;
  final String? placeId;

  const PlaceSuggestion({this.description, this.placeId});

  factory PlaceSuggestion.fromJson(dynamic json) {

    return PlaceSuggestion(
      description: json['description'] ,
      placeId: json['place_id'] ,
    );
  }


}