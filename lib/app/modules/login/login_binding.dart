import 'package:corelojaapp/app/settings/settings_presenter/configuracao_geral_controller.dart';
import 'package:get/get.dart';
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
