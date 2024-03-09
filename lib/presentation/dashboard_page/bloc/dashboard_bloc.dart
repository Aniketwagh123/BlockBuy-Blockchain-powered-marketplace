import 'dart:convert';
import 'package:aniket_s_application1/presentation/offer_screen_page/bloc/offer_screen_bloc.dart';
import 'package:aniket_s_application1/services/blockchain_fun.dart';
import 'package:http/http.dart' as http;

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

  Future<List<FsnikeairmaxItemModel>> fillFsnikeairmaxItemList(DashboardState state) async {
    List<FsnikeairmaxItemModel> ls = [
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
    
    List<String> hashList = await getAllProducts();
    for (int i = 0; i < hashList.length; i++) {
      var jsonData = await _fetchData(hashList[i]);
      // jsonData = jsonData;
      

      String productName = jsonData['productName'];
      String? imagePath;
      try{
        imagePath = _getIPFSpath(jsonData['imagePaths'][0]);
      }catch(e){
        print("ni images");
      }
      // String category = productData['category'];
      String price = jsonData['price'].toString();

      // Generate the FSNikeAirMaxItemModel
      FsnikeairmaxItemModel itemModel = FsnikeairmaxItemModel(
        image: imagePath ?? ImageConstant.imgProductImage0, // Replace with actual image path
        fSNikeAirMax: productName,
        price: price,
        oldPrice:
            'NA', // You can set oldPrice to empty string or some default value
        offer: 'NA',
        jsonData: jsonData // You can set offer to empty string or some default value
      );
      ls.add(itemModel);
    }

    return ls ;
  }

  List<MsnikeairmaxItemModel> fillMsnikeairmaxItemList() {
    return [
      MsnikeairmaxItemModel(
          image: ImageConstant.imgProductImage2,
          mSNikeAirMax: "MS - Nike Air Max 270 React...",
          price: "499,43",
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
          price: "599,43",
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
    // emit(state.copyWith(sliderIndex: 0));
    
    List<FsnikeairmaxItemModel> fsNikeAirMaxItemList = await fillFsnikeairmaxItemList(state);
    emit(state.copyWith(
        dashboardModelObj: state.dashboardModelObj?.copyWith(
            sliderItemList: fillSliderItemList(),
            categoriesItemList: fillCategoriesItemList(),
            fsnikeairmaxItemList: fsNikeAirMaxItemList,
            msnikeairmaxItemList: fillMsnikeairmaxItemList(),
            dashboardItemList: fillDashboardItemList()),
           ),
            );
  }

  Future<Map<String, dynamic>> _fetchData(String hash) async {
    final url = Uri.parse(_getIPFSpath(hash));

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final jsonData = jsonDecode(response.body);

        // Return the parsed JSON data
        return jsonData;
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle any exceptions that occur during the fetch operation
      print('Error: $e');
      rethrow; // Rethrow the exception to propagate it to the caller
    }
  }

  String _getIPFSpath(String hash){
    return 'https://ivory-capable-basilisk-139.mypinata.cloud/ipfs/${hash}?pinataGatewayToken=1ROdYSQDquDO-YnO-pxxqQzly6dWUl89hzcRtKVVovYsB7x4AGr1ZV-LzRCpQBUj';
  }
}
