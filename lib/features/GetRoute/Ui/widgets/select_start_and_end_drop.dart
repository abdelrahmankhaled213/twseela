import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:twseela/core/constants/MetroConstants.dart';

import 'package:twseela/core/constants/app_style.dart';


import 'package:twseela/features/Map/presentation/logic/map_features_state.dart';

import '../../../../core/constants/app_color.dart';

import '../../../../core/cubit/bottom_navigation_cubit.dart';

import '../../../../core/widgets/DropDownMenu.dart';

import '../../../Map/presentation/logic/map_features_cubit.dart';

import '../../logic/destination_cubit.dart';

class SelectStartAndEndDrop extends StatefulWidget {

  const SelectStartAndEndDrop({super.key});

  @override
  State<SelectStartAndEndDrop> createState() => _SelectStartAndEndDropState();
}

class _SelectStartAndEndDropState extends State<SelectStartAndEndDrop> {

  bool isPressed = true;

  LatLng? start;


  @override
  Widget build(BuildContext context) {

    return MultiBlocListener(

      listeners: [

        BlocListener<DestinationCubit, DestinationState>(

          listener: (context, state) {


            if (state.status == DestinationStatus.dropdown2
                || state.status == DestinationStatus.dropdown1
                &&
                state.containerVision == true
            ) {

              final snackBar = SnackBar(

                  backgroundColor: AppColor.primaryColor,
                  action: SnackBarAction(
                  label: "press here",
                  onPressed: _onPressed,
                  backgroundColor: AppColor.secondaryColor,
                  textColor: Colors.white,
                ),
                content: Text("Show in Map", style: AppStyle.libreSemiBoldMaroon),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }











          }),

        BlocListener<MapFeaturesCubit, MapFeaturesState>(

          listener: (context, state) async {

            final mapCubit = context.read<MapFeaturesCubit>();


            if(state.mapsState==MapsStateEnum.getLatLongFromStartSuccess){

try{

              if(!mounted){
                return;
              }


              start = LatLng(state.getLatFromStart!
                  , state.getLongFromStart!);

              await mapCubit.getDirectionsPlace( toLatLong(
                  mapCubit.state.currentLocation!), start!);



                final GoogleMapController controller =

                await mapCubit
                    .googleMapController;


                await controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                    CameraPosition(target: start??LatLng(0,0),tilt: 17,zoom: 20,)));



              mapCubit.showDistanceAndTime();

                mapCubit.setMarker(

                  Marker(markerId: MarkerId("3")
                      ,
                      position:start!


                  ) ,

                  Marker(markerId: MarkerId("4")
                      ,
                      position:toLatLong(mapCubit.state.currentLocation!)


                  ) ,

                );


            }catch(e){

  debugPrint(e.toString());

            }

}

          }



        ),

      ],


      child: BlocBuilder<DestinationCubit, DestinationState>(

        buildWhen: (previous, current) {
          return
            (previous.dropDownValue1 != current.dropDownValue1 ||

                previous.dropDownValue2 != current.dropDownValue2)
                &&
                (

                    current.status == DestinationStatus.dropdown1
                        ||
                        current.status == DestinationStatus.dropdown2 ||

                        current.status == DestinationStatus.changeDropDown

                );
        },

        builder: (context, state) {

          final destinationCubit = BlocProvider.of<DestinationCubit>(context);

          return Column(

            children: [


              CustomDropMenuItem(

selected: state.dropDownValue1,

                onChanged: destinationCubit.selectFromFirstDropdown,


              ),


              IconButton(

                onPressed:
                    destinationCubit.changeDropDownValues,


                icon: const Align(alignment: Alignment.centerRight,

                  child: Icon(
                    Icons.repeat, color: AppColor.secondaryColor, size: 30,),
                ),

              ),

              CustomDropMenuItem(

selected: state.dropDownValue2,

                onChanged: destinationCubit.selectFromSecondDropdown,

              ),


            ],
          );
        },

      ),
    );
  }

  void _onPressed() async {

    final bottomNavigationCubit=
    context.read<BottomNavigationCubit>();

    final start = context
        .read<DestinationCubit>()
        .state
        .dropDownValue1;



     await context.read<MapFeaturesCubit>()
         .getLatLongFromStart(start!);

    bottomNavigationCubit.switchIndex(3);




  }

}

LatLng toLatLong(Position position){
  return LatLng(position.latitude,position.longitude);
}