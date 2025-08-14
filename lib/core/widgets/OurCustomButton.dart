import 'package:flutter/material.dart';

import '../constants/app_color.dart';
import '../constants/app_style.dart';

class CustomButton extends StatelessWidget {

  final String? text;
  final Function()? onClick;
  final Color? color;

const CustomButton({
   this.text,
  this.onClick,
  this.color,
  super.key
});

  @override

  Widget build(BuildContext context) {

    return SizedBox(

      width: MediaQuery.of(context).size.width,
        height: 53,

        child: ElevatedButton(

        onPressed:onClick
        ,

        style: ElevatedButton.styleFrom(

          backgroundColor: color,

          elevation: 15,
          padding: const EdgeInsets.all(10),

          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(15),
          ),


      ), child:
    Text(text!,
    style: AppStyle.wLibre400black,

        ),

    )
    );
 }
}
