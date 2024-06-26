import 'bloc/profile_bloc.dart';
import 'models/profile_model.dart';
import 'package:aniket_s_application1/core/app_export.dart';
import 'package:aniket_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:aniket_s_application1/widgets/app_bar/appbar_subtitle.dart';
import 'package:aniket_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<ProfileBloc>(
        create: (context) =>
            ProfileBloc(ProfileState(profileModelObj: ProfileModel()))
              ..add(ProfileInitialEvent()),
        child: ProfileScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              appBar: _buildAppBar(context),
              body: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 36.v),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 16.h),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomImageView(
                                      imagePath:
                                          ImageConstant.imgProfilePicture72x72,
                                      height: 72.adaptSize,
                                      width: 72.adaptSize,
                                      radius: BorderRadius.circular(36.h)),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 16.h, top: 9.v, bottom: 14.v),
                                      child: Column(children: [
                                        Text("lbl_dominic_ovo".tr,
                                            style: theme.textTheme.titleSmall),
                                        SizedBox(height: 8.v),
                                        Text("lbl_dominic_ovo2".tr,
                                            style: theme.textTheme.bodySmall)
                                      ]))
                                ])),
                        SizedBox(height: 32.v),
                        _buildProfileDetailOption(context,
                            dateIcon: ImageConstant.imgGenderIcon,
                            birthday: "lbl_gender".tr,
                            birthDateValue: "lbl_male".tr),
                        _buildProfileDetailOption(context,
                            dateIcon: ImageConstant.imgDateIcon,
                            birthday: "lbl_birthday".tr,
                            birthDateValue: "lbl_12_12_2000".tr),
                        _buildProfileDetailOption(context,
                            dateIcon: ImageConstant.imgMailPrimary,
                            birthday: "lbl_email".tr,
                            birthDateValue: "msg_rex4dom_gmail_com".tr),
                        _buildProfileDetailOption(context,
                            dateIcon: ImageConstant.imgCreditCardIcon,
                            birthday: "lbl_phone_number".tr,
                            birthDateValue: "lbl_307_555_0133".tr),
                        SizedBox(height: 5.v),
                        _buildProfileDetailOption(context,
                            dateIcon: ImageConstant.imgLockPrimary,
                            birthday: "lbl_change_password".tr,
                            birthDateValue: "msg".tr,
                            onTapProfileDetailOption: () {
                          onTapProfileDetailOption(context);
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
            text: "lbl_profile".tr, margin: EdgeInsets.only(left: 12.h)));
  }

  /// Common widget
  Widget _buildProfileDetailOption(
    BuildContext context, {
    required String dateIcon,
    required String birthday,
    required String birthDateValue,
    Function? onTapProfileDetailOption,
  }) {
    return GestureDetector(
        onTap: () {
          onTapProfileDetailOption!.call();
        },
        child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 15.v),
            decoration: AppDecoration.fillOnPrimaryContainer,
            child: Row(children: [
              CustomImageView(
                  imagePath: dateIcon,
                  height: 24.adaptSize,
                  width: 24.adaptSize),
              Padding(
                  padding: EdgeInsets.only(left: 16.h, top: 3.v, bottom: 2.v),
                  child: Text(birthday,
                      style: theme.textTheme.labelLarge!.copyWith(
                          color: theme.colorScheme.onPrimary.withOpacity(1)))),
              Spacer(),
              Padding(
                  padding: EdgeInsets.only(top: 2.v, bottom: 3.v),
                  child: Text(birthDateValue,
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: appTheme.blueGray300))),
              CustomImageView(
                  imagePath: ImageConstant.imgRightIcon,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  margin: EdgeInsets.only(left: 16.h))
            ])));
  }

  /// Navigates to the previous screen.
  onTapArrowLeft(BuildContext context) {
    NavigatorService.goBack();
  }

  /// Navigates to the changePasswordScreen when the action is triggered.
  onTapProfileDetailOption(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.changePasswordScreen,
    );
  }
}
