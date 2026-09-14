class Product {
  final int id;
  final String name;
  final int quantity;
  final double price;
  final String? image;
  final String? description;

  // Constructor
  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    this.image,
    this.description,
  });

  // Factory fromJson
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      description: json['description'],
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'image': image,
      'description': description,
    };
  }

  // copyTo
  Product copyTo({
    int? id,
    String? name,
    int? quantity,
    double? price,
    String? image,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }
}