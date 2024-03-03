part of 'offer_screen_bloc.dart';

// Define states
sealed class OfferScreenState {
}

class InitialState extends OfferScreenState {}

class ImagesSelectedState extends OfferScreenState {
  final List<String> imagePaths;

  ImagesSelectedState(this.imagePaths);
}

class ProductAddedState extends OfferScreenState {}



class ErrorState extends OfferScreenState {
  final String errorMessage;
  ErrorState(this.errorMessage);
}