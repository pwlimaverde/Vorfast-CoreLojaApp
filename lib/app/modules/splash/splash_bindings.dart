import 'package:get/get.dart';

//Importes Internos
import 'splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() {
      return SplashController();
    });
  }
}
