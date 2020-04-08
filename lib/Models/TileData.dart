class TileData {
  final _index;

  TileData(this._index);

  bool _dirty = false;
  bool _cleaner = false;
  Function cleanCommand;

  bool get getDirty => _dirty;
  bool get getCleaner => _cleaner;
  int get getIndex => _index;

  setDirty(bool dirty) => _dirty = dirty;
  setCleaner(bool cleaner) => _cleaner = cleaner;
}
