import 'package:flutter/material.dart';

class getDropdown {
  List<DropdownMenuItem<String>> addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(
                height: 0,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  getDividersIndexes(items) {
    List<int> _getDividersIndexes() {
      List<int> _dividersIndexes = [];
      for (var i = 0; i < (items.length * 2) - 1; i++) {
        if (i.isOdd) {
          _dividersIndexes.add(i);
        }
      }
      return _dividersIndexes;
    }
  }
}
