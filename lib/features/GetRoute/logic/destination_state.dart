part of 'destination_cubit.dart';

enum DestinationStatus {
  initial,
  loading,
  loaded,
  error,
  dropdown1,
  dropdown2,
  changeDropDown,
  valid, // Optional: for success after validation
}

extension DestinationStateExtension on DestinationState {
  bool get isInitial => status == DestinationStatus.initial;
  bool get isLoading => status == DestinationStatus.loading;
  bool get isLoaded => status == DestinationStatus.loaded;
  bool get isError => status == DestinationStatus.error;
}

class DestinationState extends Equatable {
  final DestinationStatus status;
  final String? dropDownValue1;
  final String? dropDownValue2;
  final String? errorMsg;
  final String? firstList;
  final int? timeExpected;
  final num? ticketPrice;
  final int? numberOfStations;
  final bool containerVision;
   String? secondList;
   String? finalList;

   DestinationState({

    this.status = DestinationStatus.initial,
    this.dropDownValue1 = MetroConstants.pleaseSelect,
    this.dropDownValue2 = MetroConstants.pleaseSelect,
    this.errorMsg,
    this.firstList = '',
    this.ticketPrice,
    this.timeExpected,
    this.numberOfStations,
    this.containerVision = false,
    this.secondList = '',
    this.finalList = '',
  });

  DestinationState copyWith({
    DestinationStatus? status,
    String? dropDownValue1,
    String? dropDownValue2,
    String? errorMsg,
    String? firstList,
    String? secondList,
    String? finalList,
    int? timeExpected,
    num? ticketPrice,
    int? numberOfStations,
    bool? containerVision,
  }) {
    return DestinationState(
      status: status ?? this.status,
      dropDownValue1: dropDownValue1 ?? this.dropDownValue1,
      dropDownValue2: dropDownValue2 ?? this.dropDownValue2,
      errorMsg: errorMsg ?? this.errorMsg,
      firstList: firstList ?? this.firstList,
      secondList: secondList ?? this.secondList,
      finalList: finalList ?? this.finalList,
      timeExpected: timeExpected ?? this.timeExpected,
      ticketPrice: ticketPrice ?? this.ticketPrice,
      numberOfStations: numberOfStations ?? this.numberOfStations,
      containerVision: containerVision ?? this.containerVision,
    );
  }

  @override
  List<Object?> get props => [
    status,
    dropDownValue1,
    dropDownValue2,
    errorMsg,
    firstList,
    secondList,
    finalList,
    timeExpected,
    ticketPrice,
    numberOfStations,
    containerVision,
  ];
}
