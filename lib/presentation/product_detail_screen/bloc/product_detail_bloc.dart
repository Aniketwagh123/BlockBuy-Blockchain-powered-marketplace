import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import '../models/fortyeight_item_model.dart';
import '../models/sizes_item_model.dart';
import '../models/products_item_model.dart';
import '../models/recomended_item_model.dart';
import 'package:aniket_s_application1/presentation/product_detail_screen/models/product_detail_model.dart';
part 'product_detail_event.dart';
part 'product_detail_state.dart';

/// A bloc that manages the state of a ProductDetail according to the event that is dispatched to it.
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc(ProductDetailState initialState) : super(initialState) {
    on<ProductDetailInitialEvent>(_onInitialize);
    on<SizeSelectedEvent>(
        _onSelected); // Add this line to register SizeSelectedEvent handler
  }

  List<FortyeightItemModel> fillFortyeightItemList() {
    return List.generate(1, (index) => FortyeightItemModel());
  }

  List<SizesItemModel> fillSizesItemList() {
    return [
      SizesItemModel(six: "XS"),
      SizesItemModel(six: "S"),
      SizesItemModel(six: "M"),
      SizesItemModel(six: "L"),
      SizesItemModel(six: "XL"),
      SizesItemModel(six: "XXL")
    ];
  }

  List<ProductsItemModel> fillProductsItemList() {
    return [
      ProductsItemModel(productPicture: ImageConstant.imgProductPicture02),
      ProductsItemModel(productPicture: ImageConstant.imgProductPicture03),
      ProductsItemModel(productPicture: ImageConstant.imgProductPicture01)
    ];
  }

  List<RecomendedItemModel> fillRecomendedItemList() {
    return [
      RecomendedItemModel(
          image: ImageConstant.imgProductImage,
          fSNikeAirMax: "FS - Nike Air Max 270 React...",
          price: "299,43",
          oldPrice: "534,33",
          offer: "24% Off"),
      RecomendedItemModel(
          image: ImageConstant.imgProductImage109x109,
          fSNikeAirMax: "FS - QUILTED MAXI CROS...",
          price: "299,43",
          oldPrice: "534,33",
          offer: "24% Off"),
      RecomendedItemModel(
          image: ImageConstant.imgProductImage1,
          fSNikeAirMax: "FS - Nike Air Max 270 React...",
          price: "299,43",
          oldPrice: "534,33",
          offer: "24% Off")
    ];
  }

  _onInitialize(
    ProductDetailInitialEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(state.copyWith(sliderIndex: 0));
    emit(state.copyWith(
        productDetailModelObj: state.productDetailModelObj?.copyWith(
            fortyeightItemList: fillFortyeightItemList(),
            sizesItemList: fillSizesItemList(),
            productsItemList: fillProductsItemList(),
            recomendedItemList: fillRecomendedItemList())));
  }

  _onSelected(
    SizeSelectedEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    final int selectedIndex = event.selectedIndex;

    final List<SizesItemModel>? sizes =
        state.productDetailModelObj?.sizesItemList;

    if (sizes != null && selectedIndex >= 0 && selectedIndex < sizes.length) {
      final selectedSize = sizes[selectedIndex];

      final List<SizesItemModel> updatedSizes = sizes.map((sizeItem) {
        return sizeItem.copyWith(selected: sizeItem == selectedSize);
      }).toList();

      emit(state.copyWith(
        productDetailModelObj: state.productDetailModelObj?.copyWith(
          sizesItemList: updatedSizes,
        ),
      ));
    }
  }
}
