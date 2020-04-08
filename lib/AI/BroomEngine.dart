import 'dart:async';

import 'package:cleaner/Models/GlobalData.dart';
import 'package:cleaner/Models/TileData.dart';
import 'package:cleaner/Utils/Consts.dart';

class BroomEngine {
  GlobalData global;
  List<TileData> _innerList;
  var _firstCrossed = false;
  var _forward = false;
  Timer _timer;
  var _curser;
  var _columnSize;
  var _stopEngine = false;

  Function _stopFunc;

  BroomEngine(this.global);

  void start(func) {
    // _innerList = List<TileData>.from(global.tileList);
    print("Engin Start");
    _innerList = global.tileList;
    _stopFunc = func;
    _columnSize = global.column;
    _stopEngine = false;
    startTimer();
  }

  void stop() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
      _forward = false;
      _firstCrossed = false;
      _stopEngine = true;
      global.setCleanerPicked(false);
      _stopFunc();
    }
  }

  void startTimer() {
    if (_timer != null) return;

    // get Broom location for start
    _curser = _getBrromPosition();

    // desition logic for go forward or return
    _forward = _curser >= _innerList.length / 2;

    setTimer();
  }

  void _doAction() {
    // Clean it , then Move ..
    if (_innerList[_curser].getDirty) {
      _innerList[_curser].cleanCommand();
      _timer.cancel();
      Future.delayed(const Duration(milliseconds: 2000), () {
        justMove();
        setTimer(time: 1);
      });
    } else {
      justMove();
    }
  }

  void justMove() {
    var data = _indexRow(_curser);
    data = data.toInt();
    // forward and back logic
    print("Curser Link: ${_indexRow(_innerList.length - 1) == 0}");
    if (_curser == 0 ||
        _curser ==
            (data == 0
                ? _innerList.length - 1
                : _innerList.length - _columnSize)) {
      if (_firstCrossed) {
        _innerList[_curser].setCleaner(false);
        stop();
        return;
      } else {
        _firstCrossed = true;
        _forward = !_forward;
      }
    }

    // movement logic
    print("Data is: ${data}");
    if (data.toInt() == 0) {
      if (_forward) {
        if ((_curser + 1) % _columnSize == 0) {
          _innerList[_curser].setCleaner(false);
          _curser += _columnSize;
          _innerList[_curser].setCleaner(true);
        } else {
          _innerList[_curser].setCleaner(false);
          _curser += 1;
          _innerList[_curser].setCleaner(true);
        }
      } else {
        if (_curser % _columnSize == 0) {
          _innerList[_curser].setCleaner(false);
          _curser -= _columnSize;
          _innerList[_curser].setCleaner(true);
        } else {
          _innerList[_curser].setCleaner(false);
          _curser -= 1;
          _innerList[_curser].setCleaner(true);
        }
      }
    } else {
      if (_forward) {
        if (_curser % _columnSize == 0) {
          _innerList[_curser].setCleaner(false);
          _curser += _columnSize;
          _innerList[_curser].setCleaner(true);
        } else {
          _innerList[_curser].setCleaner(false);
          _curser -= 1;
          _innerList[_curser].setCleaner(true);
        }
      } else {
        if ((_curser + 1) % _columnSize == 0) {
          _innerList[_curser].setCleaner(false);
          _curser -= _columnSize;
          _innerList[_curser].setCleaner(true);
        } else {
          _innerList[_curser].setCleaner(false);
          _curser += 1;
          _innerList[_curser].setCleaner(true);
        }
      }
    }

    global.justNotifyAll();
  }

  void setTimer({time = 1}) {
    if (_timer != null && _timer.isActive) _timer.cancel();
    if (_stopEngine) return;
    _timer = Timer.periodic(Duration(seconds: time), (timer) {
      _doAction();
    });
  }

  int _getBrromPosition() {
    for (TileData f in global.tileList) {
      if (f.getCleaner) {
        return f.getIndex;
      }
    }
    return -1;
  }

  void _doClean() {
    _innerList[_getBrromPosition()].cleanCommand();
  }

  _indexRow(index) {
    var data = ((index) / _columnSize) % 2;
    return data;
  }
}
