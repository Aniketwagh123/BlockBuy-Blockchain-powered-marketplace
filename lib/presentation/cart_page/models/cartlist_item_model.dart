/// This class is used in the [cartlist_item_widget] screen.
class CartlistItemModel {
  CartlistItemModel({
    this.cartItemImagePath,
    this.nikeAirZoomPegasus,
    this.price,
    this.one,
    this.id,
  }) {
    nikeAirZoomPegasus = nikeAirZoomPegasus ?? "Nike Air Zoom Pegasus 36 Miami";
    price = price ?? "299,43";
    one = one ?? "1";
    id = id ?? "";
    cartItemImagePath = cartItemImagePath ?? "";
  }

  String? cartItemImagePath;

  String? nikeAirZoomPegasus;

  String? price;

  String? one;

  String? id;
}
