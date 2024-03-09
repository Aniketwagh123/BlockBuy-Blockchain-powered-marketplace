// Define your Product model
import 'dart:convert';

class Product {
  final String name;
  final String category;
  final String imageLink;
  final String descLink;
  final int price;
  final int index;
  final ProductStatus status;

  Product({
    required this.name,
    required this.category,
    required this.imageLink,
    required this.descLink,
    required this.price,
    required this.index,
    required this.status,
  });

  Product copyWith({
    String? name,
    String? category,
    String? imageLink,
    String? descLink,
    int? price,
    int? index,
    ProductStatus? status,
  }) {
    return Product(
      name: name ?? this.name,
      category: category ?? this.category,
      imageLink: imageLink ?? this.imageLink,
      descLink: descLink ?? this.descLink,
      price: price ?? this.price,
      index: index ?? this.index,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'category': category,
      'imageLink': imageLink,
      'descLink': descLink,
      'price': price,
      'index': index,
      'status': status.toString().split('.').last, // Convert enum to string
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      category: map['category'] as String,
      imageLink: map['imageLink'] as String,
      descLink: map['descLink'] as String,
      price: map['price'] as int,
      index: map['index'] as int,
      status: ProductStatusExtension.fromJson(map['status'] as String), // Convert string to enum
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(name: $name, category: $category, imageLink: $imageLink, descLink: $descLink, price: $price, index: $index, status: $status)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.category == category &&
      other.imageLink == imageLink &&
      other.descLink == descLink &&
      other.price == price &&
      other.index == index &&
      other.status == status;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      category.hashCode ^
      imageLink.hashCode ^
      descLink.hashCode ^
      price.hashCode ^
      index.hashCode ^
      status.hashCode;
  }
}

// Enum to represent product status
enum ProductStatus {
  Available,
  Processing,
  Shipping,
  Sold,
}

extension ProductStatusExtension on ProductStatus {
  static ProductStatus fromJson(String status) {
    switch (status) {
      case 'Available':
        return ProductStatus.Available;
      case 'Processing':
        return ProductStatus.Processing;
      case 'Shipping':
        return ProductStatus.Shipping;
      case 'Sold':
        return ProductStatus.Sold;
      default:
        throw Exception('Unknown ProductStatus: $status');
    }
  }
}
