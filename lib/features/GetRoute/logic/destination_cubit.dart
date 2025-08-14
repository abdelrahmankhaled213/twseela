import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:twseela/core/Hive/hive_services.dart';
import 'package:twseela/features/GetRoute/model/metro_hive.dart';

import '../../../core/constants/MetroConstants.dart';
import '../model/metro _lines.dart';

part 'destination_state.dart';

class DestinationCubit extends Cubit<DestinationState> {


   DestinationCubit() : super(

        DestinationState(

         status: DestinationStatus.initial,

       )

   );


   void selectFromFirstDropdown(String? item) {

     final drop2 = state.dropDownValue2;

     final isValidSelection = item != MetroConstants.pleaseSelect &&
         drop2 != MetroConstants.pleaseSelect &&
         item != drop2;

     emit(
       state.copyWith(
         dropDownValue1: item,
         status: DestinationStatus.dropdown1,
         containerVision: isValidSelection,
       ),
     );

     if (isValidSelection) {
       getDest();
     }
   }



   void selectFromSecondDropdown(String? item) {

     final drop1 = state.dropDownValue1;

     emit(
       state.copyWith(
         dropDownValue2: item,
         status: DestinationStatus.dropdown2,
         errorMsg: '',
       ),
     );

     final isValidSelection = item != MetroConstants.pleaseSelect &&
         drop1 != MetroConstants.pleaseSelect &&
         item != drop1;

     if (!isValidSelection) {
       emit(
         state.copyWith(
           containerVision: false,
           status: DestinationStatus.error,
           errorMsg: (item == drop1)
               ? 'please choose different stations'
               : 'please choose your destination',
         ),
       );
       return;
     }

     emit(state.copyWith(containerVision: true));
     getDest();
   }

   void changeDropDownValues() {

     final value1 = state.dropDownValue1;
     final value2 = state.dropDownValue2;



     final isValidSelection = value1 != MetroConstants.pleaseSelect &&
         value2 != MetroConstants.pleaseSelect &&
         value1 != value2;

     if (!isValidSelection) {
       emit(
         state.copyWith(
           containerVision: false,
           status: DestinationStatus.error,
           errorMsg: (value1 == value2)
               ? 'please choose different stations'
               : 'please choose your destination',
         ),
       );
       return;
     }

     // Swap values

     emit(
       state.copyWith(
         dropDownValue1: value2,
         dropDownValue2: value1,
         status: DestinationStatus.dropdown2,
         errorMsg: '',
         containerVision: true
       ),
     );

     getDest();

   }





void getDest(){


   List<String> line1;
   List<String> line2;
   List<String> line3;




    emit( state.copyWith( status: DestinationStatus.loading ),);

 state.secondList='';
    state.finalList='';




var indexOfLine1EndsWith=MetroLines.allLines.indexOf(MetroConstants.newElMarg);
var indexOfLine2EndsWith=MetroLines.allLines.indexOf(MetroConstants.ShobraElKheima);
var indexOfLine3EndsWith=MetroLines.allLines.indexOf(MetroConstants.roadAlFarag);

line1=MetroLines.allLines.sublist(0,indexOfLine1EndsWith+1);
line2=MetroLines.allLines.sublist(indexOfLine1EndsWith+1,indexOfLine2EndsWith+1);
line3=MetroLines.allLines.sublist(indexOfLine2EndsWith+1,indexOfLine3EndsWith+1);


if( line1.contains(state.dropDownValue1)
    && line1.contains(state.dropDownValue2) ){

  _normalLines(whichLine: line1);

}

else if(line2.contains(state.dropDownValue1) && line2.contains(state.dropDownValue2)){

  _normalLines(whichLine: line2);

}

else if(line3.contains(state.dropDownValue1) && line3.contains(state.dropDownValue2)){

  _normalLines(whichLine: line3);

}


else if(line1.contains(state.dropDownValue1) &&
    line2.contains(state.dropDownValue2)){

  _mergeLines( firstLine: line1, secondLine: line2
    , midPoint: MetroConstants.alShohadaa);

}


else if(line1.contains(state.dropDownValue1) && line3.contains(state.dropDownValue2)){

  _mergeLines( firstLine: line1, secondLine: line3
      , midPoint: MetroConstants.nasser);

}

else if(line2.contains(state.dropDownValue1) && line3.contains(state.dropDownValue2)){

  _mergeLines(
      firstLine: line2, secondLine: line3
      , midPoint: MetroConstants.Ataba);

}


else if(line3.contains(state.dropDownValue1) && line2.contains(state.dropDownValue2)){

  _mergeLines( firstLine: line3, secondLine: line2
      , midPoint: MetroConstants.Ataba);

}


else if(line3.contains(state.dropDownValue1) && line1.contains(state.dropDownValue2)){

  _mergeLines( firstLine: line3, secondLine: line1
      , midPoint: MetroConstants.nasser);

}
else{

 _mergeLines(firstLine: line2, secondLine: line1, midPoint: MetroConstants.alShohadaa);

}

final metroHive= MetroModelHive(
  noOFStation: state.numberOfStations!,
    secondRoute: state.secondList,
    thirdRoute: state.finalList,
    ticketPrice:
    state.ticketPrice!
    , expectedTime: state.timeExpected!, time: DateTime.now()
    , end: state.dropDownValue2!, start:state.dropDownValue1!
    , firstRoute: state.firstList!);

try {
  HiveService.addTrip(metroHive);
  debugPrint("added successFully");
  
}catch(e){

  print(e.toString());
}
}




  void _normalLines({

    required List<String>whichLine,

  }
  )

  {

 final startIndex=whichLine.indexOf(state.dropDownValue1!);

 final endIndex=whichLine.indexOf(state.dropDownValue2!);

  List<String> subList=[];

  int numberStation=0;

  if(startIndex<endIndex){


  subList= List.from(whichLine.sublist(startIndex,endIndex+1));

  numberStation=endIndex-startIndex;

  emit(

    state.copyWith(

containerVision:true ,

      status: DestinationStatus.loaded,

      firstList: '${subList.join("  ,  ")} ',

      numberOfStations:

      numberStation ,

      ticketPrice: _ticketPrice(numberStation),

      timeExpected:(endIndex-startIndex)*4 ,


    ),
  );

  }

  else{

    subList=List.from(

        subList=whichLine.sublist(endIndex,startIndex+1));

    numberStation=startIndex-endIndex;


    emit(

        state.copyWith(

            containerVision: true,

            status: DestinationStatus.loaded,

    firstList  : subList.reversed.toList().join("  ,  "),

            ticketPrice:
            _ticketPrice(numberStation),

            timeExpected:(startIndex-endIndex)*4,

            numberOfStations: numberStation

        ),
    );

  }

  }

void _mergeLines({

  required List<String>firstLine,
  required List<String>secondLine,
  required String midPoint
}){

    final startIndex=firstLine.indexOf(state.dropDownValue1!);

    final endIndex=secondLine.indexOf(state.dropDownValue2!);

    final mid1=firstLine.indexOf(midPoint);

    final mid2=secondLine.indexOf(midPoint);

    List<String>subList1=[];

    List<String>subList2=[];

    List<String>finalTrip=[];


    if(startIndex<mid1 &&endIndex<mid2){

    subList1=List.from(firstLine.sublist(startIndex,mid1+1));
log(secondLine.sublist(endIndex,mid2+1).toString());

subList2=List.from(secondLine.sublist(endIndex,mid2+1).reversed);

    finalTrip=subList1+subList2.toList();

log(finalTrip.toString());

  }



    else if(startIndex>mid1&&endIndex>mid2){

      subList1=List.from(firstLine.sublist(mid1,startIndex+1).reversed);

    subList2=List.from(secondLine.sublist(mid2,endIndex+1));

    finalTrip=subList1.toList()+subList2;

  }
    else if(startIndex >mid1&&endIndex<mid2){


subList1= List.from( firstLine.sublist(mid1,startIndex+1).reversed);

      subList2= List.from( secondLine.sublist(endIndex,mid2+1));

      finalTrip=subList1 + subList2.reversed.toList();


  }



  else{

    subList1=List.from(firstLine.sublist(startIndex,mid1+1));

    subList2=List.from(secondLine.sublist(mid2,endIndex+1));

    finalTrip=subList1+subList2;

  }

  if(_isFoundMoreThanOnce(finalTrip, midPoint)){

    finalTrip.remove(midPoint);

    var wholeNumberOfStation =
        finalTrip.indexOf(state.dropDownValue2!)
            - finalTrip.indexOf(state.dropDownValue1!);

    emit(

      state.copyWith(

      status: DestinationStatus.loaded,

      firstList: 'First Trip     ${subList1.join(' , ')}',

          secondList: 'Second Trip   ${subList2.join(' , ')}',

          finalList: 'Final Trip   ${finalTrip.join(' , ')}',

          numberOfStations: wholeNumberOfStation ,

          ticketPrice: _ticketPrice(wholeNumberOfStation),

      timeExpected:  wholeNumberOfStation*4 ,

      containerVision: true


    ),
    );

  }
  }




}

  bool _isFoundMoreThanOnce(List<String>finalTrip,String midPoint){

    int counter=0;

    for(var station in finalTrip){

      if(station==midPoint){
       counter++;
      }
    }

    return counter>1;
  }


  num _ticketPrice(int numberStation) {

    var ticketPrice=0;

    if (0<numberStation && numberStation<=9 ){

      ticketPrice = 5;

    }

    else if (numberStation > 9 && numberStation <= 16){

      ticketPrice = 8;

    }

    else {
      ticketPrice = 10;
    }


    return  ticketPrice ;

  }
