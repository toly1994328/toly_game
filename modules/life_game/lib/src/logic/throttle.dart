
import 'dart:async';

typedef Throttleable<T> = void Function(T currentArg);

typedef Throttled<T> = Timer Function(T currentArg);


Throttled<T> throttle<T>({
  required Duration duration,
  required Throttleable<T> function,
}) {
  Timer? timer;
  late T arg;

  return (T currentArg) {
    arg = currentArg;
    if (timer != null && timer!.isActive) {
      return timer!;
    }
    timer = Timer(duration, () {
      function(arg);
      timer = null;
    });
    return timer!;
  };
}
