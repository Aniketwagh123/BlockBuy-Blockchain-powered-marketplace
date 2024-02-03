// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'creditcard_item_model.dart';

/// This class defines the variables used in the [choose_credit_or_debit_card_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class ChooseCreditOrDebitCardModel extends Equatable {
  ChooseCreditOrDebitCardModel({this.creditcardItemList = const []}) {}

  List<CreditcardItemModel> creditcardItemList;

  ChooseCreditOrDebitCardModel copyWith(
      {List<CreditcardItemModel>? creditcardItemList}) {
    return ChooseCreditOrDebitCardModel(
      creditcardItemList: creditcardItemList ?? this.creditcardItemList,
    );
  }

  @override
  List<Object?> get props => [creditcardItemList];
}
