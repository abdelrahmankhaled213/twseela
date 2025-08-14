import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_style.dart';

class CustomContainerHistory extends StatelessWidget {

  final String result;

  final double height;

  final num ticketPrice;

  final int time;

  final DateTime myTime;

  const CustomContainerHistory({super.key
    , required this.result, required this.height,
  required this.myTime
    , required this.ticketPrice,required this.time});

  @override
  Widget build(BuildContext context) {

         return AnimatedContainer(

        height: height,

             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        curve: Curves.easeInOut, // Better animation curve
        duration: const Duration(seconds: 1),
        width: double.infinity,
        decoration: BoxDecoration(

          color: AppColor.primaryColor,

          border: Border.all(color:AppColor.secondaryColor),

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

visualDensity: VisualDensity.comfortable,

          isThreeLine: true,

          title: Text(
             result ,style: AppStyle.libreSemiBoldMaroon.copyWith(
              color: AppColor.secondaryColor,


          )
          ),
style: ListTileStyle.drawer,

         subtitle:    Row(

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$ticketPrice EGP',
                      style: AppStyle.libreSemiBoldMaroon.copyWith(
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    Text(
                      '$time min',
                      style: AppStyle.libreSemiBoldMaroon.copyWith(
                        color: AppColor.secondaryColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Adds space between the two columns
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('h:mm a').format(myTime), // This will show "9:30 AM" or "2:45 PM"
                      style: AppStyle.libreSemiBoldMaroon.copyWith(
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    Text(
                      DateFormat('MMM d, y').format(myTime), // Optional: Shows date like "May 5, 2023"
                      style: AppStyle.libreSemiBoldMaroon.copyWith(
                        color: AppColor.secondaryColor,
                        fontSize: 12, // Smaller font for date
                      ),
                    ),
                  ],
                ),
              ],
            )
         )

    );

  }
}
