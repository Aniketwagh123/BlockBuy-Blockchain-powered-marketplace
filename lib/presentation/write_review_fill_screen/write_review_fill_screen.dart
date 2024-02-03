import 'bloc/write_review_fill_bloc.dart';
import 'models/write_review_fill_model.dart';
import 'package:aniket_s_application1/core/app_export.dart';
import 'package:aniket_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:aniket_s_application1/widgets/app_bar/appbar_subtitle.dart';
import 'package:aniket_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:aniket_s_application1/widgets/custom_elevated_button.dart';
import 'package:aniket_s_application1/widgets/custom_rating_bar.dart';
import 'package:aniket_s_application1/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class WriteReviewFillScreen extends StatelessWidget {
  const WriteReviewFillScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<WriteReviewFillBloc>(
        create: (context) => WriteReviewFillBloc(WriteReviewFillState(
            writeReviewFillModelObj: WriteReviewFillModel()))
          ..add(WriteReviewFillInitialEvent()),
        child: WriteReviewFillScreen());
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 27.v),
                child: Column(children: [
                  _buildReviewSection(context),
                  SizedBox(height: 22.v),
                  _buildWriteReviewSection(context),
                  SizedBox(height: 5.v)
                ])),
            bottomNavigationBar: _buildWriteReviewButton(context)));
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
            text: "lbl_write_review".tr, margin: EdgeInsets.only(left: 12.h)));
  }

  /// Section Widget
  Widget _buildReviewSection(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          width: 343.h,
          child: Text("msg_please_write_overall".tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall!.copyWith(height: 1.50))),
      SizedBox(height: 13.v),
      CustomRatingBar(initialRating: 5, itemSize: 32)
    ]);
  }

  /// Section Widget
  Widget _buildWriteReviewSection(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("msg_write_your_review".tr, style: theme.textTheme.titleSmall),
      SizedBox(height: 13.v),
      BlocSelector<WriteReviewFillBloc, WriteReviewFillState,
              TextEditingController?>(
          selector: (state) => state.addReviewController,
          builder: (context, addReviewController) {
            return CustomTextFormField(
                controller: addReviewController,
                hintText: "lbl_add_review".tr,
                hintStyle: CustomTextStyles.labelLargeBluegray300,
                textInputAction: TextInputAction.done,
                maxLines: 8,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.h, vertical: 17.v));
          })
    ]);
  }

  /// Section Widget
  Widget _buildWriteReviewButton(BuildContext context) {
    return CustomElevatedButton(
        text: "lbl_write_review".tr,
        margin: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 34.v));
  }

  /// Navigates to the previous screen.
  onTapArrowLeft(BuildContext context) {
    NavigatorService.goBack();
  }
}
