import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/utilitario/app_status.dart';
import '../../../shared/widgets/widgets_core.dart' as widgetCore;
//Importes internos
import '../login_controller.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return widgetCore.BodyCoreWidget(
      drawer:
          controller.configuracaoGeralController.getDrawerCoreWidget(page: 0),
      slv: <Widget>[
        widgetCore.SlvAppbarWidget(
          backgroundColor: Colors.transparent,
          // editButton: observerEditButton(),
          title: "Login",
          isAdmin: controller.user.administrador,
        ),
        widgetCore.SlvAdapterWidget(
          adapter: SizedBox(
            height: 20,
          ),
        ),
        widgetCore.SlvCardWidget(
          body: buildForm(),
        ),
      ],
    );
  }

  Widget buildForm() {
    return Form(
      key: controller.loginFormKey,
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          widgetCore.FieldCoreWidget(
            controller: controller.emailController,
            label: "E-mail",
            hint: "Digite o e-mail",
            keyBoard: TextInputType.emailAddress,
            validator: controller.validatorEmail,
          ),
          SizedBox(
            height: 16.0,
          ),
          widgetCore.FieldCoreWidget(
            controller: controller.senhaController,
            label: "Senha",
            hint: "Digite a Senha",
            keyBoard: TextInputType.emailAddress,
            validator: controller.validatorSenha,
            obscureText: true,
          ),
          SizedBox(
            height: 4.0,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: widgetCore.FlatbuttonCoreWidget(
              title: "Esqueci minha senha",
              onPressed: () {
                if (controller.emailController.text.isEmpty) {
                  Get.snackbar(
                    'Olá',
                    'Insira seu e-mail para recuperação!',
                    icon: Icon(FontAwesomeIcons.meh),
                    snackPosition: SnackPosition.BOTTOM,
                  );
                } else {
                  controller.recoverPass(
                    onSuccess: () {
                      Get.snackbar(
                        'Olá',
                        'Confira seu e-mail para recuperar a senha!',
                        icon: Icon(FontAwesomeIcons.check),
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    onFail: () {
                      Get.snackbar(
                        'Olá',
                        'Falha ao tentar recuperar o e-mail!',
                        icon: Icon(FontAwesomeIcons.check),
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  );
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: widgetCore.FlatbuttonCoreWidget(
              title: "CRIAR CONTA",
              onPressed: () {
                Get.toNamed(Routes.NOVO_USER);
              },
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Obx(() {
            if (controller.statusGeralAtual == AppStatus.loading &&
                controller.statusGeralAtual.valorGet == "email") {
              return widgetCore.RaisedbuttonCoreWidget(
                loading: true,
                icon: Icon(FontAwesomeIcons.user),
                label: "Login com Email",
                colorButton: Colors.blueGrey,
                onPressed: () {},
              );
            } else {
              return widgetCore.RaisedbuttonCoreWidget(
                icon: Icon(FontAwesomeIcons.user),
                label: "Login com Email",
                colorButton: Colors.blueGrey,
                onPressed: () {
                  if (controller.loginFormKey.currentState.validate()) {
                    controller.signInEmailLogin(
                      onSuccess: () {
                        Get.snackbar(
                          "Bem vindo ${controller.statusGeralAtual.valorGet}",
                          'Login efetuado com sucesso',
                          icon: Icon(FontAwesomeIcons.check),
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        Future.delayed(Duration(seconds: 2)).then((_) {
                          Get.offAllNamed(Routes.HOME);
                        });
                      },
                      onFail: () {
                        Get.snackbar(
                          'Olá',
                          'Não foi possível fazer o login',
                          icon: Icon(FontAwesomeIcons.meh),
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                    );
                  }
                },
              );
            }
          }),
          SizedBox(
            height: 8.0,
          ),
          Obx(() {
            if (controller.statusGeralAtual == AppStatus.loading &&
                controller.statusGeralAtual.valorGet == "google") {
              return widgetCore.RaisedbuttonCoreWidget(
                loading: true,
                icon: Icon(FontAwesomeIcons.google),
                label: "Login com Google",
                colorButton: Colors.red,
                onPressed: () {},
              );
            } else {
              return widgetCore.RaisedbuttonCoreWidget(
                icon: Icon(FontAwesomeIcons.google),
                label: "Login com Google",
                colorButton: Colors.red,
                onPressed: () {
                  controller.signInGoogleLogin(
                    onSuccess: () {
                      Get.snackbar(
                        "Bem vindo ${controller.statusGeralAtual.valorGet}",
                        'Login efetuado com sucesso',
                        icon: Icon(FontAwesomeIcons.check),
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      Future.delayed(Duration(seconds: 2)).then((_) {
                        Get.offAllNamed(Routes.HOME);
                      });
                    },
                    onFail: () {
                      Get.snackbar(
                        'Olá',
                        'Não foi possível fazer o login',
                        icon: Icon(FontAwesomeIcons.meh),
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  );
                },
              );
            }
          }),
        ],
      ),
    );
  }
}
