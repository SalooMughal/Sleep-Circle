import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static void show(String title, String body) {
    Get.snackbar(
      title,
      body,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red[800],
      colorText: Colors.white,
      borderRadius: 10.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      borderWidth: 1.0,
      borderColor: Colors.grey[700],
      barBlur: 20.0,
      isDismissible: true,

    );
  }
}
