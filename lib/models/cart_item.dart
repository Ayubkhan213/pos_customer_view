class CartItem {
  final int id;
  final String title;
  final double price;
  final int qty;
  final String img;
  final String? variantName;
  final double resaleDiscountPerItem;
  final List<dynamic> addons;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.qty,
    required this.img,
    this.variantName,
    required this.resaleDiscountPerItem,
    required this.addons,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      qty: json['qty'],
      img: json['img'],
      variantName: json['variant_name'],
      resaleDiscountPerItem: (json['resale_discount_per_item'] as num)
          .toDouble(),
      addons: json['addons'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'qty': qty,
      'img': img,
      'variant_name': variantName,
      'resale_discount_per_item': resaleDiscountPerItem,
      'addons': addons,
    };
  }
}
