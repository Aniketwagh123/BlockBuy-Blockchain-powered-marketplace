import '../../../core/app_export.dart';

/// This class is used in the [offerscreen_item_widget] screen.
class OfferscreenItemModel {
  OfferscreenItemModel({
    this.image,
    this.offer,
    this.hours,
    this.widget,
    this.minutes,
    this.widget1,
    this.secounds,
    this.id,
  }) {
    image = image ?? ImageConstant.imgPromotionImage;
    offer = offer ?? "Super Flash Sale\n50% Off";
    hours = hours ?? "08";
    widget = widget ?? ":";
    minutes = minutes ?? "34";
    widget1 = widget1 ?? ":";
    secounds = secounds ?? "52";
    id = id ?? "";
  }

  String? image;

  String? offer;

  String? hours;

  String? widget;

  String? minutes;

  String? widget1;

  String? secounds;

  String? id;
}
