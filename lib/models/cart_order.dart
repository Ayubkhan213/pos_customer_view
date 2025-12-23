import 'package:tenxglobal_customer/models/cart_item.dart';

class CartOrder {
  final String customer;
  final String phoneNumber;
  final String deliveryLocation;
  final String orderType;
  final String? table;
  final String note;
  final List<CartItem> items;
  final List<dynamic> appliedPromos;
  final double subtotal;
  final double deliveryCharges;
  final double serviceCharges;
  final double tax;
  final double promoDiscount;
  final double saleDiscount;
  final double total;

  CartOrder({
    required this.customer,
    required this.phoneNumber,
    required this.deliveryLocation,
    required this.orderType,
    this.table,
    required this.note,
    required this.items,
    required this.appliedPromos,
    required this.subtotal,
    required this.deliveryCharges,
    required this.serviceCharges,
    required this.tax,
    required this.promoDiscount,
    required this.saleDiscount,
    required this.total,
  });

  factory CartOrder.fromJson(Map<String, dynamic> json) {
    return CartOrder(
      customer: json['customer'],
      phoneNumber: json['phone_number'],
      deliveryLocation: json['delivery_location'],
      orderType: json['order_type'],
      table: json['table'],
      note: json['note'],
      items: (json['items'] as List).map((e) => CartItem.fromJson(e)).toList(),
      appliedPromos: json['applied_promos'] ?? [],
      subtotal: (json['subtotal'] as num).toDouble(),
      deliveryCharges: (json['delivery_charges'] as num).toDouble(),
      serviceCharges: (json['service_charges'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      promoDiscount: (json['promo_discount'] as num).toDouble(),
      saleDiscount: (json['sale_discount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer': customer,
      'phone_number': phoneNumber,
      'delivery_location': deliveryLocation,
      'order_type': orderType,
      'table': table,
      'note': note,
      'items': items.map((e) => e.toJson()).toList(),
      'applied_promos': appliedPromos,
      'subtotal': subtotal,
      'delivery_charges': deliveryCharges,
      'service_charges': serviceCharges,
      'tax': tax,
      'promo_discount': promoDiscount,
      'sale_discount': saleDiscount,
      'total': total,
    };
  }
}
