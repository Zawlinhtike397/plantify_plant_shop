import 'package:flutter/material.dart';

class CartProviderState extends ChangeNotifier {
  final List<Map<String, dynamic>> cartData = [];

  void addCartData(Map<String, dynamic> plant) {
    // Check if the product is already in the cart
    int index = cartData.indexWhere((item) => item['id'] == plant['id']);

    if (index != -1) {
      // If product is already in the cart, increase the quantity
      cartData[index]['quantity'] += 1;
    } else {
      // If product is not in the cart, add it with a quantity of 1
      cartData.add({...plant, 'quantity': 01});
    }
    // cartData.add(plant);
    notifyListeners();
  }

  void removeCartData(Map<String, dynamic> plant) {
    cartData.remove(plant);
    notifyListeners();
  }

  void updateQuantity(int index, num quantity) {
    if (quantity > 0) {
      cartData[index]['quantity'] = quantity;

      notifyListeners();
    }
  }
}
