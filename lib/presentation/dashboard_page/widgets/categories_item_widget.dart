import '../models/categories_item_model.dart';
import 'package:aniket_s_application1/core/app_export.dart';
import 'package:aniket_s_application1/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoriesItemWidget extends StatelessWidget {
  CategoriesItemWidget(
    this.categoriesItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  CategoriesItemModel categoriesItemModelObj;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70.h,
      child: Padding(
        padding: EdgeInsets.only(bottom: 15.v),
        child: Column(
          children: [
            CustomIconButton(
              height: 70.adaptSize,
              width: 70.adaptSize,
              padding: EdgeInsets.all(23.h),
              child: CustomImageView(
                imagePath: categoriesItemModelObj?.arrowLeft,
              ),
            ),
            SizedBox(height: 7.v),
            Text(
              categoriesItemModelObj.manShirt!,
              style: CustomTextStyles.bodySmall10,
            ),
          ],
        ),
      ),
    );
  }
}
