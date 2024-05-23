import 'package:e_vital_task/app/common%20widgets/snackbar/snackbar.dart';
import 'package:e_vital_task/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  static const String validMobile = '9033006262';
  static const String validPassword = 'eVital@12';

  Future<void> login() async {
    final mobile = mobileController.text.trim();
    final password = passwordController.text.trim();

    if (mobile.isEmpty || password.isEmpty) {
      customeSnackbar(
        type: SnackbarType.error,
        title: 'Error',
        message: 'Please enter your mobile number and password',
      );
      return;
    }

    // Add your authentication logic here
    if (mobile == validMobile && password == validPassword) {
      customeSnackbar(
        type: SnackbarType.success,
        title: 'Success',
        message: 'Logged in successfully',
      );
      Get.toNamed(Routes.HOME);
    } else {
      customeSnackbar(
        type: SnackbarType.error,
        title: 'Error',
        message: 'Invalid mobile number or password',
      );
    }
  }
}
