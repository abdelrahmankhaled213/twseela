import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela/core/constants/app_color.dart';
import 'package:twseela/features/NearstStation/logic/nearst_station_cubit.dart';

import '../widgets/customAnimatedContainerNearestStation.dart';

class NearestLocationFromLocation extends StatelessWidget {

  const NearestLocationFromLocation({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: AppColor.primaryColor,
      
      body: BlocBuilder<NearestStationCubit, NearestStationState>(

          builder: (context, state) {

            if(state.status == NearestStationStatus.locationLoaded){

              return  SafeArea(

                child: Padding(

                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10
                  ),
                  child: ListView.separated(

                    itemBuilder: (context, index) {

                      return CustomAnimatedContainerNearestStation(

                        distance: state.nearestStationsFromLocation![index].distance!,
                        height: 100,
                        result: state.nearestStationsFromLocation![index].stationName,
                        index: index + 1,

                      );

                    },
                    addAutomaticKeepAlives: true

                    ,separatorBuilder: (context, index) {
                     return const SizedBox(height: 18);
                    }, itemCount: state.nearestStationsFromLocation!.length

                  ),
                ),
              );

            }

              if (state.status == NearestStationStatus.locationLoading) {

                return CircularProgressIndicator();

              }


            return SizedBox.shrink();

              },

              ),

    );
  }
}
