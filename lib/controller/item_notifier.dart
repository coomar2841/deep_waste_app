import 'dart:collection';
import 'package:garbage_manager/models/Item.dart';
import 'package:flutter/material.dart';

class ItemNotifier extends ChangeNotifier {
  List<Item> _items = [
    Item(
        id: "1001",
        name: "Cardboard",
        imageURL: "assets/images/cardboard.png",
        count: 0),
    Item(
        id: "1004",
        name: "Paper",
        count: 0,
        imageURL: "assets/images/paper.png"),
    Item(
        id: "1002",
        name: "Glass",
        count: 0,
        imageURL: "assets/images/glass.png"),
    Item(
        id: "1003",
        name: "Metal",
        count: 0,
        imageURL: "assets/images/metal.png"),
    Item(
        id: "1005",
        name: "Plastic",
        count: 0,
        imageURL: "assets/images/plastic.png"),
    Item(
        id: "1006",
        name: "Trash",
        count: 2,
        imageURL: "assets/images/trash.png")
  ];

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  Item getCollectedItem() {
    return _items.firstWhere((_item) => _item.count > 0, orElse: () => null);
  }

  void updateCount(itemName) {
    var matchedItem = _items.firstWhere(
        (_item) => _item.name.toLowerCase() == itemName,
        orElse: () => null);
    matchedItem.count = matchedItem.count + 1;
    notifyListeners();
  }
}
