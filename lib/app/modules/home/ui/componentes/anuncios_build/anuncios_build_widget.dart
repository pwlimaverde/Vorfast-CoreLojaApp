import 'package:corelojaapp/app/settings/datasources/carregar_secoes_package/model/firebase_resultado_secao_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../shared/widgets/widgets_core.dart' as widgetCore;

class AnunciosBuildWidget extends StatelessWidget {
  final FirebaseResultadoSecaoModel secao;

  const AnunciosBuildWidget({Key key, this.secao}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (secao.anuncios.length > 0) {
        return widgetCore.SlvGridPromoModelWidget(
          listModel: secao.anuncios,
        );
      } else {
        return widgetCore.SlvProgressWidget();
      }
    });
  }
}
