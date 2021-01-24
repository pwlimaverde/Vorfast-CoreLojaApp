import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../shared/utilitario/app_status.dart';
import '../../../../../shared/widgets/widgets_core.dart' as widgetCore;
//Importes Internos
import '../novo_user_controller.dart';

class NovoUserPage extends GetView<NovoUserController> {
  @override
  Widget build(BuildContext context) {
    return widgetCore.BodyCoreWidget(
      drawer:
          controller.configuracaoGeralController.getDrawerCoreWidget(page: 0),
      slv: <Widget>[
        widgetCore.SlvAppbarWidget(
          backgroundColor: Colors.transparent,
          // editButton: observerEditButton(),
          title: "Criar Usuario",
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
      key: controller.novoUserFormKey,
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          widgetCore.FieldCoreWidget(
            controller: controller.nomeController,
            label: "Nome Completo",
            hint: "Digite o Nome",
            validator: controller.validatorNome,
          ),
          SizedBox(
            height: 16.0,
          ),
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
            height: 16.0,
          ),
          widgetCore.FieldCoreWidget(
            controller: controller.repetirSenhaController,
            label: "Repetir Senha",
            hint: "Repita a Senha",
            keyBoard: TextInputType.emailAddress,
            validator: controller.validatorRepetirSenha,
            obscureText: true,
          ),
          SizedBox(
            height: 16.0,
          ),
          Obx(() {
            if (controller.statusGeralAtual == AppStatus.loading) {
              return widgetCore.RaisedbuttonCoreWidget(
                loading: true,
                icon: Icon(FontAwesomeIcons.user),
                label: "Criar Conta",
                colorButton: Colors.blueGrey,
                onPressed: () {},
              );
            } else {
              return widgetCore.RaisedbuttonCoreWidget(
                icon: Icon(FontAwesomeIcons.user),
                label: "Criar Conta",
                colorButton: Colors.blueGrey,
                onPressed: () {
                  if (controller.novoUserFormKey.currentState.validate()) {
                    controller.setUserEmail(
                      onSuccess: () {
                        Get.snackbar(
                          "Bem vindo ${controller.statusGeralAtual.valorGet}",
                          'Conta criada com sucesso',
                          icon: Icon(FontAwesomeIcons.check),
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        Future.delayed(Duration(seconds: 1)).then((_) {
                          Get.offAllNamed(Routes.HOME);
                        });
                      },
                      onFail: () {
                        Get.snackbar(
                          'Olá',
                          'Não foi possível criar o usuario',
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
          widgetCore.RaisedbuttonCoreWidget(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            label: "Voltar",
            colorButton: Colors.red,
            onPressed: () {
              Get.back();
            },
          ),
          SizedBox(
            height: 8.0,
          ),
          Obx(
            () {
              if (controller.statusGeralAtual == AppStatus.error) {
                return Center(
                  child: Text(
                    "Não foi possível criar o usuario => ${controller.statusGeralAtual.valorGet}",
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
