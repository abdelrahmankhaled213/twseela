part of 'bottom_navigation_cubit.dart';

@immutable
sealed class BottomNavigationState extends Equatable {}

final class BottomNavigationInitial extends BottomNavigationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

final class SwitchIndexState extends BottomNavigationState {

  final int? currentIndex;

  SwitchIndexState({
    this.currentIndex
});

  @override
  // TODO: implement props
  List<Object?> get props => [currentIndex];

}

