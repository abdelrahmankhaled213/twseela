import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {

  BottomNavigationCubit() : super(SwitchIndexState(currentIndex: 0));


  void switchIndex(int currentIndex){

    emit(SwitchIndexState(
      currentIndex: currentIndex
    ));

  }
}
