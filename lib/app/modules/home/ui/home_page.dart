import 'package:flutter/material.dart';
import 'package:get/get.dart';
//Importes Internos
import '../home_controller.dart';
import '../../../shared/widgets/widgets_core.dart' as widgetCore;

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widgetCore.BodyCoreWidget(
        slv: controller.todasSecoes.length > 0
            ? !controller.isEditeMode || !controller.user.administrador
                ? controller.listSlv
                : controller.listSlvEdit
            : [
                widgetCore.SlvAppbarWidget(
                  backgroundColor: Colors.transparent,
                  title: "VorFast",
                  isAdmin: controller.user.administrador,
                ),
                widgetCore.SlvAdapterWidget(
                  adapter: SizedBox(
                    height: 20,
                  ),
                ),
                widgetCore.SlvProgressWidget(),
              ],
        drawer:
            controller.configuracaoGeralController.getDrawerCoreWidget(page: 1),
      );
    });
  }
}

// widgetCore.SlvAppbarWidget(
//             backgroundColor: Colors.transparent,
//             // editButton: observerEditButton(),
//             title: "VorFast",
//             // isAdmin: controller.isAdmin,
//           ),
//           widgetCore.SlvAdapterWidget(
//             adapter: SizedBox(
//               height: 20,
//             ),
//           ),
