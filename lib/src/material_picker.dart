library material_colorpicker;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/src/utils.dart';

class MaterialPicker extends StatefulWidget {
  MaterialPicker({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    this.onPrimaryChanged,
    this.enableLabel = false,
    this.portraitOnly = false,
  }) : super(key: key);

  final Color pickerColor;
  ValueChanged<Color> onColorChanged;
  final ValueChanged<Color>? onPrimaryChanged;
  final bool enableLabel;
  final bool portraitOnly;

  @override
  State<StatefulWidget> createState() => _MaterialPickerState();
}

Color? _color;

class _MaterialPickerState extends State<MaterialPicker> {
  final List<List<Color>> _colorTypes = [
    [
      Color.fromARGB(255, 255, 51, 99),
    ],
    [
      const Color(0xff6398FC),
    ],
    [
      const Color(0xffEE7502),
    ],
  ];

  List<Color> _currentColorType = [Colors.red, Colors.redAccent];
  Color _currentShading = Colors.transparent;

  List<Map<Color, String>> _shadingTypes(List<Color> colors) {
    List<Map<Color, String>> result = [];

    return result;
  }

  @override
  void initState() {
    for (List<Color> _colors in _colorTypes) {
      _shadingTypes(_colors).forEach((Map<Color, String> color) {
        if (widget.pickerColor.value == color.keys.first.value) {
          return setState(() {
            _currentColorType = _colors;
            _currentShading = color.keys.first;
          });
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait ||
            widget.portraitOnly;

    Widget _colorList() {
      return Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(),
        child: Container(
          margin: _isPortrait
              ? const EdgeInsets.only(right: 10)
              : const EdgeInsets.only(bottom: 10),
          width: _isPortrait ? 60 : null,
          height: _isPortrait ? null : 60,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context)
                .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
            child: ListView(
              scrollDirection: _isPortrait ? Axis.horizontal : Axis.horizontal,
              children: [
                _isPortrait
                    ? const Padding(padding: EdgeInsets.only(top: 7))
                    : const Padding(padding: EdgeInsets.only(left: 7)),
                ..._colorTypes.map((List<Color> _colors) {
                  Color _colorType = _colors[0];
                  return GestureDetector(
                    onTap: () {
                      if (widget.onPrimaryChanged != null) {
                        widget.onPrimaryChanged!(_colorType);
                      }
                      setState(() {
                        widget.onColorChanged(_colors[0]);
                      });
                      setState(() => _currentColorType = _colors);
                    },
                    child: Container(
                      color: const Color(0x00000000),
                      padding: _isPortrait
                          ? const EdgeInsets.fromLTRB(10, 7, 28, 7)
                          : const EdgeInsets.fromLTRB(10, 0, 28, 0),
                      child: Align(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _colorType,
                            shape: BoxShape.circle,
                            boxShadow: _currentColorType == _colors
                                ? [
                                    _colorType == Theme.of(context).cardColor
                                        ? BoxShadow(
                                            color: Colors.grey[300]!,
                                            blurRadius: 10,
                                          )
                                        : BoxShadow(
                                            color: _colorType,
                                            blurRadius: 10,
                                          ),
                                  ]
                                : null,
                            border: _colorType == Theme.of(context).cardColor
                                ? Border.all(color: Colors.grey[300]!, width: 1)
                                : null,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                _isPortrait
                    ? const Padding(padding: EdgeInsets.only(top: 5))
                    : const Padding(padding: EdgeInsets.only(left: 5)),
              ],
            ),
          ),
        ),
      );
    }

    Widget _shadingList() {
      return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context)
            .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
        child: ListView(
          scrollDirection: _isPortrait ? Axis.vertical : Axis.horizontal,
          children: [
            _isPortrait
                ? const Padding(padding: EdgeInsets.only(top: 15))
                : const Padding(padding: EdgeInsets.only(left: 15)),
            ..._shadingTypes(_currentColorType).map((Map<Color, String> color) {
              _color = color.keys.first;
              return GestureDetector(
                onTap: () {
                  setState(() => _currentShading = _color!);
                  var color = widget.onColorChanged(_color!);
                  if (kDebugMode) {
                    print("colors :::::::::::::::;;$_color");
                  }
                },
                child: Container(
                  color: const Color(0x00000000),
                  margin: _isPortrait
                      ? const EdgeInsets.only(right: 10)
                      : const EdgeInsets.only(bottom: 10),
                  padding: _isPortrait
                      ? const EdgeInsets.fromLTRB(0, 7, 0, 7)
                      : const EdgeInsets.fromLTRB(7, 0, 7, 0),
                  child: Align(
                    child: AnimatedContainer(
                      curve: Curves.fastOutSlowIn,
                      duration: const Duration(milliseconds: 500),
                      width: _isPortrait
                          ? (_currentShading == _color ? 250 : 230)
                          : (_currentShading == _color ? 50 : 30),
                      height: _isPortrait ? 50 : 220,
                      decoration: BoxDecoration(
                        color: _color,
                        boxShadow: _currentShading == _color
                            ? [
                                (_color == Colors.white) ||
                                        (_color == Colors.black)
                                    ? BoxShadow(
                                        color: Colors.grey[300]!,
                                        blurRadius: 10,
                                      )
                                    : BoxShadow(
                                        color: _color!,
                                        blurRadius: 10,
                                      ),
                              ]
                            : null,
                        border:
                            (_color == Colors.white) || (_color == Colors.black)
                                ? Border.all(color: Colors.grey[300]!, width: 1)
                                : null,
                      ),
                      child: widget.enableLabel
                          ? _isPortrait
                              ? Row(
                                  children: [
                                    Text(
                                      '  ${color.values.first}',
                                      style: TextStyle(
                                          color: useWhiteForeground(_color!)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          '#${(_color.toString().replaceFirst('Color(0xff', '').replaceFirst(')', '')).toUpperCase()}  ',
                                          style: TextStyle(
                                            color: useWhiteForeground(_color!)
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : AnimatedOpacity(
                                  duration: const Duration(milliseconds: 300),
                                  opacity: _currentShading == _color ? 1 : 0,
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 16),
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      color.values.first,
                                      style: TextStyle(
                                        color: useWhiteForeground(_color!)
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      softWrap: false,
                                    ),
                                  ),
                                )
                          : const SizedBox(),
                    ),
                  ),
                ),
              );
            }),
            _isPortrait
                ? const Padding(padding: EdgeInsets.only(top: 15))
                : const Padding(padding: EdgeInsets.only(left: 15)),
          ],
        ),
      );
    }

    return SizedBox(
      width: 250,
      height: 100,
      child: _colorList(),
    );
  }
}
