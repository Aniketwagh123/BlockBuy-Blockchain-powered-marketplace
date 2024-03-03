part of 'offer_screen_bloc.dart';

// Define events
sealed class OfferScreenEvent {}

class PickImagesEvent extends OfferScreenEvent {}

class AddProductEvent extends OfferScreenEvent {
  final String productName;
  final String description;
  final double price;
  final String category;
  final int stock;
  final String color;
  final String size;
  final String material;
  final List<String> imagePaths;

  AddProductEvent({
    required this.productName,
    required this.description,
    required this.price,
    required this.category,
    required this.stock,
    required this.color,
    required this.size,
    required this.material,
    required this.imagePaths,
  });

  @override
  String toString() {
    return 'AddProductEvent(productName: $productName, description: $description, price: $price, category: $category, stock: $stock, color: $color, size: $size, material: $material, imagePaths: $imagePaths)';
  }
}
