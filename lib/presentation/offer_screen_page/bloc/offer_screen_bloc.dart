// offer_screen_bloc.dart

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '/core/app_export.dart';

part 'offer_screen_event.dart';
part 'offer_screen_state.dart';

class OfferScreenBloc extends Bloc<OfferScreenEvent, OfferScreenState> {
  OfferScreenBloc() : super(InitialState()) {
    on<PickImagesEvent>(_onPickImages);
    on<AddProductEvent>(_onAddProduct);
  }

  void _onPickImages(
      PickImagesEvent event, Emitter<OfferScreenState> emit) async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    if (pickedImages != null) {
      emit(ImagesSelectedState(
          pickedImages.map((image) => image.path).toList()));
    }
  }

  Future<void> _onAddProduct(AddProductEvent event, Emitter<OfferScreenState> emit) async {
    print(event.toString());
    if (_checkRequiredFields(event) ) {
      File imageFile = File(event.imagePaths[0]);
      emit(ProductAddedState());
    } else {
      emit(ErrorState("Invalid imput"));
      await Future.delayed(const Duration(seconds: 1), () {
        emit(InitialState());
      });
    }
  }

  // bool _checkAnyFieldEmpty(AddProductEvent event) {
  //   return event.productName.isEmpty ||
  //       event.description.isEmpty ||
  //       event.price.isNaN ||
  //       event.category.isEmpty ||
  //       event.color.isEmpty ||
  //       event.size.isEmpty ||
  //       event.material.isEmpty;
  // }

  bool _checkRequiredFields(AddProductEvent event) {
    return event.productName.isNotEmpty &&
        event.description.isNotEmpty &&
        // event.price > 0 &&
        event.category.isNotEmpty &&
        // event.stock > 0 &&
        event.color.isNotEmpty &&
        event.size.isNotEmpty &&
        event.material.isNotEmpty &&
        event.imagePaths.isNotEmpty;
  }

  uploadToPinata(File file, String title){
    FormData formData = FormData.fromMap({
      'file': MultipartFile.fromFileSync( file.path, filename:title),
    });

    // final pin;
    // pinata = Pinata.test;
    // print(await pinata.pinFile(File('FILE PATH')));
    // print(pin = await pinata.pins);
    // print(await pin.update(name: 'New Pin')); 
  }
}
