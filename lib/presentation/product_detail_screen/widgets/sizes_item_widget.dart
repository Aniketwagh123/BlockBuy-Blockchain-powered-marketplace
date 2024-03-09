import '../models/sizes_item_model.dart';
import 'package:aniket_s_application1/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SizesItemWidget extends StatelessWidget {
  SizesItemWidget(
    this.sizesItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  SizesItemModel sizesItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.adaptSize,
      padding: EdgeInsets.symmetric(
        horizontal: 19.h,
        vertical: 13.v,
      ),
      decoration: AppDecoration.outlineBlue.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder24,
      ),
      child: Text(
        sizesItemModelObj.six!,
        style: theme.textTheme.titleSmall,
        overflow: TextOverflow.ellipsis, // or TextOverflow.clip, TextOverflow.fade
        textAlign: TextAlign.center, 
      ),
    );
  }
}
