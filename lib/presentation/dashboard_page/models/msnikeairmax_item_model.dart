import '../../../core/app_export.dart';

/// This class is used in the [msnikeairmax_item_widget] screen.
class MsnikeairmaxItemModel {
  MsnikeairmaxItemModel({
    this.image,
    this.mSNikeAirMax,
    this.price,
    this.oldPrice,
    this.offer,
    this.id,
  }) {
    image = image ?? ImageConstant.imgProductImage2;
    mSNikeAirMax = mSNikeAirMax ?? "MS - Nike Air Max 270 React...";
    price = price ?? "299,43";
    oldPrice = oldPrice ?? "534,33";
    offer = offer ?? "24% Off";
    id = id ?? "";
  }

  String? image;

  String? mSNikeAirMax;

  String? price;

  String? oldPrice;

  String? offer;

  String? id;
}
