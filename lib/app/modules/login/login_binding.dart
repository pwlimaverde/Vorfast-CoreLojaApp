import 'package:get/get.dart';

import '../../settings/settings_presenter/configuracao_geral_controller.dart';
//Importes Internos
import 'login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() {
      return LoginController(
        configuracaoGeralController: Get.find<ConfiguracaoGeralController>(),
      );
    });
  }
}
