import 'package:web3modal_flutter/web3modal_flutter.dart';

import '../product_detail_screen/widgets/fortyeight_item_widget.dart';
import '../product_detail_screen/widgets/products_item_widget.dart';
import '../product_detail_screen/widgets/recomended_item_widget.dart';
import '../product_detail_screen/widgets/sizes_item_widget.dart';
import 'bloc/product_detail_bloc.dart';
import 'models/fortyeight_item_model.dart';
import 'models/product_detail_model.dart';
import 'models/products_item_model.dart';
import 'models/recomended_item_model.dart';
import 'models/sizes_item_model.dart';
import 'package:aniket_s_application1/core/app_export.dart';
import 'package:aniket_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:aniket_s_application1/widgets/app_bar/appbar_subtitle.dart';
import 'package:aniket_s_application1/widgets/app_bar/appbar_trailing_image.dart';
import 'package:aniket_s_application1/widgets/app_bar/custom_app_bar.dart';
import 'package:aniket_s_application1/widgets/custom_elevated_button.dart';
import 'package:aniket_s_application1/widgets/custom_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);
  static Map<String, dynamic>? arguments;

  static Widget builder(BuildContext context) {
    arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print("args passed ==>>$arguments");
    return BlocProvider<ProductDetailBloc>(
      create: (context) => ProductDetailBloc(
          ProductDetailState(productDetailModelObj: ProductDetailModel()))
        ..add(ProductDetailInitialEvent()),
      child: ProductDetailScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    // Calculate the screen height
    double screenHeight = mediaQueryData.size.height;

    return SafeArea(
      bottom: false,
      top: false, // Remove the bottom padding
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          height: screenHeight, // Set the height to the screen height
          padding: EdgeInsets.symmetric(vertical: 9.v),
          child: Column(
            children: [
              SizedBox(height: 12.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5.v),
                    child: Column(
                      children: [
                        _buildProductOverview(context),
                        SizedBox(height: 22.v),
                        _buildSelectSize(context),
                        SizedBox(height: 23.v),
                        _buildSelectColor(context),
                        SizedBox(height: 24.v),
                        _buildSpecifications(context),
                        SizedBox(height: 23.v),
                        _buildReview(context),
                        SizedBox(height: 23.v),
                        _buildYouMightAlsoLike(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildAddToCart(context),
      ),
    );
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
            text: "Product Detail", margin: EdgeInsets.only(left: 12.h)),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgNavExplore,
              margin: EdgeInsets.only(left: 16.h, top: 16.v, right: 15.h),
              onTap: () {
                onTapSearchIcon(context);
              }),
          AppbarTrailingImage(
              imagePath: ImageConstant.imgMoreIcon,
              margin: EdgeInsets.only(left: 16.h, top: 16.v, right: 31.h))
        ]);
  }

  /// Section Widget
  Widget _buildProductOverview(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
        return CarouselSlider.builder(
            options: CarouselOptions(
                height: 238.v,
                initialPage: 0,
                autoPlay: true,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  state.sliderIndex = index;
                }),
            itemCount:
                state.productDetailModelObj?.fortyeightItemList.length ?? 0,
            itemBuilder: (context, index, realIndex) {
              FortyeightItemModel model =
                  state.productDetailModelObj?.fortyeightItemList[index] ??
                      FortyeightItemModel();
              return FortyeightItemWidget(model);
            });
      }),
      SizedBox(height: 16.v),
      Align(
          alignment: Alignment.center,
          child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
              builder: (context, state) {
            return SizedBox(
                height: 8.v,
                child: AnimatedSmoothIndicator(
                    activeIndex: state.sliderIndex,
                    count: state
                            .productDetailModelObj?.fortyeightItemList.length ??
                        0,
                    axisDirection: Axis.horizontal,
                    effect: ScrollingDotsEffect(
                        spacing: 8,
                        activeDotColor:
                            theme.colorScheme.primary.withOpacity(1),
                        dotColor: appTheme.blue50,
                        dotHeight: 8.v,
                        dotWidth: 8.h)));
          })),
      SizedBox(height: 15.v),
      Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.only(left: 16.h, right: 25.h),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: SizedBox(
                            width: 275.h,
                            child: Text(arguments?['productName'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyles.titleLargeOnPrimary
                                    .copyWith(height: 1.50)))),
                    CustomImageView(
                        imagePath: ImageConstant.imgDownload,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        margin:
                            EdgeInsets.only(left: 44.h, top: 2.v, bottom: 32.v))
                  ]))),
      SizedBox(height: 9.v),
      Padding(
          padding: EdgeInsets.only(left: 16.h),
          child: CustomRatingBar(initialRating: 4, itemSize: 16)),
      SizedBox(height: 16.v),
      Padding(
          padding: EdgeInsets.only(left: 16.h),
          child: Text("\$ ${arguments?['price']}",
              style: theme.textTheme.titleLarge))
    ]);
  }

  /// Section Widget
  Widget _buildSelectSize(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.only(left: 16.h),
          child: Text("lbl_select_size".tr, style: theme.textTheme.titleSmall)),
      SizedBox(height: 13.v),
      SizedBox(
          height: 48.v,
          child: BlocSelector<ProductDetailBloc, ProductDetailState,
                  ProductDetailModel?>(
              selector: (state) => state.productDetailModelObj,
              builder: (context, productDetailModelObj) {
                return ListView.separated(
                    padding: EdgeInsets.only(left: 16.h),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 16.h);
                    },
                    itemCount: productDetailModelObj?.sizesItemList.length ?? 0,
                    itemBuilder: (context, index) {
                      SizesItemModel model =
                          productDetailModelObj?.sizesItemList[index] ??
                              SizesItemModel();
                      return SizesItemWidget(model);
                    });
              }))
    ]);
  }

  /// Section Widget
  Widget _buildSelectColor(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 9.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.only(left: 7.h),
              child: Text("lbl_select_color".tr,
                  style: theme.textTheme.titleSmall)),
          SizedBox(height: 12.v),
          CustomImageView(
              imagePath: ImageConstant.imgColors,
              height: 48.v,
              width: 359.h,
              margin: EdgeInsets.only(left: 7.h))
        ]));
  }

  /// Section Widget
  Widget _buildSpecifications(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("lbl_specification".tr, style: theme.textTheme.titleSmall),
          SizedBox(height: 12.v),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: EdgeInsets.only(bottom: 45.v),
                child: Text("Seller Email",
                    style: CustomTextStyles.bodySmallOnPrimary)),
            Container(
                width: 169.adaptSize,
                margin: EdgeInsets.only(left: 128.adaptSize),
                child: Text(arguments?['sellerEmail'],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodySmall!.copyWith(height: 1.80)))
          ]),
          SizedBox(height: 1.v),
          Row(children: [
            Padding(
                padding: EdgeInsets.only(top: 1.v),
                child: Text("Material".tr,
                    style: CustomTextStyles.bodySmallOnPrimary)),
            Padding(
                padding: EdgeInsets.only(left: 234.h),
                child: Text(arguments?['material'],
                    style: theme.textTheme.bodySmall))
          ]),
          SizedBox(height: 19.v),
          Container(
              width: 320.h,
              margin: EdgeInsets.only(right: 31.h),
              child: Text(arguments?['description'],
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall!.copyWith(height: 1.80)))
        ]));
  }

  /// Section Widget
  Widget _buildReview(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text("lbl_review_product".tr, style: theme.textTheme.titleSmall),
            GestureDetector(
                onTap: () {
                  onTapTxtSeeMoreLink(context);
                },
                child: Padding(
                    padding: EdgeInsets.only(left: 156.h),
                    child: Text("lbl_see_more".tr,
                        style: CustomTextStyles.titleSmallPrimary)))
          ]),
          SizedBox(height: 8.v),
          Row(children: [
            CustomRatingBar(initialRating: 4, itemSize: 16),
            Padding(
                padding: EdgeInsets.only(left: 8.h),
                child: Text("lbl_4_5".tr,
                    style: CustomTextStyles.labelMediumBluegray300)),
            Padding(
                padding: EdgeInsets.only(left: 3.h),
                child: Text("lbl_5_review".tr,
                    style: CustomTextStyles.bodySmall10))
          ]),
          SizedBox(height: 16.v),
          Row(children: [
            CustomImageView(
                imagePath: ImageConstant.imgProfilePicture,
                height: 48.adaptSize,
                width: 48.adaptSize,
                radius: BorderRadius.circular(24.h)),
            Padding(
                padding: EdgeInsets.only(left: 16.h, top: 2.v, bottom: 4.v),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("lbl_james_lawson".tr,
                          style: theme.textTheme.titleSmall),
                      SizedBox(height: 4.v),
                      CustomRatingBar(initialRating: 4, itemSize: 16)
                    ]))
          ]),
          SizedBox(height: 18.v),
          SizedBox(
              width: 339.h,
              child: Text("msg_air_max_are_always".tr,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall!.copyWith(height: 1.80))),
          SizedBox(height: 16.v),
          SizedBox(
              height: 72.v,
              child: BlocSelector<ProductDetailBloc, ProductDetailState,
                      ProductDetailModel?>(
                  selector: (state) => state.productDetailModelObj,
                  builder: (context, productDetailModelObj) {
                    return ListView.separated(
                        padding: EdgeInsets.only(right: 112.h),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 12.h);
                        },
                        itemCount:
                            productDetailModelObj?.productsItemList.length ?? 0,
                        itemBuilder: (context, index) {
                          ProductsItemModel model =
                              productDetailModelObj?.productsItemList[index] ??
                                  ProductsItemModel();
                          return ProductsItemWidget(model);
                        });
                  })),
          SizedBox(height: 16.v),
          Text("msg_december_10_2016".tr, style: CustomTextStyles.bodySmall10)
        ]));
  }

  /// Section Widget
  Widget _buildYouMightAlsoLike(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.only(left: 16.h),
          child: Text("msg_you_might_also_like".tr,
              style: CustomTextStyles.titleSmall_1)),
      SizedBox(height: 11.v),
      Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
              height: 238.v,
              child: BlocSelector<ProductDetailBloc, ProductDetailState,
                      ProductDetailModel?>(
                  selector: (state) => state.productDetailModelObj,
                  builder: (context, productDetailModelObj) {
                    return ListView.separated(
                        padding: EdgeInsets.only(left: 16.h),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 16.h);
                        },
                        itemCount:
                            productDetailModelObj?.recomendedItemList.length ??
                                0,
                        itemBuilder: (context, index) {
                          RecomendedItemModel model = productDetailModelObj
                                  ?.recomendedItemList[index] ??
                              RecomendedItemModel();
                          return RecomendedItemWidget(model);
                        });
                  })))
    ]);
  }

  /// Section Widget
  Widget _buildAddToCart(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_add_to_cart".tr,
      margin: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 50.v),
      onPressed: () async {
        SharedPreferences sp = await SharedPreferences.getInstance();
        String cartItem =
            "${_getIPFSpath(arguments?['imagePaths'][0] ?? "")},${arguments?['productName'] ?? ""},${arguments?['price'] ?? ""}";
        List<String> items = sp.getStringList('cart') ?? [];
        items.add(cartItem);
        sp.setStringList('cart', items);
        // ignore: use_build_context_synchronously
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 100,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.check_circle, color: Colors.green, size: 40),
                    SizedBox(height: 8),
                    Text('Product added to cart successfully',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Navigates to the previous screen.
  onTapArrowLeft(BuildContext context) {
    NavigatorService.goBack();
  }

  /// Navigates to the searchScreen when the action is triggered.
  onTapSearchIcon(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.searchScreen,
    );
  }

  /// Navigates to the reviewProductScreen when the action is triggered.
  onTapTxtSeeMoreLink(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.reviewProductScreen,
    );
  }

  String _getIPFSpath(String hash) {
    return 'https://ivory-capable-basilisk-139.mypinata.cloud/ipfs/${hash}?pinataGatewayToken=1ROdYSQDquDO-YnO-pxxqQzly6dWUl89hzcRtKVVovYsB7x4AGr1ZV-LzRCpQBUj';
  }
}
