import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import '../models/creditcard_item_model.dart';
import 'package:aniket_s_application1/presentation/choose_credit_or_debit_card_screen/models/choose_credit_or_debit_card_model.dart';
part 'choose_credit_or_debit_card_event.dart';
part 'choose_credit_or_debit_card_state.dart';

/// A bloc that manages the state of a ChooseCreditOrDebitCard according to the event that is dispatched to it.
class ChooseCreditOrDebitCardBloc
    extends Bloc<ChooseCreditOrDebitCardEvent, ChooseCreditOrDebitCardState> {
  ChooseCreditOrDebitCardBloc(ChooseCreditOrDebitCardState initialState)
      : super(initialState) {
    on<ChooseCreditOrDebitCardInitialEvent>(_onInitialize);
  }

  List<CreditcardItemModel> fillCreditcardItemList() {
    return List.generate(1, (index) => CreditcardItemModel());
  }

  _onInitialize(
    ChooseCreditOrDebitCardInitialEvent event,
    Emitter<ChooseCreditOrDebitCardState> emit,
  ) async {
    emit(state.copyWith(sliderIndex: 0));
    emit(state.copyWith(
        chooseCreditOrDebitCardModelObj: state.chooseCreditOrDebitCardModelObj
            ?.copyWith(creditcardItemList: fillCreditcardItemList())));
  }
}
