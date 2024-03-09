import 'dart:typed_data';

import 'package:aniket_s_application1/presentation/offer_screen_page/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aniket_s_application1/presentation/offer_screen_page/bloc/offer_screen_bloc.dart';
import 'package:aniket_s_application1/widgets/custom_elevated_button.dart';
import 'package:aniket_s_application1/widgets/custom_image_view.dart';
import 'package:aniket_s_application1/widgets/custom_text_form_field.dart'; // Import CustomTextFormField

class OfferScreenPage extends StatelessWidget {
  OfferScreenPage({Key? key}) : super(key: key);

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _sellerEmailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _materialController = TextEditingController();
  List<Uint8List> imageDataList = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OfferScreenBloc(),
      child: BlocBuilder<OfferScreenBloc, OfferScreenState>(
        builder: (context, state) {
          if (state is InitialState || state is ImagesSelectedState) {
            return buildInitialUI(context, state);
          } else if (state is ProductAddedState) {
            return buildProductAddedUI();
          } else if (state is ErrorState) {
            return buildErrorUI(context, state.errorMessage);
          } else if (state is LoadingState) {
            return buildLoadingUI(context, state.loadingMessage);
          }
          return Container(); // Return empty container as default
        },
      ),
    );
  }

  Widget buildInitialUI(BuildContext context, OfferScreenState state) {
    if (state is ImagesSelectedState) {
      imageDataList.addAll((state).imageDataList);
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Products"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Product Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _productNameController,
                  hintText: 'Product Name',
                  // borderDecoration: const OutlineInputBorder()
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _sellerEmailController,
                  hintText: 'Seller Email',
                  // textInputType: TextInputType.emailAddress,
                  // borderDecoration: const OutlineInputBorder()
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _descriptionController,
                  hintText: 'Description',
                  maxLines: 3,
                  // borderDecoration: CustomTextFormField.outlineBlueTL5,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _priceController,
                  hintText: 'Price',
                  // textInputType: TextInputType.text,
                  // borderDecoration: CustomTextFormField.outlineBlueTL5,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _categoryController,
                  hintText: 'Category',
                  // borderDecoration: CustomTextFormField.outlineBlueTL5,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _stockController,
                  hintText: 'Stock',
                  // textInputType: TextInputType.number,
                  // borderDecoration: CustomTextFormField.outlineBlueTL5,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _colorController,
                  hintText: 'Color',
                  // borderDecoration: CustomTextFormField.outlineBlueTL5,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _sizeController,
                  hintText: 'Size',
                  // borderDecoration: CustomTextFormField.outlineBlueTL5,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _materialController,
                  hintText: 'Material',
                  // borderDecoration: CustomTextFormField.outlineBlueTL5,
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  text: 'Select Images',
                  onPressed: () {
                    BlocProvider.of<OfferScreenBloc>(context)
                        .add(PickImagesEvent());
                  },
                  margin: const EdgeInsets.symmetric(horizontal: 100),
                  rightIcon: const Icon(Icons.upload_file),
                  buttonStyle: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueGrey,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                ),
                if (state is ImagesSelectedState)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Selected Images:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: (state)
                            .imageDataList
                            .map((imageData) => Image.memory(
                                  imageData,
                                  width: 100,
                                  height: 100,
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  text: 'Add Product',
                  onPressed: () {
                    final product = Product(
                      productName: _productNameController.text.trim(),
                      sellerEmail:
                          _sellerEmailController.text.toLowerCase().trim(),
                      description: _descriptionController.text.trim(),
                      price: _priceController.text.trim().isEmpty
                          ? 0
                          : double.parse(_priceController.text.trim()),
                      category: _categoryController.text.trim(),
                      stock: _stockController.text.trim().isEmpty
                          ? 0
                          : int.parse(_stockController.text.trim()),
                      colors: _colorController.text
                          .split(',')
                          .map((color) => color.trim())
                          .toList(),
                      sizes: _sizeController.text
                          .split(',')
                          .map((size) => size.trim())
                          .toList(),
                      material: _materialController.text.trim(),
                      imagePaths: [],
                    );

                    BlocProvider.of<OfferScreenBloc>(context)
                        .add(AddProductEvent(product,imageDataList));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProductAddedUI() {
    return const Center(
      child: Text(
        'Product Added Successfully!',
        style: TextStyle(
          color: Colors.green,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildErrorUI(BuildContext context, String errorMessage) {
    return Scaffold(
      body: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  Widget buildLoadingUI(BuildContext context, String errorMessage) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(errorMessage),
          ],
        ),
      ),
    );
  }
}
