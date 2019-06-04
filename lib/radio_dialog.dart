import 'package:flutter/material.dart';

class RadioDialog extends StatefulWidget {
  final String header;
  final List<dynamic> allItems;
  final dynamic selectedItem;
  final Function boxTitle;
  final ValueChanged<dynamic> onSelectedItemChanged;

  RadioDialog({
    this.header,
    this.allItems,
    this.selectedItem,
    this.boxTitle,
    this.onSelectedItemChanged,
  });

  @override
  _RadioDialogState createState() => _RadioDialogState();
}

class _RadioDialogState extends State<RadioDialog> {
  dynamic _tempSelectedItem;

  @override
  void initState() {
    _tempSelectedItem = widget.selectedItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Dialog(
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
                    widget.onSelectedItemChanged(_tempSelectedItem);
                  },
                  child: Text(
                    'Done',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.allItems.length,
              itemBuilder: (BuildContext context, int index) {
                final item = widget.allItems[index];
                return Container(
                  child: RadioListTile(
                    dense: true,
                    title: widget.boxTitle(item),
                    value: item,
                    groupValue: _tempSelectedItem,
                    onChanged: (value) {
                      setState(() {
                        _tempSelectedItem = item;
                      });
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
