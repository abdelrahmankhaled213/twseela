import 'package:flutter/material.dart';

import '../../../core/constants/app_color.dart';
import '../Data/model/direction_place.dart';

class DistanceAndTime extends StatelessWidget {

  final DirectionPlace directionPlace;
  final bool isShown;

  const DistanceAndTime({
    super.key,
    required this.directionPlace,
    required this.isShown,
  }
  );

  @override
  Widget build(BuildContext context) {

    return Visibility(

      visible: isShown,

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildInfoCard(
              icon: Icons.access_time_filled,
              value: directionPlace.totalDuration ?? 'N/A',
              iconColor: AppColor.primaryColor,
            ),
            _buildInfoCard(
              icon: Icons.directions_car_filled_rounded,
              value: directionPlace.totalDistance ?? 'N/A',
              iconColor: AppColor.secondaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String value,
    required Color iconColor,
  }) {
    return Flexible(
      flex: 1,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        color: Colors.white,
        child: ListTile(
          horizontalTitleGap: 0,
          dense: true,
          title: Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: Icon(icon, size: 30, color: iconColor),
        ),
      ),
    );
  }
}
