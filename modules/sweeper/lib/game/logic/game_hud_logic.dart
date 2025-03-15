import 'dart:async';

mixin GameHudLogic{
  final StreamController<int> _mineCountCtrl = StreamController.broadcast();

  final StreamController<int> _timeCountCtrl = StreamController.broadcast();

  Stream<int> get mineCountStream => _mineCountCtrl.stream;

  Stream<int> get timeCtrlStream => _timeCountCtrl.stream;

  void changeMineCount(int value) {
    _mineCountCtrl.add(value);
  }

  Timer? _timer;
  int _timeCount = 0;

  void startTimer() {
    closeTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTime);
  }

  void _updateTime(Timer timer) {
    _timeCount++;
    _timeCountCtrl.add(_timeCount);
  }

  void closeTimer() {
    _timer?.cancel();
    _timeCount = 0;
    _timer = null;
  }
}