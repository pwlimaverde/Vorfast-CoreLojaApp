import 'package:corelojaapp/app/settings/settings_presenter/configuracao_geral_controller.dart';
import 'package:get/get.dart';
//Importes Internos
import 'novo_user_controller.dart';

class NovoUserBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NovoUserController>(() {
      return NovoUserController(
        configuracaoGeralController: Get.find<ConfiguracaoGeralController>(),
      );
    });
  }
}
