import 'dart:io';
import 'package:ai_assistant/controller/image_controller.dart';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/widget/custom_btn.dart';
import 'package:ai_assistant/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageFeature extends StatefulWidget {
  const ImageFeature({super.key});

  @override
  State<ImageFeature> createState() => _ImageFeatureState();
}

class _ImageFeatureState extends State<ImageFeature> {
  final ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Image Chat'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: mq.height * .02,
          horizontal: mq.width * .04,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Obx(
              () => imageController.images.isEmpty
                  ? GestureDetector(
                      onTap: imageController.pickImages,
                      child: Container(
                        height: mq.height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey[400]!),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo_library,
                                size: 50,
                                color: Colors.grey[700],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Tap to select images',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: imageController.images.length,
                      itemBuilder: (context, index) {
                        return Image.file(
                          File(imageController.images[index].path),
                          fit: BoxFit.cover,
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: imageController.textC,
              textAlign: TextAlign.center,
              minLines: 2,
              maxLines: null,
              onTapOutside: (e) => FocusScope.of(context).unfocus(),
              decoration: const InputDecoration(
                  hintText:
                      'Provide an image and text, and I\'ll assist you 😃',
                  hintStyle: TextStyle(fontSize: 13.5),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            const SizedBox(height: 20),
            CustomBtn(onTap: imageController.generateText, text: 'Generate'),
            const SizedBox(height: 20),
            Obx(
              () => Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _aiGeneratedText(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _aiGeneratedText() {
    switch (imageController.status.value) {
      case Status.none:
        return const SizedBox();
      case Status.complete:
        return SingleChildScrollView(
          // Ensure text scrolls if too long
          child: Text(
            imageController.generatedText.value,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        );
      case Status.loading:
        return const CustomLoading();
      default:
        return const SizedBox(); // Handle any unexpected cases
    }
  }
}
