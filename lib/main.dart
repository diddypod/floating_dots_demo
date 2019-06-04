import 'package:dots_demo/input_dialog.dart';
import 'package:dots_demo/radio_dialog.dart';
import 'package:dots_demo/slider_dialog.dart';
import 'package:floating_dots/floating_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'checkbox_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        accentColor: Colors.blue,
      ),
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
  Color backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            color: backgroundColor,
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
              ButtonTheme(
                layoutBehavior: ButtonBarLayoutBehavior.constrained,
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Colors"),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SelectionDialog(
                              boxTitle: (color) {
                                return Container(
                                  height: 20,
                                  color: color,
                                );
                              },
                              header: "Colors",
                              allItems: [
                                    Colors.black,
                                    Colors.grey,
                                    Colors.white
                                  ] +
                                  (Colors.primaries).cast<Color>() +
                                  Colors.accents,
                              selectedItems: colors,
                              onSelectedItemsListChanged: (selectedColors) {
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return RadioDialog(
                              boxTitle: (value) {
                                return Text(value.toString());
                              },
                              header: "Size",
                              allItems: DotSize.values,
                              selectedItem: dotSize,
                              onSelectedItemChanged: (selectedSize) {
                                setState(() {
                                  dotSize = selectedSize;
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                    RaisedButton(
                      child: Text("Opacity"),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SliderDialog(
                              header: "Opacity",
                              selectedValue: opacity,
                              onSelectedValueChanged: (value) {
                                setState(() {
                                  opacity = value;
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                    RaisedButton(
                      child: Text("Background"),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return RadioDialog(
                              boxTitle: (color) {
                                return Container(
                                  height: 20,
                                  color: color,
                                );
                              },
                              header: "Background",
                              allItems: [
                                    Colors.black,
                                    Colors.grey,
                                    Colors.white
                                  ] +
                                  (Colors.primaries).cast<Color>() +
                                  Colors.accents,
                              selectedItem: backgroundColor,
                              onSelectedItemChanged: (color) {
                                setState(() {
                                  backgroundColor = color;
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              ButtonTheme(
                layoutBehavior: ButtonBarLayoutBehavior.constrained,
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Number"),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return InputDialog(
                              header: "Number",
                              selectedValue: number,
                              onSelectedValueChanged: (selectedValue) {
                                setState(() {
                                  number = selectedValue;
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                    RaisedButton(
                      child: Text("Speed"),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return RadioDialog(
                              boxTitle: (value) {
                                return Text(value.toString());
                              },
                              header: "Speed",
                              allItems: DotSpeed.values,
                              selectedItem: dotSpeed,
                              onSelectedItemChanged: (selectedSpeed) {
                                setState(() {
                                  dotSpeed = selectedSpeed;
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                    RaisedButton(
                      child: Text("Direction"),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return RadioDialog(
                              boxTitle: (value) {
                                return Text(value.toString());
                              },
                              header: "Direction",
                              allItems: Direction.values,
                              selectedItem: direction,
                              onSelectedItemChanged: (selectedDirection) {
                                setState(() {
                                  direction = selectedDirection;
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                    RaisedButton(
                      child: Text("Trajectory"),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return RadioDialog(
                              boxTitle: (value) {
                                return Text(value.toString());
                              },
                              header: "Trajectory",
                              allItems: Trajectory.values,
                              selectedItem: trajectory,
                              onSelectedItemChanged: (selectedTrajectory) {
                                setState(() {
                                  trajectory = selectedTrajectory;
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
