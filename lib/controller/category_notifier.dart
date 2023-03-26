import 'dart:collection';
import 'package:garbage_manager/models/Category.dart';
import 'package:flutter/material.dart';

class CategoryNotifier extends ChangeNotifier {
  List<Category> _categories = [
    Category(
        id: "1001",
        name: "Cardboard",
        imageURL: "assets/images/cardboard.png"),
    Category(
        id: "1004",
        name: "Paper",
        imageURL: "assets/images/paper.png"),
    Category(
        id: "1002",
        name: "Glass",
        imageURL: "assets/images/glass.png"),
    Category(
        id: "1003",
        name: "Metal",
        imageURL: "assets/images/metal.png"),
    Category(
        id: "1005",
        name: "Plastic",
        imageURL: "assets/images/plastic.png"),
    Category(
        id: "1006",
        name: "Trash",
        imageURL: "assets/images/trash.png")
  ];

  UnmodifiableListView<Category> get categories =>
      UnmodifiableListView(_categories);
}
