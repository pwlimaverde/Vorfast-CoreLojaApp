import 'package:get/get.dart';
//Importes Internos
import '../settings/settings_presenter/configuracao_geral_controller.dart';
import '../modules/home/ui/home_page.dart';
import '../modules/home/home_bindings.dart';
import '../modules/splash/splash_bindings.dart';
import '../modules/splash/ui/splash_page.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/ui/login_page.dart';
import '../modules/login/module/novo_user/novo_user_binding.dart';
import '../modules/login/module/novo_user/ui/novo_user_page.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      transition: Transition.fadeIn,
      page: () {
        return GetX<ConfiguracaoGeralController>(
          builder: (_) {
            ConfiguracaoGeralController controller =
                Get.find<ConfiguracaoGeralController>();
            if (controller.loadCompletoDoTema &&
                controller.empresaFirebaseValue.licenca &&
                controller.estaConectado) {
              return HomePage();
            } else {
              return SplashPage();
            }
          },
        );
      },
      bindings: [
        HomeBinding(),
        SplashBinding(),
      ],
    ),
    GetPage(
      name: Routes.LOGIN,
      transition: Transition.fadeIn,
      page: () {
        return GetX<ConfiguracaoGeralController>(
          builder: (_) {
            if (Get.find<ConfiguracaoGeralController>().loadCompletoDoTema &&
                Get.find<ConfiguracaoGeralController>().estaConectado) {
              return LoginPage();
            } else {
              return SplashPage();
            }
          },
        );
      },
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.NOVO_USER,
      transition: Transition.fadeIn,
      page: () {
        return GetX<ConfiguracaoGeralController>(
          builder: (_) {
            if (Get.find<ConfiguracaoGeralController>().loadCompletoDoTema &&
                Get.find<ConfiguracaoGeralController>().estaConectado) {
              return NovoUserPage();
            } else {
              return SplashPage();
            }
          },
        );
      },
      binding: NovoUserBinding(),
    ),
  ];
}
