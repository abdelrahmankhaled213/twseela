import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_style.dart';

class AppNameWidget extends StatelessWidget {

  const AppNameWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return SizedBox(

      height: 200,

      child: Stack(

        alignment: Alignment.center,

        children: [

          SvgPicture.asset(

              "assets/images/half_curve_maroon.svg",


          ),


          Positioned(

            top: 30,

            child: Text("Twseela"

              , style: AppStyle.libreSemiBoldMaroon.copyWith(

                letterSpacing: 3,

                fontSize: 35,

              fontWeight: FontWeight.bold,

              color: AppColor.primaryColor
            ),
            ),
          ),

        ],
      ),
    );
  }
}
