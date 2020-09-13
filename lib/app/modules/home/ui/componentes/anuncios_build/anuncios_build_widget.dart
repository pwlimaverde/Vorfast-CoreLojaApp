import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../shared/widgets/widgets_core.dart' as widgetCore;
import '../../../data/model/secao_model.dart';

class AnunciosBuildWidget extends StatelessWidget {
  final SecaoModel secao;

  const AnunciosBuildWidget({Key key, this.secao}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (secao.anunciosValue.length > 0) {
        return widgetCore.SlvGridPromoModelWidget(
          listModel: secao.anunciosValue,
        );
      } else {
        return widgetCore.SlvProgressWidget();
      }
    });
  }
}
