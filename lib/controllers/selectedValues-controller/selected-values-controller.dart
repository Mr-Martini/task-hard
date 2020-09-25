import 'package:flutter/cupertino.dart';

class SelectedValuesController with ChangeNotifier {
  List _selectedItems = [];

  set setSelectedItems(List aux) {
    _selectedItems = List<dynamic>.from(aux);
    notifyListeners();
  }

  set setSelectedItem(var newItem) {
    _selectedItems.add(newItem);
    notifyListeners();
  }

  List get getSelectedItems => _selectedItems;

  void removeSelectedItem(var aux) {
    _selectedItems.remove(aux);
    notifyListeners();
  }

  void clearSelectedItems() {
    _selectedItems.clear();
    notifyListeners();
  }

  void removeMultipleItems(List items) {
    for (var item in items) {
      _selectedItems.remove(item);
    }
    notifyListeners();
  }

  List<String> get getAllKeys {
    List<String> keys = [];
    for (var selectedItem in _selectedItems) {
      keys.add(selectedItem['key']);
    }
    return keys;
  }
}
