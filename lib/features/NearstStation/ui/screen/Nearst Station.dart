import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela/features/NearstStation/ui/widgets/customAnimatedContainerNearestStation.dart';
import '../../../../core/constants/app_color.dart';
import '../../logic/nearst_station_cubit.dart';
import '../../model/Metro_lat_and_long.dart';
import '../widgets/build_search_nearstStation.dart';

class NearStationFromYourTypedLocation extends StatelessWidget {

  const NearStationFromYourTypedLocation({super.key});

  @override
  Widget build(BuildContext context) {

    List<Stations> data = [];

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body:
       Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BlocListener<NearestStationCubit, NearestStationState>(
          listener: (context, state) {
            if (state.status == NearestStationStatus.loaded) {
              data = List.from(state.nearestStations!);
            }
          },
          child: SizedBox(
            child: Stack(

              children: [
                /// This is your ListView (main content)
                BlocBuilder<NearestStationCubit, NearestStationState>(

                  builder: (context, state) {


                    return Padding(
                      padding: const EdgeInsets.only(top: 70), // Space for the search bar
                      child: ListView.separated(
                        itemCount: data.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 18),
                        itemBuilder: (context, index) {
                          return CustomAnimatedContainerNearestStation(
                            distance: data[index].distance!,
                            height: 100,
                            result: data[index].stationName,
                            index: index + 1,
                          );
                        },
                      ),
                    );
                  },
                ),

                /// Positioned search bar (floating on top)

                BuildFloatingSearchNearestStation(),

              ],
            ),
          ),

        ),
      ),
    );
  }
}

