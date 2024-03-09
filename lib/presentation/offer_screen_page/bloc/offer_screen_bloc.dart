// offer_screen_bloc.dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:aniket_s_application1/core/constants/pinata_secres.dart';
import 'package:aniket_s_application1/presentation/offer_screen_page/models/product_model.dart';
import 'package:aniket_s_application1/services/blockchain_fun.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '/core/app_export.dart';

part 'offer_screen_event.dart';
part 'offer_screen_state.dart';

class OfferScreenBloc extends Bloc<OfferScreenEvent, OfferScreenState> {
  OfferScreenBloc() : super(InitialState()) {
    on<PickImagesEvent>(_pickImages);
    on<AddProductEvent>(_onAddProduct);
  }

  // void _onPickImages(
  //     PickImagesEvent event, Emitter<OfferScreenState> emit) async {
  //   final picker = ImagePicker();
  //   final pickedImages = await picker.pickMultiImage();
  //   if (pickedImages != null) {
  //     emit(ImagesSelectedState(
  //         pickedImages.map((image) => image.path).toList()));
  //   }
  // }
  void _pickImages(
      PickImagesEvent event, Emitter<OfferScreenState> emit) async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    if (pickedImages != null) {
      final imageDataList = await Future.wait(
        pickedImages.map((pickedImage) => pickedImage.readAsBytes()),
      );
      emit(ImagesSelectedState(imageDataList));
    }
  }

  Future<void> _onAddProduct(
      AddProductEvent event, Emitter<OfferScreenState> emit) async {
    emit(LoadingState(loadingMessage: "adding Product..."));

    final List<String?> pinnedHashes = [];

    // Pin all the images
    // for (final imagePath in event.product.imagePaths) {
    //   final ipfsHash = await _pinFileToIPFS(imagePath, JWT);
    //   pinnedHashes.add(ipfsHash);
    //   print('img : $ipfsHash');
    // }
    int i = 1;
    for (final imageData in event.imageDataList) {
      emit(LoadingState(loadingMessage: "Uploading image$i to IPFS..."));
      final ipfsHash = await _pinImageToIPFS(imageData, JWT);
      pinnedHashes.add(ipfsHash);
      print('img : $ipfsHash');
    }

    // Check if all images were pinned successfully
    if (pinnedHashes.any((hash) => hash == null)) {
      emit(ErrorState("Failed to pin all images to IPFS"));
      return;
    }
    event.product.setImagePaths(pinnedHashes.where((element) => element != null).map((e) => e!).toList());

    // Create a JSON representation of the product details
    final productJson = json.encode(event.product.toMap());

    // Pin the JSON string to IPFS
    emit(LoadingState(loadingMessage: "Uploading product Discription to IPFS..."));
    final jsonHash = await _pinJsonToIPFS(productJson, JWT);
    print('jsonfile : $jsonHash');
    if (jsonHash == null) {
      emit(ErrorState("Failed to pin product details to IPFS"));
      return;
    }
    print('addProduct begain...');
    emit(LoadingState(loadingMessage: "Launching Wallet to  Sign Transaction..."));
    var txHash = await addProduct(
      event.product.productName,
      event.product.category,
      pinnedHashes.join(
          ','), // Assuming you want to use the first image as the main image link
      jsonHash,
      BigInt.from(event.product.price.toInt()),
    );
    print('addToContract result: $txHash');
    // If both images and product details are pinned successfully, emit ProductAddedState
    emit(ProductAddedState());
  }

  Future<String?> _pinJsonToIPFS(String jsonString, String jwt) async {
    var uri = Uri.parse('https://api.pinata.cloud/pinning/pinJSONToIPFS');
    var request = http.Request('POST', uri)
      ..headers.addAll({
        'Authorization': 'Bearer $jwt',
        'Content-Type': 'application/json',
      })
      ..body = jsonString;

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      var ipfsHash = jsonResponse['IpfsHash'];
      return ipfsHash;
    } else {
      return null;
    }
  }

  Future<String?> _pinImageToIPFS(Uint8List imageData, String jwt) async {
    var uri = Uri.parse('https://api.pinata.cloud/pinning/pinFileToIPFS');
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll({
        'Authorization': 'Bearer $jwt',
      })
      ..files.add(http.MultipartFile.fromBytes('file', imageData,
          filename: 'image.jpg'));

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      var ipfsHash = jsonResponse['IpfsHash'];
      return ipfsHash;
    } else {
      return null;
    }
  }

  bool _checkRequiredFields(AddProductEvent event) {
    return event.product.productName.isNotEmpty &&
        event.product.description.isNotEmpty &&
        event.product.category.isNotEmpty &&
        event.product.colors.isNotEmpty &&
        event.product.sizes.isNotEmpty &&
        event.product.material.isNotEmpty &&
        event.product.imagePaths.isNotEmpty;
  }
}
