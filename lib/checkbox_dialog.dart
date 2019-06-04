import 'package:flutter/material.dart';

class SelectionDialog extends StatefulWidget {
  final String header;
  final List<dynamic> allItems;
  final List<dynamic> selectedItems;
  final Function boxTitle;
  final ValueChanged<List<dynamic>> onSelectedItemsListChanged;

  SelectionDialog({
    this.header,
    this.allItems,
    this.selectedItems,
    this.boxTitle,
    this.onSelectedItemsListChanged,
  });

  @override
  _SelectionDialogState createState() => _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> {
  List<dynamic> _tempSelectedItems = [];

  @override
  void initState() {
    _tempSelectedItems = widget.selectedItems;
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
                    widget.onSelectedItemsListChanged(_tempSelectedItems);
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
                  child: CheckboxListTile(
                    dense: true,
                    title: widget.boxTitle(item),
                    value: _tempSelectedItems.contains(item),
                    onChanged: (bool value) {
                      if (value) {
                        if (!_tempSelectedItems.contains(item)) {
                          setState(() {
                            _tempSelectedItems.add(item);
                          });
                        }
                      } else {
                        if (_tempSelectedItems.contains(item)) {
                          setState(
                            () {
                              _tempSelectedItems
                                  .removeWhere((_item) => _item == item);
                            },
                          );
                        }
                      }
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
