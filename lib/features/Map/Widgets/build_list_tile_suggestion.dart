import 'package:flutter/material.dart';
import 'package:twseela/features/Map/Data/model/auto_complete_response.dart';
import '../../../core/constants/app_color.dart';

class BuildListTileSuggestion extends StatelessWidget {

final PlaceSuggestion placeSuggestion;


  const BuildListTileSuggestion({super.key, required this.placeSuggestion});

  @override
  Widget build(BuildContext context) {
    final parts = placeSuggestion.description?.split(',');
    final mainTitle = parts!.isNotEmpty ? parts[0] : '';
    final subTitle = parts.length > 1 ? parts.sublist(1).join(',').trim() : '';
    List<TextSpan> textSpans = [

      TextSpan(
        text: mainTitle,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColor.secondaryColor,
        ),
      ),
      TextSpan(
        text: subTitle,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColor.secondaryColor,
        ),
      ),

    ];

    return
     Container(
      decoration: BoxDecoration(

        color: AppColor.primaryColor,
        // 👈 Background color for ListTile
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.primaryColor, width: 1),
      ),
      child: ListTile(
        title: RichText(

        text: TextSpan(
            children: [
              textSpans[0],
            ],
          ),
        ),
        subtitle: RichText(
          text: TextSpan(
            text: subTitle,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColor.secondaryColor,
            ),
          ),
        ),
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.secondaryColor,
          ),
          child: Icon(Icons.place, color: Colors.white),
        ),
        dense: true,
        style: ListTileStyle.list,
      ),
    );


  }
}
