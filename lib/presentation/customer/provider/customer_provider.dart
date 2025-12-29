import 'package:flutter/material.dart';

import 'package:tenxglobal_customer/models/cart_response_model.dart';

// import your model file
// import 'order_response.dart';

class CustomerProvider extends ChangeNotifier {
  ///  List of parsed orders
  final List<CartResponse> _orders = [];

  ///  Public getter
  List<CartResponse> get orders => List.unmodifiable(_orders);

  ///  Add order from JSON
  void addOrderFromJson(Map<String, dynamic> json) {
    print('---------------------------    ${json}');
    final orderResponse = CartResponse.fromJson(json);
    print(orderResponse.cartData.customer);
    _orders.clear();
    _orders.add(orderResponse);
    notifyListeners();
  }

  ///  Add multiple orders (API list)
  void addOrdersFromJsonList(List<dynamic> jsonList) {
    for (final item in jsonList) {
      _orders.add(CartResponse.fromJson(item));
    }
    notifyListeners();
  }

  ///  Clear orders
  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }
}
