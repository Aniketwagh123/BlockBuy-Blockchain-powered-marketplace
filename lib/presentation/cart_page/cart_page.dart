import 'package:aniket_s_application1/core/app_export.dart';
import 'package:aniket_s_application1/presentation/cart_page/bloc/cart_bloc.dart';
import 'package:aniket_s_application1/presentation/cart_page/models/cart_model.dart';

import 'package:aniket_s_application1/widgets/app_bar/appbar_title.dart';
import 'package:aniket_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:aniket_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:aniket_s_application1/widgets/custom_elevated_button.dart';
import 'package:aniket_s_application1/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../cart_page/widgets/cartlist_item_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<CartBloc>(
      create: (context) => CartBloc(CartState(cartModelObj: CartModel()))
        ..add(CartInitialEvent()),
      child: CartPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: _buildAppBar(context),
            body: SingleChildScrollView(
              // Wrap the body in a SingleChildScrollView
              child: Container(
                  width: double.maxFinite,
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.h, vertical: 7.v),
                  child: Column(children: [
                    _buildCartList(context),
                    SizedBox(height: 52.v),
                    _buildCouponCodeRow(context),
                    SizedBox(height: 16.v),
                    _buildTotalPriceDetails(context),
                    SizedBox(height: 16.v),
                    CustomElevatedButton(
                        text: "lbl_check_out".tr,
                        onPressed: () {
                          onTapCheckOut(context);
                        }),
                    SizedBox(height: 8.v)
                  ])),
            )));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitle(
        text: "lbl_your_cart".tr,
        margin: EdgeInsets.only(left: 16.h),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgNotificationIcon,
          margin: EdgeInsets.fromLTRB(13.h, 15.v, 13.h, 16.v),
          onTap: () {
            onTapNotificationIcon(context);
          },
        ),
      ],
    );
  }

  Widget _buildCartList(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cartModelObj = state.cartModelObj;
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(height: 16.v),
          itemCount: cartModelObj?.cartlistItemList.length ?? 0,
          itemBuilder: (context, index) {
            final model = cartModelObj!.cartlistItemList[index];
            return CartlistItemWidget(model);
          },
        );
      },
    );
  }

  Widget _buildCouponCodeRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              final cuponCodeController = state.cuponCodeController;
              return CustomTextFormField(
                controller: cuponCodeController,
                hintText: "msg_enter_cupon_code".tr,
                textInputAction: TextInputAction.done,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.h, vertical: 19.v),
              );
            },
          ),
        ),
        CustomElevatedButton(
          width: 87.h,
          text: "lbl_apply".tr,
          buttonStyle: CustomButtonStyles.fillPrimary,
          buttonTextStyle: CustomTextStyles.labelLargeOnPrimaryContainer,
          onPressed: () {
            // Implement applying coupon code logic here
          },
        ),
      ],
    );
  }

  Widget _buildTotalPriceDetails(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cartModelObj = state.cartModelObj;
        double totalPrice = 0.0;
        if (cartModelObj != null && cartModelObj.cartlistItemList.isNotEmpty) {
          totalPrice = cartModelObj.cartlistItemList
              .map((item) => double.parse(item.price ?? '0'))
              .reduce((value, element) => value + element);
        }
        return Container(
          padding: EdgeInsets.all(15.h),
          decoration: AppDecoration.outlineBlue50.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder5,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Items (${cartModelObj?.cartlistItemList.length ?? 0})",
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    '$totalPrice',
                    style: CustomTextStyles.bodySmallOnPrimary,
                  ),
                ],
              ),
              SizedBox(height: 16.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 1.v),
                    child: Text("lbl_shipping".tr,
                        style: theme.textTheme.bodySmall),
                  ),
                  Text("\$ 1.00".tr,
                      style: CustomTextStyles.bodySmallOnPrimary),
                ],
              ),
              SizedBox(height: 14.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 1.v),
                    child: Text("GST", style: theme.textTheme.bodySmall),
                  ),
                  Text("NA", style: CustomTextStyles.bodySmallOnPrimary),
                ],
              ),
              SizedBox(height: 12.v),
              Divider(),
              SizedBox(height: 10.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("lbl_total_price".tr, style: theme.textTheme.labelLarge),
                  Text("${totalPrice + 1}".tr,
                      style: CustomTextStyles.labelLargePrimary),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void onTapNotificationIcon(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.notificationScreen);
  }

  void onTapCheckOut(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.shipToScreen);
  }
}
