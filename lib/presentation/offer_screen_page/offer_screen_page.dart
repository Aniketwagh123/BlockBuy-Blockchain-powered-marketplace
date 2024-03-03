import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aniket_s_application1/presentation/offer_screen_page/bloc/offer_screen_bloc.dart';
import 'package:aniket_s_application1/widgets/custom_elevated_button.dart';
import 'package:aniket_s_application1/widgets/custom_image_view.dart';

class OfferScreenPage extends StatelessWidget {
  OfferScreenPage({Key? key}) : super(key: key);

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _materialController = TextEditingController();
  List<String> imagePaths=[];
  

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
          }
          else if (state is ErrorState) {
            return buildErrorUI(context, state.errorMessage);
          }
          return Container(); // Return empty container as default
        },
      ),
    );
  }

  Widget buildInitialUI(BuildContext context, OfferScreenState state) {
    if (state is ImagesSelectedState) {
      imagePaths.addAll((state).imagePaths);
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
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _productNameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _categoryController,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _stockController,
                  decoration: const InputDecoration(
                    labelText: 'Stock',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _colorController,
                  decoration: const InputDecoration(
                    labelText: 'Color',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _sizeController,
                  decoration: const InputDecoration(
                    labelText: 'Size',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _materialController,
                  decoration: const InputDecoration(
                    labelText: 'Material',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  text: 'Select Images',
                  onPressed: () {
                    BlocProvider.of<OfferScreenBloc>(context).add(PickImagesEvent());
                  },
                  margin: const EdgeInsets.symmetric(horizontal: 100),
                  rightIcon: const Icon(Icons.upload_file),
                  buttonStyle: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16), // Padding around button text
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Button border radius
                    ),
                    elevation: 0, // Remove button shadow
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
                        children: (state as ImagesSelectedState).imagePaths
                            .map((image) => CustomImageView(
                                  imagePath: image,
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
                    
                    BlocProvider.of<OfferScreenBloc>(context).add(AddProductEvent(
                      productName: _productNameController.text.trim(),
                      description: _descriptionController.text.trim(),
                      price: _priceController.text.trim().isEmpty ? 0 : double.parse(_priceController.text.trim()),
                      category: _categoryController.text.trim(),
                      stock:_stockController.text.trim().isEmpty ? 0 : int.parse(_stockController.text.trim()),
                      color: _colorController.text.trim(),
                      size: _sizeController.text.trim(),
                      material: _materialController.text.trim(),
                      imagePaths: imagePaths, // You need to handle image paths here
                    ));
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
    // Your UI implementation when product is added
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
}
