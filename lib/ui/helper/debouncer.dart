import 'dart:async';

Function() debounce(Function(String) func, int milliseconds) {
  Timer? timer;
  return () {
    // or (arg) if you need an argument
    if (timer != null) {
      timer?.cancel();
    }

    timer = Timer(
        Duration(milliseconds: milliseconds), () => func); // or () => func(arg)
  };
}
