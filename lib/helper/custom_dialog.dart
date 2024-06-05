import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  static void info(String msg) {
    Get.snackbar('Info', msg,
        backgroundColor: Colors.blue.withOpacity(.7), colorText: Colors.white);
  }

  static void success(String msg) {
    Get.snackbar('Info', msg,
        backgroundColor: Colors.green.withOpacity(.7), colorText: Colors.white);
  }

  static void error(String msg) {
    Get.snackbar('Info', msg,
        backgroundColor: Colors.red.withOpacity(.7), colorText: Colors.white);
  }
}
