import '../../../core/app_export.dart';

/// This class is used in the [superflashsale_item_widget] screen.
class SuperflashsaleItemModel {
  SuperflashsaleItemModel({
    this.image,
    this.nikeAirMaxReact,
    this.price,
    this.oldPrice,
    this.offer,
    this.id,
  }) {
    image = image ?? ImageConstant.imgProductImage3;
    nikeAirMaxReact = nikeAirMaxReact ?? "Nike Air Max 270 React ENG";
    price = price ?? "299,43";
    oldPrice = oldPrice ?? "534,33";
    offer = offer ?? "24% Off";
    id = id ?? "";
  }

  String? image;

  String? nikeAirMaxReact;

  String? price;

  String? oldPrice;

  String? offer;

  String? id;
}
