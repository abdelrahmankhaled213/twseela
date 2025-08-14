import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:twseela/features/History/logic/history_cubit.dart';
import 'package:twseela/features/History/ui/widgets/pop_button.dart';

import '../../../../core/constants/app_color.dart';

class CustomDateTimeLinePicker extends StatefulWidget {


  const CustomDateTimeLinePicker({super.key});

  @override
  State<CustomDateTimeLinePicker> createState() => _CustomDateTimeLinePickerState();
}

class _CustomDateTimeLinePickerState extends State<CustomDateTimeLinePicker> {

  DateTime? selectedDate;

  bool filterPriceAsc=false;


  @override
  Widget build(BuildContext context) {

    final now = DateTime.now();
    final previousWeek = now.subtract(const Duration(days: 7));
    final futureRange = now.add(const Duration(days: 14));


    const duration=Duration(
      days: 14
    );

    return Column(

      crossAxisAlignment: CrossAxisAlignment.end,

      children: [


        CustomPopMenu(

          selectedDate: selectedDate??DateTime.now(),

        ),

        EasyDateTimeLinePicker.itemBuilder(

          itemBuilder: (context, date, isSelected, isDisabled, isToday, onTap) {


            return GestureDetector(

              onTap: onTap,

              child: Container(

                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColor.primaryColor : AppColor.secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isToday ? Colors.blue : Colors.grey,
                  ),
                ),

                child: Column(

                  children: [

                    Text(
                      DateFormat('EE').format(date).toLowerCase(),

                      style: TextStyle(color: isSelected ? Colors.black : Colors.white),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      date.day.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelected ? Colors.black : Colors.white,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),


                  ],
                ),
              ),
            );
          },

          selectionMode: const SelectionMode.autoCenter(),

          onDateChange: (date) async{

            await context.read<HistoryCubit>().getCachedTripsDependsOnDate(date);

            setState(() {

              selectedDate = date;

            });
          },

          firstDate: previousWeek,

          lastDate: futureRange,
          focusedDate: selectedDate??DateTime.now(),
          itemExtent: 50,
        ),


      ],
    );
  }
}
