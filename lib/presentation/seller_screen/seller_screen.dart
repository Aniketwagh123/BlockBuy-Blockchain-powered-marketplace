import 'package:aniket_s_application1/widgets/app_bar/appbar_leading_image.dart';
import 'package:flutter/material.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("seller screen"),
      ),
    );
  }
}