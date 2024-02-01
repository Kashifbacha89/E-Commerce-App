import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CartProvider with ChangeNotifier {
  final _cartBox = Hive.box('cart_box');
  List<dynamic> _cart = [];
  int _counter = 0;
  int get counter => _counter;
  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    if (_counter >= 1) {
      _counter--;
      notifyListeners();
    }
  }

  //getter and setter methods for dynamic cart list
  List<dynamic> get cart => _cart;

  set cart(List<dynamic> newCart) {
    _cart = newCart;
    notifyListeners();
  }

  getCart() {
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "name": item['name'],
        "imageUrl": item['imageUrl'],
        "price": item['price'],
        "category": item['category'],
        "qty": item['qty'],
        "sizes": item['sizes']
      };
    }).toList();
    _cart = cartData.reversed.toList();
  }

  Future<void> deleteCart(int key) async {
    await _cartBox.delete(key);
    notifyListeners();
  }
}
