import 'package:corelojaapp/app/settings/auth/auth_features/signin/domain/status/signin_usecase_status.dart';
import 'package:corelojaapp/app/settings/auth/auth_presenter/auth_presenter.dart';
import 'package:corelojaapp/app/settings/settings_presenter/configuracao_geral_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
//Importes Internos
import '../../shared/utilitario/app_status.dart';

class LoginController extends GetxController {
  // final AuthController authController;
  final ConfiguracaoGeralController configuracaoGeralController;

  LoginController({
    @required this.configuracaoGeralController,
  }) : assert(configuracaoGeralController != null);

  //Variaveis internas
  final loginFormKey = GlobalKey<FormState>();
  final senhaController = TextEditingController();
  final emailController = TextEditingController();

  final _statusGeralAtual = AppStatus.none.obs;
  AppStatus get statusGeralAtual => this._statusGeralAtual.value;
  set statusGeralAtual(value) => this._statusGeralAtual.value = value;

  //Controles Gerais
  // UserModel get user => authController.usuarioFirebaseValue;
  FirebaseResultadoUsuarioModel get user =>
      configuracaoGeralController.usuarioFirebaseValue;

  //Controles Internos
  Future<void> signInGoogleLogin({
    @required VoidCallback onSuccess,
    @required VoidCallback onFail,
  }) async {
    print("teste login inicio");
    this.statusGeralAtual = AppStatus.loading..valorSet = "google";
    await configuracaoGeralController.signInGoogleLogin().then((value) {
      print("teste login $value");
      if (value == SignInStatus.success) {
        print("teste login ok $value");
        this.statusGeralAtual = AppStatus.success;
        onSuccess();
      } else {
        onFail();
      }
    });
  }

  Future<void> signInEmailLogin({
    @required VoidCallback onSuccess,
    @required VoidCallback onFail,
  }) async {
    this.statusGeralAtual = AppStatus.loading..valorSet = "email";
    await configuracaoGeralController
        .signInEmailLogin(
      email: emailController.text,
      pass: senhaController.text,
    )
        .then((value) {
      this.statusGeralAtual = AppStatus.success;
      if (value == SignInStatus.success) {
        onSuccess();
      } else {
        onFail();
      }
    });
  }

  Future<void> recoverPass({
    @required VoidCallback onSuccess,
    @required VoidCallback onFail,
  }) async {
    await configuracaoGeralController
        .recuperarSenha(email: emailController.text)
        .then((valor) {
      if (valor == RecuperarSenhaEmailStatus.success) {
        this.statusGeralAtual = AppStatus.success;
        onSuccess();
      } else {
        this.statusGeralAtual = AppStatus.error;
        onFail();
      }
    });
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
