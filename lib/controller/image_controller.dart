import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ai_assistant/helper/custom_dialog.dart';

import '../apis/apis.dart';

enum Status { none, loading, complete }

class ImageController extends GetxController {
  final textC = TextEditingController();
  final status = Status.none.obs;
  final generatedText = ''.obs;
  RxList<XFile> images = <XFile>[].obs;

  Future<void> pickImages() async {
    List<XFile>? pickedImages = await ImagePicker().pickMultiImage();
    images.addAll(pickedImages);
  }

  Future<String?> getImageBase64(XFile? image) async {
    if (image == null) return null;

    try {
      List<int> imageBytes = File(image.path).readAsBytesSync();
      String base64File = base64.encode(imageBytes);
      return base64File;
    } catch (e) {
      log('Error reading image bytes: $e');
      return null;
    }
  }

  Future<void> generateText() async {
    if (textC.text.trim().isNotEmpty) {
      status.value = Status.loading;

      try {
        List<String?> base64Images = await Future.wait(
          images.map((image) => getImageBase64(image)),
        );

        base64Images = base64Images.where((image) => image != null).toList();

        generatedText.value = await APIs.getImageTextAnswer(textC.text,
            base64Images: base64Images);

        status.value = Status.complete;
      } catch (e) {
        CustomDialog.info('Error: $e');
        status.value = Status.none;
      }
    } else {
      CustomDialog.info('Provide a prompt before generating');
    }
  }
}
