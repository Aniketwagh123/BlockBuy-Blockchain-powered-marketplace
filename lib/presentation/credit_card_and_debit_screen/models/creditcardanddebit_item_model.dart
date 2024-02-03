/// This class is used in the [creditcardanddebit_item_widget] screen.
class CreditcardanddebitItemModel {
  CreditcardanddebitItemModel({
    this.debitCardNumber,
    this.cardholder,
    this.cardsave,
    this.dominicOvo,
    this.debitCardExpiry,
    this.id,
  }) {
    debitCardNumber = debitCardNumber ?? "6326    9124    8124    9875";
    cardholder = cardholder ?? "CARD HOLDER";
    cardsave = cardsave ?? "CARD SAVE";
    dominicOvo = dominicOvo ?? "Dominic Ovo";
    debitCardExpiry = debitCardExpiry ?? "06/24";
    id = id ?? "";
  }

  String? debitCardNumber;

  String? cardholder;

  String? cardsave;

  String? dominicOvo;

  String? debitCardExpiry;

  String? id;
}
