// ignore_for_file: must_be_immutable

part of 'order_details_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///OrderDetails widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class OrderDetailsEvent extends Equatable {}

/// Event that is dispatched when the OrderDetails widget is first created.
class OrderDetailsInitialEvent extends OrderDetailsEvent {
  @override
  List<Object?> get props => [];
}
