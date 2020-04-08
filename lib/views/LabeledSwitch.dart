import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum _SwitchListTileType { material, adaptive }

class SwitchListTileImproved extends StatefulWidget {
  const SwitchListTileImproved({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.inactiveThumbImage,
    this.title,
    this.subtitle,
    this.isThreeLine = false,
    this.dense,
    this.contentPadding,
    this.secondary,
    this.selected = false,
  })  : _switchListTileType = _SwitchListTileType.material,
        assert(value != null),
        assert(isThreeLine != null),
        assert(!isThreeLine || subtitle != null),
        assert(selected != null),
        super(key: key);

  const SwitchListTileImproved.adaptive({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.inactiveThumbImage,
    this.title,
    this.subtitle,
    this.isThreeLine = false,
    this.dense,
    this.contentPadding,
    this.secondary,
    this.selected = false,
  })  : _switchListTileType = _SwitchListTileType.adaptive,
        assert(value != null),
        assert(isThreeLine != null),
        assert(!isThreeLine || subtitle != null),
        assert(selected != null),
        super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color activeTrackColor;
  final Color inactiveThumbColor;
  final Color inactiveTrackColor;
  final ImageProvider activeThumbImage;
  final ImageProvider inactiveThumbImage;
  final Widget title;
  final Widget subtitle;
  final Widget secondary;
  final bool isThreeLine;
  final bool dense;
  final EdgeInsetsGeometry contentPadding;
  final bool selected;
  final _SwitchListTileType _switchListTileType;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LableSwitch(value);
  }
}

class _LableSwitch extends State<SwitchListTileImproved> {
  var values = false;
  _LableSwitch(this.values);

  @override
  Widget build(BuildContext context) {
    Widget control;
    switch (widget._switchListTileType) {
      case _SwitchListTileType.adaptive:
        control = Switch.adaptive(
          value: values,
          onChanged: widget.onChanged,
          activeColor: widget.activeColor,
          activeThumbImage: widget.activeThumbImage,
          inactiveThumbImage: widget.inactiveThumbImage,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          activeTrackColor: widget.activeTrackColor,
          inactiveTrackColor: widget.inactiveTrackColor,
          inactiveThumbColor: widget.inactiveThumbColor,
        );
        break;

      case _SwitchListTileType.material:
        control = Switch(
          value: values,
          onChanged: widget.onChanged,
          activeColor: widget.activeColor,
          activeThumbImage: widget.activeThumbImage,
          inactiveThumbImage: widget.inactiveThumbImage,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          activeTrackColor: widget.activeTrackColor,
          inactiveTrackColor: widget.inactiveTrackColor,
          inactiveThumbColor: widget.inactiveThumbColor,
        );
    }
    return MergeSemantics(
      child: ListTileTheme.merge(
        selectedColor: widget.activeColor ?? Theme.of(context).accentColor,
        child: ListTile(
          leading: widget.secondary,
          title: widget.title,
          subtitle: widget.subtitle,
          trailing: control,
          isThreeLine: widget.isThreeLine,
          dense: widget.dense,
          contentPadding: widget.contentPadding,
          enabled: widget.onChanged != null,
          onTap: widget.onChanged != null
              ? () {
                  widget.onChanged(!widget.value);
                  setState(() {
                    values = !values;
                  });
                }
              : null,
          selected: widget.selected,
        ),
      ),
    );
  }
}
