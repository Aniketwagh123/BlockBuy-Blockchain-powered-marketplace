import '../models/fortyeight_item_model.dart';
import 'package:aniket_s_application1/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FortyeightItemWidget extends StatelessWidget {
  FortyeightItemWidget(
    this.fortyeightItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  FortyeightItemModel fortyeightItemModelObj;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return CustomImageView(
      imagePath: _getIPFSpath(arguments?['imagePaths'][0]),
      height: 238.v,
      width: 375.h,
    );
  }

  String _getIPFSpath(String hash){
    return 'https://ivory-capable-basilisk-139.mypinata.cloud/ipfs/${hash}?pinataGatewayToken=1ROdYSQDquDO-YnO-pxxqQzly6dWUl89hzcRtKVVovYsB7x4AGr1ZV-LzRCpQBUj';
  }
}
