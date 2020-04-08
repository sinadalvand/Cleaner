import 'package:cleaner/AI/BroomEngine.dart';
import 'package:cleaner/Models/TileData.dart';
import 'package:cleaner/Utils/Consts.dart';
import 'package:scoped_model/scoped_model.dart';

class GlobalData extends Model {
  final tileList = List<TileData>();
  var _cleanerPicked = false;
  var _disable = false;
  var column = Consts.initTilesCoulmnCount;
  var row = Consts.initTilesRowCount;
  BroomEngine _engine;

  GlobalData() {
    _engine = BroomEngine(this);
    tileList.addAll(_getTiles());
  }

  startEngine(func) {
    _engine.start(func);
  }

  stopEngine() {
    _engine.stop();
  }

  addColumn() {
    column++;
    rebuildTiles();
  }

  addRow() {
    row++;
    rebuildTiles();
  }

  removeColumn() {
    column--;
    rebuildTiles();
  }

  removeRow() {
    row--;
    rebuildTiles();
  }

  rebuildTiles() {
    tileList.clear();
    tileList.addAll(_getTiles());
    setCleanerPicked(false);
    notifyListeners();
  }

  bool isCleanerPicked() {
    return _cleanerPicked;
  }

  setCleanerPicked(bool picked) {
    _cleanerPicked = picked;
    notifyListeners();
  }

  setDisable(bool disable) {
    _disable = disable;
    notifyListeners();
  }

  justNotifyAll() {
    notifyListeners();
  }

  bool isDisable() => _disable;

  List<TileData> _getTiles() {
    var list = List<TileData>();
    for (var i = 0; i < (column * row); i++) {
      list.add(TileData(i));
    }
    return list;
  }
}
