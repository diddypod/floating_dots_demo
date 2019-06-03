import 'package:floating_dots/floating_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      title: 'Dots Demo',
      home: Demo(),
    );
  }
}

class Demo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DemoState();
}

class DemoState extends State<Demo> {
  int number = 500;
  Direction direction = Direction.random;
  Trajectory trajectory = Trajectory.random;
  DotSize dotSize = DotSize.small;
  List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.red,
    Colors.orange,
    Colors.yellow,
  ];
  double opacity = .7;
  DotSpeed dotSpeed = DotSpeed.mixed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
          ),
          FloatingDotGroup(
            number: number,
            direction: direction,
            trajectory: trajectory,
            size: dotSize,
            colors: colors,
            opacity: opacity,
            speed: dotSpeed,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Colors"),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ColorSelectionDialog(
                            color: "Colors",
                            allColors: (Colors.primaries).cast<Color>() +
                                Colors.accents,
                            selectedColors: colors,
                            onSelectedColorsListChanged: (selectedColors) {
                              setState(() {
                                colors = selectedColors;
                              });
                            },
                          );
                        },
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text("Size"),
                    onPressed: () {},
                  ),
                  RaisedButton(
                    child: Text("Opacity"),
                    onPressed: () {},
                  ),
                  RaisedButton(
                    child: Text("Number"),
                    onPressed: () {},
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Speed"),
                    onPressed: () {},
                  ),
                  RaisedButton(
                    child: Text("Direction"),
                    onPressed: () {},
                  ),
                  RaisedButton(
                    child: Text("Trajectory"),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ColorSelectionDialog extends StatefulWidget {
  final String color;
  final List<Color> allColors;
  final List<Color> selectedColors;
  final ValueChanged<List<Color>> onSelectedColorsListChanged;

  ColorSelectionDialog({
    this.color,
    this.allColors,
    this.selectedColors,
    this.onSelectedColorsListChanged,
  });

  @override
  _ColorSelectionDialogState createState() => _ColorSelectionDialogState();
}

class _ColorSelectionDialogState extends State<ColorSelectionDialog> {
  List<Color> _tempSelectedColors = [];

  @override
  void initState() {
    _tempSelectedColors = widget.selectedColors;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.color,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Done',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.allColors.length,
              itemBuilder: (BuildContext context, int index) {
                final color = widget.allColors[index];
                return Container(
                  child: CheckboxListTile(
                    dense: true,
                    title: Container(
                      height: 20,
                      width: 10,
                      color: color,
                    ),
                    value: _tempSelectedColors.contains(color),
                    onChanged: (bool value) {
                      if (value) {
                        if (!_tempSelectedColors.contains(color)) {
                          setState(() {
                            _tempSelectedColors.add(color);
                          });
                        }
                      } else {
                        if (_tempSelectedColors.contains(color)) {
                          setState(
                            () {
                              _tempSelectedColors
                                  .removeWhere((_color) => _color == color);
                            },
                          );
                        }
                      }
                      widget.onSelectedColorsListChanged(_tempSelectedColors);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
