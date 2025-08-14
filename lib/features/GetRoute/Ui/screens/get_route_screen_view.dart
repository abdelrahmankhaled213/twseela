import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela/features/GetRoute/Ui/widgets/carousel_slider.dart';
import 'package:twseela/features/GetRoute/Ui/widgets/twseela_stack.dart';
import 'package:twseela/features/Map/Widgets/build_floating_search.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/helpers/Flutter_dialog.dart';
import '../../../../core/helpers/flutter_toast_helper.dart';
import '../../../../core/widgets/OurCustomButton.dart';
import '../../logic/destination_cubit.dart';
import '../widgets/CustomAnimatedContainer.dart';
import '../widgets/select_start_and_end_drop.dart';

class GetRouteScreenView extends StatelessWidget {

  const GetRouteScreenView({super.key});

  @override
  Widget build(BuildContext context) {

    final destinationCubit = BlocProvider.of<DestinationCubit>(context);

    List<String> images = [
"assets/images/img_1.png",
"assets/images/img_3.png",
"assets/images/img_4.png",
    ];

    return Padding(

    padding: const EdgeInsets.symmetric( horizontal: 20),

    child: ListView(

    children: [

AppNameWidget(),


        MyCarousel(),

        SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height / 21
      ),

      const SelectStartAndEndDrop(),

    SizedBox(
    height: MediaQuery
        .of(context)
        .size
        .height / 21
    ),


    BlocListener<DestinationCubit,DestinationState>(

    listenWhen: (previous, current) {


    return current.isError || previous.isError;

    },

    listener: (context, state) {


    if(state.isError){

    showSnackBar(message: "Something went wrong" );

    }

    },

    child: BlocBuilder<DestinationCubit, DestinationState>(


    builder: (context, state) {


    if(state.isLoading){

    return  Center(

    child: CircularProgressIndicator(
    color: AppColor.primaryColor,
    ),
    );

    }


    return Column(

    children: [


    const SizedBox(height: 20,),


    GestureDetector(

    onLongPress: () => FlutterDialogHelper.dialogHelper(backgroundColor: AppColor.secondaryColor
        ,color: AppColor.primaryColor,context: context
      , message: state.firstList!,
    ),

    child: CustomAnimatedContainer(


    height: 150,
    vision: state.containerVision??false,
    result: state.firstList?? '0',

    ),
    ),

    const SizedBox(
    height: 10,
    ),

    if(state.secondList!.isNotEmpty)

    Column(

    children: [

    GestureDetector(

    onLongPress: () {

    FlutterDialogHelper.dialogHelper(
        backgroundColor: AppColor.secondaryColor,
        color: AppColor.primaryColor,
    context: context
    , message: state.secondList!);
    }

    ,child: CustomAnimatedContainer(
    height: 150,
    vision: state.containerVision??false,
    result: state.secondList??'0',

    ),
    ),

    const SizedBox(
    height: 10,
    ),

    GestureDetector(

    onLongPress: () => FlutterDialogHelper.dialogHelper(
        backgroundColor: AppColor.secondaryColor,
        color: AppColor.primaryColor,
    context: context
    , message:state.finalList??'0'),


    child: CustomAnimatedContainer(
    height: 150,
    vision: state.containerVision??false,
    result: state.finalList!,

    ),
    ),

    const SizedBox(
    height: 10,
    ),

    ],

    ),

    CustomAnimatedContainer(
    height: 60,
    vision: state.containerVision??false,
    result: '${state.numberOfStations} stations',

    ),


    const SizedBox(
    height: 10,
    ),

    CustomAnimatedContainer(

    height: 60,
    vision: state.containerVision??false,
result: "${state.timeExpected} min",
    ),


    const SizedBox(
    height: 10,
    ),

    CustomAnimatedContainer(
result: '${state.ticketPrice} EGP',
    height: 60,
    vision: state.containerVision??false,


    ),




    ]

    );

    },
    ),
    ),


    ],
    ),
    );
    }
    }

    void showSnackBar({required String message }){

    FlutterToastHelper.showToast(message, color: AppColor.secondaryColor);

    }

