import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputDialog extends StatefulWidget {
  final String header;
  final int selectedValue;
  final Function boxTitle;
  final ValueChanged<int> onSelectedValueChanged;

  InputDialog({
    this.header,
    this.selectedValue,
    this.boxTitle,
    this.onSelectedValueChanged,
  });

  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  int _tempSelectedValue;

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
        height: 135,
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 100),
              child: TextField(
                decoration: InputDecoration(
                  hintText: widget.selectedValue.toString(),
                ),
                textAlign: TextAlign.center,
                autocorrect: false,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _tempSelectedValue = int.parse(value);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
