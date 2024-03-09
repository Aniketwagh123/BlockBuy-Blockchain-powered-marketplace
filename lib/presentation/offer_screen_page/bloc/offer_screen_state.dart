part of 'offer_screen_bloc.dart';

// Define states
sealed class OfferScreenState {
}

class InitialState extends OfferScreenState {}

class ImagesSelectedState extends OfferScreenState {
  final List<Uint8List> imageDataList;

  ImagesSelectedState(this.imageDataList);
}

class ProductAddedState extends OfferScreenState {}



class ErrorState extends OfferScreenState {
  final String errorMessage;
  ErrorState(this.errorMessage);
}

class LoadingState extends OfferScreenState {
  final String loadingMessage;

  LoadingState({required this.loadingMessage});

}
