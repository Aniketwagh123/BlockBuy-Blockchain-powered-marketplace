import '../../../core/app_export.dart';

/// This class is used in the [fsnikeairmax_item_widget] screen.
class FsnikeairmaxItemModel {
  FsnikeairmaxItemModel({
    this.image,
    this.fSNikeAirMax,
    this.price,
    this.oldPrice,
    this.offer,
    this.id,
  }) {
    image = image ?? ImageConstant.imgProductImage;
    fSNikeAirMax = fSNikeAirMax ?? "FS - Nike Air Max 270 React...";
    price = price ?? "299,43";
    oldPrice = oldPrice ?? "534,33";
    offer = offer ?? "24% Off";
    id = id ?? "";
  }

  String? image;

  String? fSNikeAirMax;

  String? price;

  String? oldPrice;

  String? offer;

  String? id;
}
