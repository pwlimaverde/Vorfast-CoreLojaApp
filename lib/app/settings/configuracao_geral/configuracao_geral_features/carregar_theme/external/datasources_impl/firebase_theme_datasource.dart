import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../../../../../../shared/utilitario/erros.dart';
import '../../infra/datasources/carregar_theme_datasource.dart';
import '../model/firebase_resultado_theme_model.dart';

class FairebaseThemeDatasource implements CarregarThemeDatasource {
  final FirebaseFirestore firestore;
  FairebaseThemeDatasource({@required this.firestore});
  @override
  Future<RetornoSucessoOuErro<Stream<FirebaseResultadoThemeModel>>>
      getTheme() async {
    try {
      Stream<FirebaseResultadoThemeModel> themeData = firestore
          .collection("settingstheme")
          .doc("theme")
          .snapshots()
          .map((event) {
        return FirebaseResultadoThemeModel.fromDocument(event);
      });
      return SucessoRetorno(resultado: themeData);
    } catch (e) {
      return ErroRetorno(
        erro: ErroInesperado(
          mensagem: "${e.toString()} Erro ao carregar os dados Cod.03-1",
        ),
      );
    }
  }
}
