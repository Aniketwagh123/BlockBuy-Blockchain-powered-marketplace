import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import '/core/app_export.dart';
import '../models/cartlist_item_model.dart';
import 'package:aniket_s_application1/presentation/cart_page/models/cart_model.dart';
part 'cart_event.dart';
part 'cart_state.dart';

/// A bloc that manages the state of a Cart according to the event that is dispatched to it.
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(CartState initialState) : super(initialState) {
    on<CartInitialEvent>(_onInitialize);
  }

  Future<List<CartlistItemModel>> fillCartlistItemList() async {
    List<CartlistItemModel> ls = [];
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> items = sp.getStringList('cart') ?? [];
    for (String item in items) {
      List<String> itemInfo = item.split(',');

      String imagePath = itemInfo[0]; // Extract the image path
      String productName = itemInfo[1]; // Extract the product name
      String price = itemInfo[2]; // Extract the price
      
      ls.add(
        CartlistItemModel(
          cartItemImagePath: imagePath,
          nikeAirZoomPegasus:productName,
          price: price,
          one: "1")
      );

      // Now you can use imagePath, productName, and price as needed
    }
    return ls;
  }

  _onInitialize(
    CartInitialEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(cuponCodeController: TextEditingController()));
    emit(state.copyWith(
        cartModelObj: state.cartModelObj
            ?.copyWith(cartlistItemList: await fillCartlistItemList())));
  }
}
