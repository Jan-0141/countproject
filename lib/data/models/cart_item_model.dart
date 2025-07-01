class CartItem {
  final String name;
  final double price;
  final String category;
  final String image;

  CartItem({
    required this.name,
    required this.price,
    required this.category,
    required this.image,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      image: json['image'],
    );
  }
}
