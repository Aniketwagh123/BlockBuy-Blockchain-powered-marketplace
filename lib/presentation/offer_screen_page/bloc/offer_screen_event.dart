part of 'offer_screen_bloc.dart';


// Define events
sealed class OfferScreenEvent {}

class PickImagesEvent extends OfferScreenEvent {}

class AddProductEvent extends OfferScreenEvent {
  final List<Uint8List> imageDataList;
  final Product product;

  AddProductEvent(this.product,this.imageDataList);

  @override
  String toString() {
    return 'AddProductEvent(product: $product)';
  }
}


