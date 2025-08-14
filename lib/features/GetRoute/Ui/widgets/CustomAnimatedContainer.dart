import 'package:flutter/material.dart';
import 'package:twseela/core/constants/app_color.dart';
import 'package:twseela/core/helpers/flutter_style_helper.dart';

import '../../../../core/constants/app_style.dart';

class CustomAnimatedContainer extends StatefulWidget {
final String result;
  final bool vision;
  final double height;
  final Alignment? alignment;
  final double? textSize;

  const CustomAnimatedContainer({
    required this.height,
required this.result,
    required this.vision,
    super.key,
   this.alignment,
    this.textSize,

  });

  @override
  _CustomAnimatedContainerState createState() => _CustomAnimatedContainerState();
}

class _CustomAnimatedContainerState extends State<CustomAnimatedContainer> {

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.vision ? 1.0 : 0.0, // Fade in/out
      duration: const Duration(seconds: 2),
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        curve: Curves.easeInOut, // Better animation curve
        height: widget.vision ? widget.height : 0, // Animate height
        duration: const Duration(seconds: 1),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.secondaryColor,
          border: Border.all(color:Colors.black),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: AppColor.secondaryColor,
              offset:  Offset(3, 4),
              blurRadius: 7,
            )
          ],
        ),
        child: widget.vision
            ? Align(
          alignment:widget.alignment??Alignment.topLeft,
              child: Text(
                        widget.result,
                        style: AppStyle.libreSemiBoldMaroon.copyWith(
                          fontSize: widget.textSize??23,
              fontWeight: FontWeightHelper.semiBold,
              color: AppColor.primaryColor
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,

                      ),
            )
            : null, // Avoid unnecessary rebuilds
      ),
    );
  }
}
