import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:twseela/core/helpers/flutter_toast_helper.dart';
import 'package:twseela/features/Map/Widgets/build_floating_search.dart';
import 'package:twseela/features/Map/Widgets/distance_and_time.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_style.dart';
import '../../Data/model/direction_place.dart';
import '../logic/map_features_cubit.dart';
import '../logic/map_features_state.dart';

class MapScreenView extends StatefulWidget {
  const MapScreenView({super.key});

  @override
  State<MapScreenView> createState() => _MapScreenView();
}

class _MapScreenView extends State<MapScreenView> {



  @override
  void initState() {

    super.initState();

    getMyCurrentLocation();

  }

  Future<void> getMyCurrentLocation() async {

  final cubit =  context.read<MapFeaturesCubit>();

    try {


      CameraPosition myLocation = CameraPosition(
        bearing: 0.0,
        zoom: 20,
        tilt: 0,
        target: LatLng(cubit.state.currentLocation?.latitude ?? 0
            , cubit.state.currentLocation?.longitude ?? 0),
      );

      context.read<MapFeaturesCubit>().setHomeLocationNowCamera(myLocation);


    } catch (e) {
      debugPrint("error: ${e.toString()}");
    } finally {
      setState(() {});
    }
  }


  LatLng? start;
  LatLng? end;

  CameraPosition get _myLocationNowCamera => CameraPosition(
    bearing: 0.0,
    zoom: 20,
    tilt: 0,
    target: LatLng(
        context.read<MapFeaturesCubit>().state.currentLocation?.latitude ?? 0
        , context.read<MapFeaturesCubit>().state.currentLocation?.longitude ?? 0), //LatLng(position?.latitude ?? 0, position?.longitude ?? 0),
  );

  @override
  Widget build(BuildContext context) {

    final cubit = context.read<MapFeaturesCubit>();
    final currentState = context.watch<MapFeaturesCubit>().state;



    return Scaffold(

      body: cubit.state.currentLocation == null

          ? Center(

        child: CircularProgressIndicator(

          backgroundColor: AppColor.secondaryColor,
          color: AppColor.primaryColor,

        ),
      )
          :  Stack(

        children: [

          buildMap(),

          BuildFloatingSearch(),

          BlocBuilder<MapFeaturesCubit, MapFeaturesState>(

            builder: (context, state) {


                return DistanceAndTime(

                  directionPlace: state.directionPlace ??
                      DirectionPlace(
                        polyLines: [],
                        totalDistance: "0.0",
                        totalDuration: "0.0",
                        bounds: null,
                      ),

                  isShown: state.isShownTimeAndDistance!,
                );



            },
          ),

        ],
      ),

      floatingActionButton:

      Container(

        margin: const EdgeInsetsDirectional.fromSTEB(8, 10, 7, 10),

        child: FloatingActionButton(

          backgroundColor: AppColor.primaryColor,

          onPressed: () => _returnToMyLocation(context),

          child: const Icon(Icons.place, color: Colors.white),
        ),
      ),
    );
  }

  Widget buildMap() {

    return BlocConsumer<MapFeaturesCubit, MapFeaturesState>(
      listener: (context, state) {

        if (state.mapsState == MapsStateEnum.getDirectionsSuccess) {

          if (kDebugMode) {

            print("polyLinesPoints: ${state.polyLinesPoints}");

          }

        }
        if (state.mapsState == MapsStateEnum.getDirectionsError) {

          FlutterToastHelper.showToast(state.errorMsg!);
        }
      },

      listenWhen: (previous, current) =>
      previous.mapsState != current.mapsState &&
          (current.mapsState == MapsStateEnum.getDirectionsSuccess ||
              current.mapsState == MapsStateEnum.getDirectionsError),
      buildWhen: (previous, current) =>

      previous.mapsState != current.mapsState &&
          (
              current.mapsState == MapsStateEnum.refreshGoogleMap ||
              current.mapsState == MapsStateEnum.getDirectionsSuccess ||
              current.mapsState == MapsStateEnum.isShownDistanceAndTime
          ),

      builder: (context, state) {

        final currentState = context.watch<MapFeaturesCubit>().state;


        return GoogleMap(

          polylines:
          {

            Polyline(
              polylineId: const PolylineId('1'),
              points: state.polyLinesPoints ?? [],
              color: AppColor.secondaryColor,
              width: 3,
              endCap: Cap.roundCap,


            ),
          },


          mapType: MapType.normal,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          markers: state.markers ?? {},
          initialCameraPosition: _myLocationNowCamera,
          myLocationButtonEnabled: false,
          onMapCreated: (controller) {
            context.read<MapFeaturesCubit>().setGoogleMapController(controller);
          },
        );
      },
    );
  }


  void _returnToMyLocation(BuildContext context) async {
    final controller = await context.read<MapFeaturesCubit>().googleMapController;
    controller.animateCamera(CameraUpdate.newCameraPosition(_myLocationNowCamera));
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: const Icon(Icons.menu, color: AppColor.secondaryColor),
        ),
      ),
      backgroundColor: AppColor.primaryColor,
      title: Text(
        "Twseela",
        style: AppStyle.libreSemiBoldMaroon.copyWith(letterSpacing: 2),
      ),
    );
  }
}
