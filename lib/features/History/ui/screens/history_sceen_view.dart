import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twseela/features/History/logic/history_cubit.dart';
import 'package:twseela/features/History/logic/history_state.dart';
import 'package:twseela/features/History/ui/widgets/custom_container_history.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/helpers/Flutter_dialog.dart';
import '../widgets/date_time_line_picker.dart';

class HistoryScreenView extends StatefulWidget {

  const HistoryScreenView({super.key});

  @override
  State<HistoryScreenView> createState() => _HistoryScreenViewState();

}

class _HistoryScreenViewState extends State<HistoryScreenView> {


  @override
  Widget build(BuildContext context) {

    const duration= Duration(

      seconds: 2

    );

    return SafeArea(

      child: ListView(



          children: [


          CustomDateTimeLinePicker(),


           BlocBuilder<HistoryCubit, HistoryState>(

buildWhen: (previous, current) {

  return previous!=current;

  },
          builder: (context, state) {


          if(state.historyStatus == HistoryStatus.loaded) {

            if(state.data.isEmpty){

              return SizedBox(
                height: MediaQuery.of(context).size.height*0.5,
                child: Center(
                  child: Image.asset("assets/images/img_6.png",width: 300,
                  height: 300
                  ,),
                ),
              );

            }

            if (state.data.isNotEmpty) {

              return Padding(

                padding: EdgeInsets.symmetric(

                    horizontal: 20,
                    vertical: 10

                ),

                child: ListView.separated(

                shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),

                    itemBuilder: (context, index) {


                      return GestureDetector(

                        onLongPress: () =>
                            FlutterDialogHelper.dialogHelper
                              (backgroundColor: AppColor.primaryColor
                                ,color: AppColor.secondaryColor,context: context
                            , message: "${state.data[index].firstRoute} \n \n"
                                    " ${state.data[index].secondRoute
                                !} \n \n ${state.data[index].thirdRoute!}"),

                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30
                          ),
                          child: CustomContainerHistory(
myTime: state.data[index].time,
                            ticketPrice: state.data[index].ticketPrice,
                          time: state.data[index].expectedTime,
                            height: 150,

                            result: "${state.data[index]
                                .start}  to  ${state.data[index]
                                .end}",

                          ),
                        ),
                      );
                    },

                    addAutomaticKeepAlives: true

                    , separatorBuilder: (context, index) {

                      return const SizedBox(height: 18);
                                                           }
                , itemCount: state.data.length

                ),
              );
            }
          }

          if (state.historyStatus == HistoryStatus.loading) {

          return CircularProgressIndicator(

            color: AppColor.secondaryColor,

          );

          }


          return SizedBox.shrink();

          },

          ),
       ]

      ),
    );

  }
}
