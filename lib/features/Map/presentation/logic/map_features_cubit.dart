import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:twseela/features/Map/presentation/logic/map_debouncer.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/helpers/location_helper.dart';
import '../../Data/repo/mapRepo.dart';
import 'map_features_state.dart';

class MapFeaturesCubit extends Cubit<MapFeaturesState> {

  final MapsRepo mapsRepo;

  final AutoCompleteDeBouncer autoCompleteDeBouncer ;

  final Completer<GoogleMapController> _mapControllerCompleter = Completer();

  CameraPosition? _myLocationNowCamera;

  CameraPosition? _homeLocationNowCamera;




 void getCurrentLocation() async{

   var myCurrentPosition =await LocationHelper.determinePosition();

   print(myCurrentPosition?.latitude);
   print(myCurrentPosition?.longitude);

   if(myCurrentPosition==null){

     emit(
         state.copyWith(
       mapsState: MapsStateEnum.getCurrentLocationError,
       errorMsg: "location not found",
     )
     );

     return;

   }

   emit(
       state.copyWith(

     mapsState: MapsStateEnum.getCurrentLocation,
     currentLocation: myCurrentPosition,

   ));


 }


  void setMarker(Marker placeMarker,Marker homePlaceMarker) {

    final Set<Marker> markers = {};



    debugPrint('marker added');

    markers..
    add(placeMarker)..
    add(homePlaceMarker);


debugPrint('marker :{${markers.length}}');

    emit(

    state.copyWith(

    mapsState: MapsStateEnum.refreshGoogleMap

        ,markers: Set<Marker>.from(markers),


    )

    );


  }

  void showDistanceAndTime() {


    emit(
      state.copyWith(
        mapsState:MapsStateEnum.isShownDistanceAndTime,
      isShownTimeAndDistance: true,
    ),
    );
  }
  void hideDistanceAndTime() {

    emit(
      state.copyWith(
        mapsState:MapsStateEnum.isShownDistanceAndTime,
      isShownTimeAndDistance: false,
      )
    );
  }

void setHomeLocationNowCamera(CameraPosition cameraPosition) {

    _homeLocationNowCamera = cameraPosition;

}


CameraPosition? get homeLocationNowCamera => _homeLocationNowCamera;




  void setMyLocationNowCamera(CameraPosition cameraPosition) {

    _myLocationNowCamera = cameraPosition;

  }

  CameraPosition? get myLocationNowCamera => _myLocationNowCamera;




  void setGoogleMapController(GoogleMapController controller) {

    if (_mapControllerCompleter.isCompleted) {

      return;

    }

    _mapControllerCompleter.complete(controller);

  }

Future<GoogleMapController> get googleMapController =>
    _mapControllerCompleter.future;



  MapFeaturesCubit(this.mapsRepo,this.autoCompleteDeBouncer) :
        super(
          MapFeaturesState(mapsState: MapsStateEnum.initial)
      );





  Future<void> getThePlaceSuggestions
      (String input,String sessionToken) async {


    emit(

        state.copyWith(

            mapsState: MapsStateEnum.getTheSuggestionsLoading,

        )

    );

autoCompleteDeBouncer.call(() async {

  final suggestions = await mapsRepo.getSuggestionsData(input,sessionToken);

  suggestions.fold(
        (l) {

      emit(

          state.copyWith(

            polyLinesPoints: [],
            mapsState: MapsStateEnum.getTheSuggestionsError,
            errorMsg: l.message,
            statusCode: l.statusCode,

          ));

    },

        (r) {


          if(r.isEmpty){

            emit(state.copyWith(

                mapsState: MapsStateEnum.getTheSuggestionsSuccessEmpty,


            ));
          }
      emit(

          state.copyWith(


            mapsState: MapsStateEnum.getTheSuggestionsSuccess,
            suggestions: r,

          )

      );

    },

  );

},
);

  }

  Future<void>getPlaceDetails(String placeId) async {

    emit(state.copyWith(mapsState: MapsStateEnum.getPlaceDetailsLoading));

    final sessionToken = Uuid().v4();

    final placeDetails =
    await mapsRepo.getPlaceDetailsData(placeId,sessionToken);

    placeDetails.fold((l) {

      emit(
          state.copyWith(
          mapsState: MapsStateEnum.getPlaceDetailsError,
          errorMsg: l.message,
          statusCode: l.statusCode
      )
      );

    }, (r) {

      debugPrint (r.lat.toString());

      emit(
          state.copyWith(
          mapsState: MapsStateEnum.getPlaceDetailsSuccess,
          placeDetails: r
      )
      );

    });

  }

Future<void> getLatLongFromStart(String text)  =>
    _getLatLongFromDropButton(text);







  Future<void> getDirectionsPlace( LatLng origin ,LatLng destination )async{

  emit(
      state.copyWith(
          mapsState: MapsStateEnum.getDirectionsLoading
      ))
  ;

  final data=await mapsRepo.getDirectionsData(origin, destination);

  data.fold((l) {

print(l.statusCode);
print(l.message);

emit(

        state.copyWith(

            mapsState: MapsStateEnum.getDirectionsError,
            errorMsg: l.message,
            statusCode: l.statusCode

        )

);

  }, (r) {

print(r.totalDistance??21);

    if(r.polyLines!.isNotEmpty){
      debugPrint("la2 msh fdya 5als");
    }

    emit(

        state.copyWith(

            polyLinesPoints: r.polyLines?.map((e) {
              return LatLng(e.latitude, e.longitude);
            },).toList(),

            mapsState: MapsStateEnum.getDirectionsSuccess,

            directionPlace: r
        )
    );
  }
  );

  }

  @override
  Future<void> close() {

autoCompleteDeBouncer.close();

return super.close();

  }


  Future<void> _getLatLongFromDropButton(String text) async {

    try {

      final query = "محطة مترو+$text".trim();

      List<Location> results = await locationFromAddress(query);

      if (results.isNotEmpty) {

        final lat = results.first.latitude;
        final long = results.first.longitude;

        debugPrint("$lat ...... $long");

        emit(
            state.copyWith(
          mapsState:
               MapsStateEnum.getLatLongFromStartSuccess,

          getLatFromStart:  lat ,
          getLongFromStart:  long ,

        ));
      } else {
        throw Exception("No locations found.");
      }
    } catch (e) {
      debugPrint("Error in _getLatLongFromDropButton: $e");
      emit(
          state.copyWith(

        mapsState:MapsStateEnum.getLatLongFromStartFailed,

        errorMsg: "فشل في تحديد الإحداثيات",
      ));
    }
  }

}
