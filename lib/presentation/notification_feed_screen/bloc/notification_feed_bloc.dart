import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import '../models/notificationfeed_item_model.dart';
import 'package:aniket_s_application1/presentation/notification_feed_screen/models/notification_feed_model.dart';
part 'notification_feed_event.dart';
part 'notification_feed_state.dart';

/// A bloc that manages the state of a NotificationFeed according to the event that is dispatched to it.
class NotificationFeedBloc
    extends Bloc<NotificationFeedEvent, NotificationFeedState> {
  NotificationFeedBloc(NotificationFeedState initialState)
      : super(initialState) {
    on<NotificationFeedInitialEvent>(_onInitialize);
  }

  _onInitialize(
    NotificationFeedInitialEvent event,
    Emitter<NotificationFeedState> emit,
  ) async {
    emit(state.copyWith(
        notificationFeedModelObj: state.notificationFeedModelObj?.copyWith(
            notificationfeedItemList: fillNotificationfeedItemList())));
  }

  List<NotificationfeedItemModel> fillNotificationfeedItemList() {
    return [
      NotificationfeedItemModel(
          newProduct: ImageConstant.imgProductImage,
          newProduct1: "New Product",
          nikeAirZoomPegasus:
              "Nike Air Zoom Pegasus 36 Miami - Special For your Activity",
          time: "June 3, 2015 5:06 PM"),
      NotificationfeedItemModel(
          newProduct: ImageConstant.imgImageProduct,
          newProduct1: "Best Product",
          nikeAirZoomPegasus:
              "Nike Air Zoom Pegasus 36 Miami - Special For your Activity",
          time: "June 3, 2015 5:06 PM"),
      NotificationfeedItemModel(
          newProduct: ImageConstant.imgProductImage1,
          newProduct1: "New Product",
          nikeAirZoomPegasus:
              "Nike Air Zoom Pegasus 36 Miami - Special For your Activity",
          time: "June 3, 2015 5:06 PM")
    ];
  }
}
