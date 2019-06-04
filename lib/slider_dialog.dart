import 'package:flutter/material.dart';

class SliderDialog extends StatefulWidget {
  final String header;
  final double selectedValue;
  final Function boxTitle;
  final ValueChanged<double> onSelectedValueChanged;

  SliderDialog({
    this.header,
    this.selectedValue,
    this.boxTitle,
    this.onSelectedValueChanged,
  });

  @override
  _SliderDialogState createState() => _SliderDialogState();
}

class _SliderDialogState extends State<SliderDialog> {
  double _tempSelectedValue;

  @override
  void initState() {
    _tempSelectedValue = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Dialog(
      child: Container(
        height: 125,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      widget.header,
                      style: themeData.textTheme.headline,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onSelectedValueChanged(_tempSelectedValue);
                    },
                    child: Text(
                      'Done',
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _tempSelectedValue.toString().substring(0, 5),
                  style: themeData.primaryTextTheme.caption,
                ),
              ],
            ),
            Slider(
              activeColor: themeData.colorScheme.primary,
              value: _tempSelectedValue,
              onChanged: (value) {
                setState(() {
                  _tempSelectedValue = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
