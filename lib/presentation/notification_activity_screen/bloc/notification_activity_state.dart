// ignore_for_file: must_be_immutable

part of 'notification_activity_bloc.dart';

/// Represents the state of NotificationActivity in the application.
class NotificationActivityState extends Equatable {
  NotificationActivityState({this.notificationActivityModelObj});

  NotificationActivityModel? notificationActivityModelObj;

  @override
  List<Object?> get props => [
        notificationActivityModelObj,
      ];
  NotificationActivityState copyWith(
      {NotificationActivityModel? notificationActivityModelObj}) {
    return NotificationActivityState(
      notificationActivityModelObj:
          notificationActivityModelObj ?? this.notificationActivityModelObj,
    );
  }
}
