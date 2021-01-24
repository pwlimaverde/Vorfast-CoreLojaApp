import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
//Importes Internos
import 'app/settings/settings_presenter/configuracao_geral_bindings.dart';
import 'app/routes/app_pages.dart';
import 'app/settings/configuracao_geral/configuracao_geral_features/carregar_theme/domain/entities/dados_theme.dart';

void main() async {
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
