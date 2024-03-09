// ignore_for_file: must_be_immutable

part of 'product_detail_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///ProductDetail widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class ProductDetailEvent extends Equatable {}

/// Event that is dispatched when the ProductDetail widget is first created.
class ProductDetailInitialEvent extends ProductDetailEvent {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when a size is selected.
class SizeSelectedEvent extends ProductDetailEvent {
  final int selectedIndex;
  final String selectedSize; // Add this line to include selectedSize

  SizeSelectedEvent(this.selectedIndex, this.selectedSize);

  @override
  List<Object?> get props => [selectedIndex, selectedSize];
}


