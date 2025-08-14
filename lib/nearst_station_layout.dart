import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela/features/GetRoute/Ui/widgets/CustomAnimatedContainer.dart';
import 'package:twseela/features/Map/presentation/logic/map_features_cubit.dart';
import 'package:twseela/features/NearstStation/logic/nearst_station_cubit.dart';
import 'package:twseela/features/NearstStation/ui/screen/Nearst%20Station.dart';
import 'package:twseela/features/NearstStation/ui/screen/Nearst_location_from_location.dart';

import 'core/Di/service_locator.dart';

class NearestStationLayout extends StatelessWidget {

  const NearestStationLayout ({super.key});

  @override
  Widget build(BuildContext context) {



    return

      Center(


       child:  Padding(

         padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),

         child: Row(

            children: [

              Expanded(
                  child:
              GestureDetector(
                onTap: () {

                  final cubit= BlocProvider.of<NearestStationCubit>(context);


                  Navigator.push(
                  context,PageRouteBuilder(

                    pageBuilder: (context, animation, secondaryAnimation) {


                      return FadeTransition(

                        opacity: animation,


                        child: MultiBlocProvider(

                          providers: [

                            BlocProvider.value(

                              value: cubit..
                              getNearestStationFromYourLocation(

                                  getIt<MapFeaturesCubit>()
                                      .state.currentLocation
                                      ),
                            ),


                          ],

                          child: NearestLocationFromLocation(),
                        ),
                      );



                    },
                  )
                  );

                },
                child: CustomAnimatedContainer(
                alignment: Alignment.center
                ,height: 200,
                    result: "Nearest station from your location", vision: true),
              )
              ),

              SizedBox(
                width: 20,
              ),

              Expanded(
                child: GestureDetector(
                  onTap: () {

                    final cubit= BlocProvider.of<NearestStationCubit>(context);

                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {

                          return FadeTransition(

                            opacity: animation,

                            child: MultiBlocProvider(

                              providers: [

                                BlocProvider.value(
                                  value: cubit,
                                ),

                              ],

                              child: NearStationFromYourTypedLocation(),
                            ),
                          );

                        },
                      ),
                    );
                  },
                  child: CustomAnimatedContainer(
                    alignment: Alignment.center,
                    height: 200,
                    result: "Nearest station from your typed location",
                    vision: true,
                  ),
                ),
              ),

            ],
          ),
       ),
      );

  }
}
