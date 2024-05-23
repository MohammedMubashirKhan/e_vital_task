import 'package:e_vital_task/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  String splashViewWelcome = 'Welcome to eVital';

  // Function to check machine code existence and navigate accordingly
  Future<void> navigateToNextView() async {
    await Future.delayed(const Duration(seconds: 3));
    // Navigate to HomeView if machine code exists
    Get.offAllNamed(Routes.HOME);
  }

  @override
  void onInit() {
    super.onInit();
    navigateToNextView();
  }
}
