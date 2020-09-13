import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
//Importes Internos

class LocalStorageBinding implements Bindings {
  @override
  void dependencies() {
    Get.putAsync<SharedPreferences>(() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs;
    });
  }
}
