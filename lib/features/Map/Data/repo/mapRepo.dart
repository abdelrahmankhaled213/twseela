import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:twseela/core/Error/exception.dart';
import 'package:twseela/core/api/api_constants.dart';
import 'package:twseela/core/constants/google_keys.dart';

import '../../../../core/api/api_service.dart';
import '../model/auto_complete_response.dart';
import '../model/direction_place.dart';
import '../model/place_details.dart';

class MapsRepo {

  final ApiConsumer apiConsumer;

  MapsRepo(this.apiConsumer);

  Future<Either<ServerException, List<PlaceSuggestion>>> getSuggestionsData(
      String input,
      String sessionToken,) async {
    try {
      final response = await apiConsumer.get(
        endPointAutoComplete,
        queryParameters: {
          'key': apiKeyMap,
          'input': input,
          'components': 'country:eg',
          'sessiontoken': sessionToken,
        },

      );


      final List<PlaceSuggestion> suggestions =
      (response['predictions'] as List)
          .map((e) => PlaceSuggestion.fromJson(e))
          .toList();

      debugPrint(suggestions.length.toString());

      return Right(suggestions);
    } on ServerException catch (e) {
      print("🛑 ServerException: ${e.message}");
      return Left(ServerException(e.message, e.statusCode));
    } catch (e, stackTrace) {
      debugPrint("🔥 Unhandled exception: $e");
      debugPrint("🧵 StackTrace: $stackTrace");

      return Left(
          ServerException(e.toString(), 500)
      );
    }
  }


  Future<Either<ServerException, PlaceDetails>> getPlaceDetailsData(
      String placeId,
      String sessionToken,) async {
    try {
      final response = await apiConsumer.get(
        endPointPlaceDetails,
        queryParameters: {

          'key': apiKeyMap,
          'fields': 'geometry',
          'place_id': placeId,
          'sessiontoken': sessionToken,

        },
      );

      debugPrint(response.toString());

      final requiredResponse = response['result']
      ['geometry']['location'];

      final PlaceDetails placeDetails =
      PlaceDetails.fromJson(requiredResponse);

      return Right(placeDetails);
    } on ServerException catch (e) {
      print("🛑 ServerException: ${e.message}");

      return Left(ServerException(e.message, e.statusCode));
    } catch (e, stackTrace) {
      debugPrint("🔥 Unhandled exception: $e");
      debugPrint("🧵 StackTrace: $stackTrace");

      return Left(
          ServerException(e.toString(), 500)
      );
    }
  }

  Future<Either<ServerException, DirectionPlace>> getDirectionsData(LatLng origin
      ,LatLng destination) async {

    try{

    final response = await apiConsumer.get(

      endPointDirectionsApi,
      queryParameters: {

        'origin':'${origin.latitude},${origin.longitude}',
        'destination':'${destination.latitude},${destination.longitude}',
        'key': apiKeyMap,

      },

    );

    debugPrint("al response"+response.toString());

    return Right(DirectionPlace.fromJson(response));

  }
    on ServerException catch (e) {

      debugPrint("🛑 ServerException: ${e.message}");

      return Left(ServerException(e.message, e.statusCode));
    }
    catch (e, stackTrace) {

      debugPrint("🔥 Unhandled exception: $e");
      debugPrint("🧵 StackTrace: $stackTrace");

      return Left(

          ServerException(e.toString(), 500)

      );
    }
  }
}

