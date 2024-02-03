import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import '../models/slider_item_model.dart';
import '../models/categories_item_model.dart';
import '../models/fsnikeairmax_item_model.dart';
import '../models/msnikeairmax_item_model.dart';
import '../models/dashboard_item_model.dart';
import 'package:aniket_s_application1/presentation/dashboard_page/models/dashboard_model.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

/// A bloc that manages the state of a Dashboard according to the event that is dispatched to it.
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(DashboardState initialState) : super(initialState) {
    on<DashboardInitialEvent>(_onInitialize);
  }

  List<SliderItemModel> fillSliderItemList() {
    return List.generate(1, (index) => SliderItemModel());
  }

  List<CategoriesItemModel> fillCategoriesItemList() {
    return [
      CategoriesItemModel(
          arrowLeft: ImageConstant.imgArrowLeftPrimary, manShirt: "Man Shirt"),
      CategoriesItemModel(
          arrowLeft: ImageConstant.imgManWorkEquipment, manShirt: "Office Bag"),
      CategoriesItemModel(
          arrowLeft: ImageConstant.imgDressIcon, manShirt: "Dress"),
      CategoriesItemModel(
          arrowLeft: ImageConstant.imgWomanBagIcon, manShirt: "Woman Bag"),
      CategoriesItemModel(
          arrowLeft: ImageConstant.imgManShoesIcon, manShirt: "Man Shoes")
    ];
  }

  List<FsnikeairmaxItemModel> fillFsnikeairmaxItemList() {
    return [
      FsnikeairmaxItemModel(
          image: ImageConstant.imgProductImage,
          fSNikeAirMax: "FS - Nike Air Max 270 React...",
          price: "299,43",
          oldPrice: "534,33",
          offer: "24% Off"),
      FsnikeairmaxItemModel(
          image: ImageConstant.imgProductImage109x109,
          fSNikeAirMax: "FS - QUILTED MAXI CROS...",
          price: "299,43",
          oldPrice: "534,33",
          offer: "24% Off"),
      FsnikeairmaxItemModel(
          image: ImageConstant.imgProductImage1,
          fSNikeAirMax: "FS - Nike Air Max 270 React...",
          price: "299,43",
          oldPrice: "534,33",
          offer: "24% Off")
    ];
  }

  List<MsnikeairmaxItemModel> fillMsnikeairmaxItemList() {
    return [
      MsnikeairmaxItemModel(
          image: ImageConstant.imgProductImage2,
          mSNikeAirMax: "MS - Nike Air Max 270 React...",
          price: "299,43",
          oldPrice: "534,33",
          offer: "24% Off"),
      MsnikeairmaxItemModel(
          image: ImageConstant.imgProductImage3,
          mSNikeAirMax: "MS - Nike Air Max 270 React...",
          price: "299,43",
          oldPrice: "534,33",
          offer: "24% Off"),
      MsnikeairmaxItemModel(
          image: ImageConstant.imgProductImage4,
          mSNikeAirMax: "MS - Nike Air Max 270 React...",
          price: "299,43",
          oldPrice: "534,33",
          offer: "24% Off")
    ];
  }

  List<DashboardItemModel> fillDashboardItemList() {
    return [
      DashboardItemModel(
          image: ImageConstant.imgImageProduct,
          nikeAirMaxReact: "Nike Air Max 270 React ENG",
          price: "299,43",
          oldPrice: "534,33",
          offer: "24% Off"),
      DashboardItemModel(
          image: ImageConstant.imgProductImage2,
          nikeAirMaxReact: "Nike Air Max 270 React ENG",
          price: "299,43",
          oldPrice: "534,33",
          offer: "24% Off"),
      DashboardItemModel(
          image: ImageConstant.imgProductImage133x133,
          nikeAirMaxReact: "Nike Air Max 270 React ENG",
          price: "299,43",
          oldPrice: "534,33",
          offer: "24% Off"),
      DashboardItemModel(
          image: ImageConstant.imgProductImage1,
          nikeAirMaxReact: "Nike Air Max 270 React ENG",
          price: "299,43",
          oldPrice: "534,33",
          offer: "24% Off")
    ];
  }

  _onInitialize(
    DashboardInitialEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(sliderIndex: 0));
    emit(state.copyWith(
        dashboardModelObj: state.dashboardModelObj?.copyWith(
            sliderItemList: fillSliderItemList(),
            categoriesItemList: fillCategoriesItemList(),
            fsnikeairmaxItemList: fillFsnikeairmaxItemList(),
            msnikeairmaxItemList: fillMsnikeairmaxItemList(),
            dashboardItemList: fillDashboardItemList())));
  }
}
