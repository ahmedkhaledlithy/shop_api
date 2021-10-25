import 'dart:collection';

import 'package:dsc_shop/models/product.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {

final List<Product> _items = [];

UnmodifiableListView<Product> get items => UnmodifiableListView(_items);

 double get totalPrice => items.fold(0, (total, current) => total + current.price!);



void add(Product item) {
  _items.add(item);
  notifyListeners();
}

void removeAll() {
  _items.clear();
  notifyListeners();
}

void remove(int id) {
  _items.removeWhere((element) => element.id == id);
  notifyListeners();
}


}