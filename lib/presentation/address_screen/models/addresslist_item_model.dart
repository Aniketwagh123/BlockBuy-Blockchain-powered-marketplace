/// This class is used in the [addresslist_item_widget] screen.
class AddresslistItemModel {
  AddresslistItemModel({
    this.priscekila,
    this.address,
    this.mobileNo,
    this.edit,
    this.delete,
    this.id,
  }) {
    priscekila = priscekila ?? "Priscekila";
    address = address ??
        "3711 Spring Hill Rd undefined Tallahassee, Nevada 52874 United States";
    mobileNo = mobileNo ?? "+99 1234567890";
    edit = edit ?? "Edit";
    delete = delete ?? "Delete";
    id = id ?? "";
  }

  String? priscekila;

  String? address;

  String? mobileNo;

  String? edit;

  String? delete;

  String? id;
}
