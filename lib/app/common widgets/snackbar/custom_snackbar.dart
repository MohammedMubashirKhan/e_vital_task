import 'package:e_vital_task/app/common%20widgets/snackbar/custome_snackbar_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

customeSnackbar(
    {SnackbarType type = SnackbarType.success,
    String title = "Success",
    String message = "NA"}) {
  String title;
  String message;
  Color backgroundColor;

  switch (type) {
    case SnackbarType.success:
      title = 'Success';
      message = 'Logged in successfully';
      backgroundColor = Colors.green;
      break;
    case SnackbarType.error:
      title = 'Error';
      message = 'Please enter your email and password';
      backgroundColor = Colors.red;
      break;
  }
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: backgroundColor,
    colorText: Colors.white,
  );
}
