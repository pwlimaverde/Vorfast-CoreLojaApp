import 'package:corelojaapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//Importes internos
import '../../configuracao_geral_controller.dart';
import 'components/drawer_back/drawer_back_widget.dart';
import 'components/drawer_header/drawer_header_widget.dart';
import 'components/drawer_tile/drawer_tile_widget.dart';
import 'components/listMenu/listMenu_widget.dart';

class DrawerCoreWidget extends GetView<ConfiguracaoGeralController> {
  //header pramms
  final int page;

  DrawerCoreWidget({
    @required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          DrawerBackWidget(),
          ListMenuWidget(
            header: Obx(() {
              if (controller.usuarioFirebaseValue.currentUser != null) {
                return DrawerHeaderWidget(
                  isLogin: true,
                  isShowNome: controller.mostrarNomeEmpresa,
                  page: page,
                  empresa: controller.empresaFirebaseValue,
                  singOut: controller.singOut,
                  user: controller.usuarioFirebaseValue.nick,
                );
              } else {
                return DrawerHeaderWidget(
                  isLogin: false,
                  isShowNome: controller.mostrarNomeEmpresa,
                  page: page,
                  empresa: controller.empresaFirebaseValue,
                  singOut: controller.singOut,
                  user: controller.usuarioFirebaseValue.nick,
                );
              }
            }),
            body: Column(
              children: <Widget>[
                DrawerTileWidget(
                  indice: 1,
                  page: page,
                  nav: Routes.HOME,
                  icon: Icons.home,
                  tile: "Inicio",
                ),
                DrawerTileWidget(
                  indice: 2,
                  page: page,
                  icon: Icons.list,
                  tile: "Categorias",
                ),
                DrawerTileWidget(
                  indice: 3,
                  page: page,
                  icon: Icons.playlist_add_check,
                  tile: "Meus Pedidos",
                ),
                DrawerTileWidget(
                  indice: 4,
                  page: page,
                  icon: Icons.location_on,
                  tile: "Lojas",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
