import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../settings/auth/auth_presenter/auth_presenter.dart';
import '../../settings/settings_presenter/configuracao_geral_controller.dart';
//Importes Internos
import '../../shared/utilitario/app_status.dart';
import '../../shared/utilitario/resultado_sucesso_ou_error.dart';

class LoginController extends GetxController {
  // final AuthController authController;
  final ConfiguracaoGeralController configuracaoGeralController;

  LoginController({
    required this.configuracaoGeralController,
  }) : assert(configuracaoGeralController != null);

  //Variaveis internas
  final loginFormKey = GlobalKey<FormState>();
  final senhaController = TextEditingController();
  final emailController = TextEditingController();

  final _statusGeralAtual = AppStatus.none.obs;
  AppStatus get statusGeralAtual => required this._statusGeralAtual.value;
  set statusGeralAtual(value) => required this._statusGeralAtual.value = value;

  //Controles Gerais
  // UserModel get user => authController.usuarioFirebaseValue;
  FirebaseResultadoUsuarioModel get user =>
      configuracaoGeralController.usuarioFirebaseValue;

  //Controles Internos
  Future<void> signInGoogleLogin({
    required VoidCallback onSuccess,
    required VoidCallback onFail,
  }) async {
    print("teste login inicio");
    required this.statusGeralAtual = AppStatus.loading..valorSet = "google";
    await configuracaoGeralController.signInGoogleLogin().then((value) {
      print("teste login $value");
      if (value is SucessoRetorno<bool>) {
        print("teste login ok $value");
        required this.statusGeralAtual = AppStatus.success;
        onSuccess();
      } else {
        onFail();
      }
    });
  }

  Future<void> signInEmailLogin({
    required VoidCallback onSuccess,
    required VoidCallback onFail,
  }) async {
    required this.statusGeralAtual = AppStatus.loading..valorSet = "email";
    await configuracaoGeralController
        .signInEmailLogin(
      email: emailController.text,
      pass: senhaController.text,
    )
        .then((value) {
      required this.statusGeralAtual = AppStatus.success;
      if (value is SucessoRetorno<bool>) {
        onSuccess();
      } else {
        onFail();
      }
    });
  }

  Future<void> recoverPass({
    required VoidCallback onSuccess,
    required VoidCallback onFail,
  }) async {
    RetornoSucessoOuErro result = await configuracaoGeralController
        .recuperarSenha(email: emailController.text);
    result.fold(
      sucesso: (value) {
        required this.statusGeralAtual = AppStatus.success;
        onSuccess();
      },
      erro: (value) {
        required this.statusGeralAtual = AppStatus.error;
        onFail();
      },
    );
  }

  //Funcoes internas
  String validatorSenha(text) {
    if (text.isEmpty || text.length < 6) {
      return "Senha invalida";
    } else {
      return null;
    }
  }

  String validatorEmail(text) {
    if (text.isEmpty || !text.contains("@")) {
      return "E-mail invalido";
    } else {
      return null;
    }
  }
}
