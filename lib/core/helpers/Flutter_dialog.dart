import 'package:flutter/material.dart';
import 'package:twseela/core/constants/app_color.dart';
import 'package:twseela/core/helpers/flutter_style_helper.dart';

import '../constants/app_style.dart';


class FlutterDialogHelper {


  static void dialogHelper({

    required BuildContext context
    , required String message,
      required Color color,
    required Color backgroundColor

  }) {

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dialog",
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Center(
          child: Material(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: EdgeInsets.all(20),
              width: 500,
              child: Text(message,style: AppStyle.wLibre400black.copyWith(
                fontWeight: FontWeightHelper.semiBold,
                color: color
              ),),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {

        return ScaleTransition(

          scale: CurvedAnimation(parent: anim1
              , curve: Curves.fastOutSlowIn),

            child: child,

        );
      },
    );
  }
}
