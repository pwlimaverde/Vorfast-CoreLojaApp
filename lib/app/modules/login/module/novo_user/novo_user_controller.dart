import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../settings/auth/auth_presenter/auth_presenter.dart';
import '../../../../settings/settings_presenter/configuracao_geral_controller.dart';
//Importes Internos
import '../../../../shared/utilitario/app_status.dart';
import '../../../../shared/utilitario/resultado_sucesso_ou_error.dart';

class NovoUserController extends GetxController {
  final ConfiguracaoGeralController configuracaoGeralController;

  NovoUserController({
    required this.configuracaoGeralController,
  }) : assert(configuracaoGeralController != null);

  //Controles Gerais
  FirebaseResultadoUsuarioModel get user =>
      configuracaoGeralController.usuarioFirebaseValue;

  //Variaveis internas
  final novoUserFormKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final repetirSenhaController = TextEditingController();
  final enderecoController = TextEditingController();

  final _statusGeralAtual = AppStatus.none.obs;
  AppStatus get statusGeralAtual => required this._statusGeralAtual.value;
  set statusGeralAtual(value) => required this._statusGeralAtual.value = value;

  //Controles Internos
  Future<void> setUserEmail(
      {required VoidCallback onSuccess, required VoidCallback onFail}) async {
    required this.statusGeralAtual = AppStatus.loading;
    FirebaseResultadoUsuarioModel user = FirebaseResultadoUsuarioModel();
    user.nome = nomeController.text;
    user.email = emailController.text;
    await configuracaoGeralController
        .novoEmailLogin(user: user, pass: senhaController.text)
        .then((value) {
      required this.statusGeralAtual = AppStatus.success;
      if (value is SucessoRetorno<bool>) {
        onSuccess();
      } else {
        onFail();
      }
    });
  }

  //Funcoes internas
  String validatorNome(text) {
    if (text.isEmpty) {
      return "Nome invalido";
    } else {
      return null;
    }
  }

  String validatorSenha(text) {
    if (text.isEmpty || text.length < 6) {
      return "Senha invalida";
    } else {
      return null;
    }
  }

  String validatorRepetirSenha(text) {
    if (text.isEmpty || senhaController.text != repetirSenhaController.text) {
      return "Repita a senha";
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
