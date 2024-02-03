/// This class is used in the [orderlist_item_widget] screen.
class OrderlistItemModel {
  OrderlistItemModel({
    this.price,
    this.month,
    this.orderStatus,
    this.shipping,
    this.items,
    this.purchasedCount,
    this.price1,
    this.price2,
    this.id,
  }) {
    price = price ?? "SDG1345KJD";
    month = month ?? "Order at E-com : August 1, 2017";
    orderStatus = orderStatus ?? "Order Status";
    shipping = shipping ?? "Shipping";
    items = items ?? "Items";
    purchasedCount = purchasedCount ?? "1 Items purchased";
    price1 = price1 ?? "Price";
    price2 = price2 ?? "299,43";
    id = id ?? "";
  }

  String? price;

  String? month;

  String? orderStatus;

  String? shipping;

  String? items;

  String? purchasedCount;

  String? price1;

  String? price2;

  String? id;
}
