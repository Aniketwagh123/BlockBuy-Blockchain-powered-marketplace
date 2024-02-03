import 'bloc/notification_bloc.dart';
import 'models/notification_model.dart';
import 'package:aniket_s_application1/core/app_export.dart';
import 'package:aniket_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:aniket_s_application1/widgets/app_bar/appbar_subtitle.dart';
import 'package:aniket_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<NotificationBloc>(
        create: (context) => NotificationBloc(
            NotificationState(notificationModelObj: NotificationModel()))
          ..add(NotificationInitialEvent()),
        child: NotificationScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              appBar: _buildAppBar(context),
              body: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 12.v),
                  child: Column(children: [
                    _buildNotificationOption(context,
                        userImage: ImageConstant.imgOffer,
                        feedLabel: "lbl_offer".tr, onTapNotificationOption: () {
                      onTapNotificationOption(context);
                    }),
                    _buildNotificationOption(context,
                        userImage: ImageConstant.imgListIcon,
                        feedLabel: "lbl_feed".tr),
                    SizedBox(height: 5.v),
                    _buildNotificationOption(context,
                        userImage: ImageConstant.imgNotificationIconPrimary,
                        feedLabel: "lbl_acivity".tr,
                        onTapNotificationOption: () {
                      onTapNotificationOption1(context);
                    })
                  ]))));
    });
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeftBlueGray300,
            margin: EdgeInsets.only(left: 16.h, top: 16.v, bottom: 15.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title: AppbarSubtitle(
            text: "lbl_notification".tr, margin: EdgeInsets.only(left: 12.h)));
  }

  /// Common widget
  Widget _buildNotificationOption(
    BuildContext context, {
    required String userImage,
    required String feedLabel,
    Function? onTapNotificationOption,
  }) {
    return GestureDetector(
        onTap: () {
          onTapNotificationOption!.call();
        },
        child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(16.h),
            decoration: AppDecoration.fillOnPrimaryContainer,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomImageView(
                  imagePath: userImage,
                  height: 24.adaptSize,
                  width: 24.adaptSize),
              Padding(
                  padding: EdgeInsets.only(left: 16.h, top: 2.v, bottom: 3.v),
                  child: Text(feedLabel,
                      style: theme.textTheme.labelLarge!.copyWith(
                          color: theme.colorScheme.onPrimary.withOpacity(1))))
            ])));
  }

  /// Navigates to the previous screen.
  onTapArrowLeft(BuildContext context) {
    NavigatorService.goBack();
  }

  /// Navigates to the notificationOfferScreen when the action is triggered.
  onTapNotificationOption(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.notificationOfferScreen,
    );
  }

  /// Navigates to the notificationActivityScreen when the action is triggered.
  onTapNotificationOption1(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.notificationActivityScreen,
    );
  }
}
