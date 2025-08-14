import 'package:flutter/material.dart';
import 'package:twseela/core/constants/app_color.dart';

import '../helpers/flutter_style_helper.dart';

abstract class AppStyle {

  static const TextStyle wLibre400black =

  TextStyle(

      fontWeight: FontWeight.w400,

      color: Colors.black,

      fontFamily: 'Libre Caslon',

      fontSize: 18

  );

  static const TextStyle libreSemiBoldMaroon =

  TextStyle(

      fontWeight: FontWeightHelper.semiBold,

      color: AppColor.secondaryColor,

      fontFamily: 'Libre Caslon',

      fontSize: 18

  );

}
