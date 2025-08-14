import 'dart:async';

class AutoCompleteDeBouncer {

  final Duration duration;
  Timer? _timer;

  AutoCompleteDeBouncer({required this.duration,});



  void call(void Function() action) {

    _timer?.cancel();
    _timer = Timer(duration, action);
  }

void close(){

_timer?.cancel();

}

}