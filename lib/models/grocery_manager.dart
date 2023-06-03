import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:provider/provider.dart';

class GroceryManager extends ChangeNotifier {
  final _groceryItems = <GroceryItem>[];

  List<GroceryItem> get groceryItems => _groceryItems;

  void deleteItem(index) {
    _groceryItems.removeAt(index);
    notifyListeners();
  }

  void addItem(item) {
    _groceryItems.add(item);
    notifyListeners();
  }

  void updateItem(index, item) {
    _groceryItems[index] = item;
    notifyListeners();
  }

  void completeItem(int index, bool change) {
    final item = _groceryItems[index];
    _groceryItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}
