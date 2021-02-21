import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../../../../shared/utilitario/erros.dart';
import 'model/firebase_resultado_theme_model.dart';

class FairebaseTemaDatasource
    implements Datasource<Stream<FirebaseResultadoThemeModel>, NoParams> {
  final FirebaseFirestore firestore;
  FairebaseTemaDatasource({@required this.firestore});
  @override
  Future<Stream<FirebaseResultadoThemeModel>> call(
      {NoParams parametros}) async {
    try {
      final DocumentReference doc =
          firestore.collection("settingstheme").doc("theme");
      DocumentSnapshot docReference = await doc.get();
      FirebaseResultadoThemeModel tema =
          FirebaseResultadoThemeModel.fromDocument(doc: docReference);
      if (tema.user.length > 0) {
        Stream<FirebaseResultadoThemeModel> themeData =
            doc.snapshots().map((event) {
          return FirebaseResultadoThemeModel.fromDocument(doc: event);
        });
        return themeData;
      } else {
        throw ErroCarregarTema(
            mensagem:
                "Falha ao carregar os dados: Tema não carregado - Cod.03-1");
      }
    } catch (e) {
      throw ErroCarregarTema(
          mensagem: "Falha ao carregar os dados: $e - Cod.03-2");
    }
  }
}
