import 'package:flutter/material.dart';
import 'package:tenxglobal_customer/models/cart_data_model.dart';

// import your model file
// import 'order_response.dart';

class CustomerProvider extends ChangeNotifier {
  ///  List of parsed orders
  final List<OrderResponse> _orders = [];

  ///  Public getter
  List<OrderResponse> get orders => List.unmodifiable(_orders);

  ///  Add order from JSON
  void addOrderFromJson(Map<String, dynamic> json) {
    final orderResponse = OrderResponse.fromJson(json);
    _orders.clear();
    _orders.add(orderResponse);
    notifyListeners();
  }

  ///  Add multiple orders (API list)
  void addOrdersFromJsonList(List<dynamic> jsonList) {
    for (final item in jsonList) {
      _orders.add(OrderResponse.fromJson(item));
    }
    notifyListeners();
  }

  ///  Clear orders
  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }
}
