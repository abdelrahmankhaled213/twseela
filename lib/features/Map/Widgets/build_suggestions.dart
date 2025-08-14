import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:twseela/features/GetRoute/Ui/widgets/select_start_and_end_drop.dart';
import 'package:twseela/features/Map/Data/model/auto_complete_response.dart';
import 'package:twseela/features/Map/Widgets/build_list_tile_suggestion.dart';
import '../../../core/constants/app_color.dart';
import '../Data/model/place_details.dart';
import '../presentation/logic/map_features_cubit.dart';
import '../presentation/logic/map_features_state.dart';

class BuildSuggestions extends StatefulWidget {

  final FloatingSearchBarController floatingSearchBarController;

  const BuildSuggestions({required this.floatingSearchBarController
    ,
    super.key});

  @override
  State<BuildSuggestions> createState() => _BuildSuggestionsState();
}

class _BuildSuggestionsState extends State<BuildSuggestions> {

  PlaceDetails? placeDetails;
  PlaceSuggestion? placeSuggestion;


  @override
  Widget build(BuildContext context) {


    return

      BlocConsumer<MapFeaturesCubit, MapFeaturesState>(

        listener: (context, state) async {

          if (state.mapsState == MapsStateEnum.getPlaceDetailsSuccess) {

            placeDetails = state.placeDetails;


         await   goToMySearchedPlace(placeDetails!, context);

            await getDirections();

            await  setMarkerForSearchedPlace(context, placeSuggestion!.description!);


            context.read<MapFeaturesCubit>().showDistanceAndTime();


            widget.floatingSearchBarController.close();


          }


          },


        listenWhen: (previous, current) {

          return previous != current && (

              current.mapsState == MapsStateEnum.getPlaceDetailsSuccess ||
                  current.mapsState == MapsStateEnum.getPlaceDetailsLoading ||
                  current.mapsState==MapsStateEnum.getTheSuggestionsSuccess ||
                  current.mapsState == MapsStateEnum.getPlaceDetailsError
          );
        },

        buildWhen: (previous, current) {

          return previous != current && (

              current.mapsState == MapsStateEnum.getTheSuggestionsSuccess ||
                  current.mapsState == MapsStateEnum.getTheSuggestionsError ||
                  current.mapsState == MapsStateEnum.getTheSuggestionsLoading);
        },

        builder: (context, state) {

          debugPrint('state.mapsState:${state.mapsState}');

          if (state.mapsState == MapsStateEnum.getTheSuggestionsLoading) {

            return Center(

              child:
                 Image.asset(
                     "assets/images/search_loading.gif"
                 )

            );
          }

          if (state.mapsState == MapsStateEnum.getTheSuggestionsSuccess) {

            return ListView.separated(

              separatorBuilder: (context, index) {

                return SizedBox(
                  height: 20,
                );
              },

              shrinkWrap: true,

              itemCount: state.suggestions!.length,

              itemBuilder: (context, index) {

                placeSuggestion = state.suggestions![index];

                return GestureDetector(

                  onTap: () async {

                    final cubit =
                    BlocProvider.of<MapFeaturesCubit>(context);

                    await cubit.getPlaceDetails(
                        state.suggestions?[index].placeId ?? "");
                  },

                  child: BuildListTileSuggestion(

                    placeSuggestion: state.suggestions![index],

                  ),
                );
              },
            );

          }

          if (state.mapsState == MapsStateEnum.getTheSuggestionsError) {

          }

          return const SizedBox();
        },

      );
  }

  Future<void> goToMySearchedPlace(

      final PlaceDetails placeDetails,
      BuildContext context) async {


    final cubit = context
        .read<MapFeaturesCubit>();

    cubit.setMyLocationNowCamera(

        CameraPosition(

          target: LatLng(placeDetails.lat, placeDetails.lng),

          zoom: 20,

          bearing: 0.0,

          tilt: 0.0,

        )
    );

    final GoogleMapController controller =

    await cubit
        .googleMapController;

    controller.animateCamera(
        CameraUpdate.newCameraPosition(
            cubit.myLocationNowCamera!));
  }

  Future<void> setMarkerForSearchedPlace(BuildContext context,
      String description) async {

    final cubit = context.read<MapFeaturesCubit>();

    final Marker searchedPlaceMarker = Marker(

      markerId: MarkerId('1'),


      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),

      position: cubit
          .myLocationNowCamera
          ?.target ?? LatLng(0, 0),

      onTap: () {

      },

    );


    final Marker homeMarker = Marker(

      markerId: MarkerId('2'),



      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),

      position: toLatLong(cubit.state.currentLocation!),

      onTap: () {

      },

    );


cubit.setMarker(searchedPlaceMarker,homeMarker);

  }

Future<void> getDirections() async {

  final cubit = context.read<MapFeaturesCubit>();

  print("e7na ahpooooooo");


  if(cubit.homeLocationNowCamera?.target==null){
    print("fe nullll fe home location camera");
    return;
  }

  if(cubit.myLocationNowCamera?.target==null){
    print("fe nullll fe myLocation location camera");
    return;
  }

 await  cubit.getDirectionsPlace(

     toLatLong(cubit.state.currentLocation!)
    ,
  cubit.myLocationNowCamera!.target

 );





}
}
