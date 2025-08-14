import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:twseela/core/Hive/hive_services.dart';
import 'package:twseela/features/GetRoute/model/metro_hive.dart';

import 'history_state.dart';


class HistoryCubit extends Cubit<HistoryState> {

  HistoryCubit() : super( HistoryState(historyStatus: HistoryStatus.initial, data: [], errorMsg:''));

//   Future<void> getCachedTrips() async{
//
//     emit(state.copyWith(
//      historyStatus:  HistoryStatus.loading
//     ));
//
//
//     try{
//
// final data= List.from( await HiveService.getTrips());
//
//
// emit(
//     state.copyWith(
//   historyStatus: HistoryStatus.loaded,
//   data: data.cast<MetroModelHive>()
//
//     ));
//
//   } catch(e){
//
//
//     emit( state.copyWith(
//
//       historyStatus: HistoryStatus.error,
//       errorMsg: e.toString()
//     ))  ;
//     }
//
//   }

  Future<void> clearHistory() async{



    await HiveService.clearAllTrips();

    emit(

        state.copyWith(

      historyStatus: HistoryStatus.loaded,
            data: []

    ));

  }

  Future<void> getCachedTripsDependsOnDate(

      DateTime selectedDate, {
        bool sortByPriceAsc = false,
        bool sortByPriceDesc = false,
        bool sortByTimeAsc = false,
        bool sortByTimeDesc = false,

      })
  async {

    emit(state.copyWith(historyStatus: HistoryStatus.loading));

    try {
      final data = List.from(await HiveService.getTrips()).cast<MetroModelHive>();

      final filteredData = data.where((element) =>

      element.time.year == selectedDate.year &&
          element.time.day == selectedDate.day &&
          element.time.month==selectedDate.month
      ).toList();

      if (sortByPriceAsc) {
        filteredData.sort((a, b) => a.ticketPrice.compareTo(b.ticketPrice));
      } else if (sortByPriceDesc) {
        filteredData.sort((a, b) => b.ticketPrice.compareTo(a.ticketPrice));
      }
      else if(sortByTimeAsc){

        filteredData.sort((a, b) => a.expectedTime.compareTo(b.expectedTime));
      } else if (sortByTimeDesc){

        filteredData.sort((a, b) => b.expectedTime.compareTo(a.expectedTime));
      }else{

        filteredData.sort((a, b) => b.time.compareTo(a.time));
      }

      emit(state.copyWith(
          historyStatus: HistoryStatus.loaded,
          data: filteredData,
          vision: filteredData.isNotEmpty
      ));
    } catch (e) {
      emit(state.copyWith(
          historyStatus: HistoryStatus.error,
          errorMsg: e.toString()
      ));
    }
  }


}
