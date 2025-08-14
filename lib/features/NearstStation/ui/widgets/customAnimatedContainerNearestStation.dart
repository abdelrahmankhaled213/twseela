import 'package:flutter/material.dart';
import 'package:twseela/core/constants/app_color.dart';
import 'package:twseela/core/helpers/flutter_style_helper.dart';

import '../../../../core/constants/app_style.dart';

class CustomAnimatedContainerNearestStation extends StatelessWidget {

  final String result;

  final double height;

  final int index;
final double distance;

   const CustomAnimatedContainerNearestStation({

    required this.height,
    required this.result,
    required this.index,
     required this.distance,
    super.key,

   });

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(

      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

        curve: Curves.easeInOut, // Better animation curve

        duration: const Duration(seconds: 1),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.secondaryColor,
        border: Border.all(color:Colors.black),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: AppColor.primaryColor,
            offset:  Offset(3, 4),
            blurRadius: 7,
          )
        ],
      ),
      child:
          ListTile(

            leading: CircleAvatar(
             backgroundColor: AppColor.primaryColor,
              radius: 50,
              child: Text(index.toString() ,
                style: AppStyle.libreSemiBoldMaroon.copyWith(
                  fontWeight: FontWeightHelper.semiBold,
                  color: AppColor.secondaryColor
              ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),

       title: Text(

         result,style: AppStyle.libreSemiBoldMaroon.copyWith(
         color: AppColor.primaryColor
       )
       ),

            subtitle: Text("${distance.toStringAsFixed(3)} km",
                style: AppStyle.libreSemiBoldMaroon.copyWith(
                    color: AppColor.primaryColor
                )
            ),

       // Avoid unnecessary rebuilds
    )
    );

  }
}
