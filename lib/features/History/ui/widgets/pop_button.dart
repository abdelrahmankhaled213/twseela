import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela/features/History/logic/history_state.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/helpers/flutter_style_helper.dart';
import '../../logic/history_cubit.dart';

class CustomPopMenu extends StatefulWidget {
  final DateTime selectedDate;

  const CustomPopMenu({super.key, required this.selectedDate});

  @override
  State<CustomPopMenu> createState() => _CustomPopMenuState();
}

class _CustomPopMenuState extends State<CustomPopMenu> {


  bool isVisiable=false;

  @override
  Widget build(BuildContext context) {

    return BlocListener<HistoryCubit,HistoryState>(

      listener: (context, state) {

          isVisiable=state.data.isNotEmpty;

      },

      child:

      PopupMenuButton<String>(
        elevation: 12,
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(15),
        icon: const Icon(Icons.filter_list, color: AppColor.secondaryColor),

        onSelected: (String value) {

          switch (value) {

            case 'clear':
              context.read<HistoryCubit>().clearHistory();
              break;

            case 'asc':

              setState(() {});
              context.read<HistoryCubit>().getCachedTripsDependsOnDate(
                widget.selectedDate,
                sortByPriceAsc: true,
                sortByPriceDesc: false,
              );
              break;

            case 'desc':
              setState(() {});
              context.read<HistoryCubit>().getCachedTripsDependsOnDate(
                widget.selectedDate,
                sortByPriceAsc: false,
                sortByPriceDesc: true,
              );
              break;

            case 'ascTime':

              setState(() {});
              context.read<HistoryCubit>().getCachedTripsDependsOnDate(
                widget.selectedDate,
sortByTimeAsc: true,
                sortByTimeDesc: false
              );
              break;

            case 'descTime':

              setState(() {});
              context.read<HistoryCubit>().getCachedTripsDependsOnDate(
                widget.selectedDate,

                  sortByTimeAsc: false,
                  sortByTimeDesc: true
              );
              break;



          }
        },

        itemBuilder: (context) => [

          PopupMenuItem(
            value: 'clear',
            enabled: isVisiable,
            child: Center(
              child: Text(
                "Clear History",
                style: AppStyle.wLibre400black.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
            ),
          ),
          PopupMenuItem(
            value: 'asc',
            enabled: isVisiable,
            child: Center(
              child: Text(
                "Lowest to Highest Price",
                style: AppStyle.wLibre400black.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
            ),
          ),

          PopupMenuItem(
            value: 'desc',
            enabled: isVisiable,
            child: Center(
              child: Text(
                "Highest to Lowest Price",
                style: AppStyle.wLibre400black.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
            ),
          ),

          PopupMenuItem(
            value: 'ascTime',
            enabled: isVisiable,
            child: Center(
              child: Text(
                "Short to Long Time",
                style: AppStyle.wLibre400black.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
            ),
          ),

          PopupMenuItem(
            value: 'descTime',
            enabled: isVisiable,
            child: Center(
              child: Text(
                "Long to Short Time",
                style: AppStyle.wLibre400black.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
