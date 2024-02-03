import '../../../core/app_export.dart';

/// This class is used in the [notificationfeed_item_widget] screen.
class NotificationfeedItemModel {
  NotificationfeedItemModel({
    this.newProduct,
    this.newProduct1,
    this.nikeAirZoomPegasus,
    this.time,
    this.id,
  }) {
    newProduct = newProduct ?? ImageConstant.imgProductImage;
    newProduct1 = newProduct1 ?? "New Product";
    nikeAirZoomPegasus = nikeAirZoomPegasus ??
        "Nike Air Zoom Pegasus 36 Miami - Special For your Activity";
    time = time ?? "June 3, 2015 5:06 PM";
    id = id ?? "";
  }

  String? newProduct;

  String? newProduct1;

  String? nikeAirZoomPegasus;

  String? time;

  String? id;
}
