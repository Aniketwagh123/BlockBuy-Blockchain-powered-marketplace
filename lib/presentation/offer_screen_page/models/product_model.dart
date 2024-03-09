import 'dart:convert';

import 'package:flutter/foundation.dart';

class Product {
  final String productName;
  final String sellerEmail;
  final String description;
  final double price;
  final String category;
  final int stock;
  final List<String> colors;
  final List<String> sizes;
  final String material;
  List<String> imagePaths;

  Product({
    required this.productName,
    required this.sellerEmail,
    required this.description,
    required this.price,
    required this.category,
    required this.stock,
    required this.colors,
    required this.sizes,
    required this.material,
    required this.imagePaths,
  });

  Product copyWith({
    String? productName,
    String? sellerEmail,
    String? description,
    double? price,
    String? category,
    int? stock,
    List<String>? colors,
    List<String>? sizes,
    String? material,
    List<String>? imagePaths,
  }) {
    return Product(
      productName: productName ?? this.productName,
      sellerEmail: sellerEmail ?? this.sellerEmail,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      stock: stock ?? this.stock,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      material: material ?? this.material,
      imagePaths: imagePaths ?? this.imagePaths,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'sellerEmail': sellerEmail,
      'description': description,
      'price': price,
      'category': category,
      'stock': stock,
      'colors': colors,
      'sizes': sizes,
      'material': material,
      'imagePaths': imagePaths,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productName: map['productName'] as String,
      sellerEmail: map['sellerEmail'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      category: map['category'] as String,
      stock: map['stock'] as int,
      colors: List<String>.from(map['colors'] as List<dynamic>),
      sizes: List<String>.from(map['sizes'] as List<dynamic>),
      material: map['material'] as String,
      imagePaths: List<String>.from(map['imagePaths'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(productName: $productName, sellerEmail: $sellerEmail, description: $description, price: $price, category: $category, stock: $stock, colors: $colors, sizes: $sizes, material: $material, imagePaths: $imagePaths)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.productName == productName &&
        other.sellerEmail == sellerEmail &&
        other.description == description &&
        other.price == price &&
        other.category == category &&
        other.stock == stock &&
        listEquals(other.colors, colors) &&
        listEquals(other.sizes, sizes) &&
        other.material == material &&
        listEquals(other.imagePaths, imagePaths);
  }

  @override
  int get hashCode {
    return productName.hashCode ^
        sellerEmail.hashCode ^
        description.hashCode ^
        price.hashCode ^
        category.hashCode ^
        stock.hashCode ^
        colors.hashCode ^
        sizes.hashCode ^
        material.hashCode ^
        imagePaths.hashCode;
  }

  // Setter for imagePaths
  void setImagePaths(List<String> paths) {
    imagePaths = paths;
  }

}
