import 'package:carregar_temas_package/carregar_temas_package.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
//Importes Internos
import 'app/settings/datasources/carregar_temas_package/datasource/model/firebase_resultado_theme_model.dart';
import 'app/settings/settings_presenter/configuracao_geral_bindings.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  _carregarTemaStorage();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  _runApp();
}

void _runApp() {
  return runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.HOME,
      initialBinding: ConfiguracaoGeralBinding(),
      theme: dadosTheme,
      getPages: AppPages.pages,
    ),
  );
}

void _carregarTemaStorage() {
  final box = GetStorage();
  final model = FirebaseResultadoThemeModel.fromJson(box.read("tema"));

  if (model != null && model.user.length > 0) {
    Get.changeTheme(
      ThemeData(
        primaryColor: Color.fromRGBO(
          model.primary["r"],
          model.primary["g"],
          model.primary["b"],
          1.0,
        ),
        accentColor: Color.fromRGBO(
          model.accent["r"],
          model.accent["g"],
          model.accent["b"],
          1.0,
        ),
      ),
    );
  }
}
