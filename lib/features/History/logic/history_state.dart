
import 'package:equatable/equatable.dart';
import 'package:twseela/features/GetRoute/model/metro_hive.dart';

enum HistoryStatus{
  initial,
  loading,
  loaded,
  error,

}

class HistoryState extends Equatable{

  final HistoryStatus historyStatus;
  final List<MetroModelHive>data;
  final String errorMsg;


const HistoryState({

    required this.historyStatus,
    required this.data,
    required this.errorMsg

});


HistoryState copyWith({

    bool? vision,
    HistoryStatus? historyStatus,
    List<MetroModelHive>?data,
     String? errorMsg

}){

  return HistoryState(

      historyStatus: historyStatus
          ??this.historyStatus
      , data: data?? this.data
      , errorMsg:errorMsg?? this.errorMsg );
}

  @override
  // TODO: implement props
  List<Object?> get props => [

    historyStatus,data,errorMsg,

  ];

@override
  String toString() {

    return '(HistoryStatus:$historyStatus ,data:${data.join(" , ")} '
        ', , errorMsg:$errorMsg)';

  }

}