import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:twseela/core/helpers/flutter_toast_helper.dart';
import 'package:twseela/features/NearstStation/logic/nearst_station_cubit.dart';

import '../../../../core/constants/app_color.dart';
import '../../../Map/Data/model/auto_complete_response.dart';
import '../../../Map/Data/model/place_details.dart';
import '../../../Map/Widgets/build_list_tile_suggestion.dart';
import '../../../Map/presentation/logic/map_features_cubit.dart';
import '../../../Map/presentation/logic/map_features_state.dart';

class BuildSuggestionsNearestLocation extends StatefulWidget {

  final FloatingSearchBarController floatingSearchBarController;

  const BuildSuggestionsNearestLocation(
      {required this.floatingSearchBarController
        ,
        super.key});

  @override
  State<BuildSuggestionsNearestLocation> createState() =>
      _BuildSuggestionsState();
}

class _BuildSuggestionsState extends State<BuildSuggestionsNearestLocation> {

  PlaceDetails? placeDetails;
  PlaceSuggestion? placeSuggestion;


  @override
  Widget build(BuildContext context) {
    return

      BlocConsumer<MapFeaturesCubit, MapFeaturesState>(

        listener: (context, state) {

          if (state.mapsState == MapsStateEnum.getPlaceDetailsSuccess) {

            placeDetails = state.placeDetails;

            context.read<NearestStationCubit>().getNearestStations
              (placeDetails!.lat, placeDetails!.lng);


            widget.floatingSearchBarController.close();
          }
        },


        listenWhen: (previous, current) {
          return previous != current && (

              current.mapsState == MapsStateEnum.getPlaceDetailsSuccess ||
                  current.mapsState == MapsStateEnum.getPlaceDetailsLoading ||
                  current.mapsState == MapsStateEnum.getPlaceDetailsError

          );
        },

        buildWhen: (previous, current) {
          return previous != current && (

              current.mapsState == MapsStateEnum.getTheSuggestionsSuccess ||
                  current.mapsState == MapsStateEnum.getTheSuggestionsError ||
                  current.mapsState ==
                      MapsStateEnum.getTheSuggestionsLoading ||
                  current.mapsState ==
                      MapsStateEnum.getTheSuggestionsSuccessEmpty




          );
        },

        builder: (context, state) {

          debugPrint('state.mapsState:${state.mapsState}');

          if (state.mapsState == MapsStateEnum.getTheSuggestionsLoading) {

            return Center(

              child: Image.asset("assets/images/search_loading.gif"
                ,height: 400,
                fit: BoxFit.cover,

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


}

