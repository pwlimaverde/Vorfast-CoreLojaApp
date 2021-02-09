import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import 'model/firebase_resultado_theme_model.dart';

class FairebaseThemeDatasource
    implements Datasource<Stream<FirebaseResultadoThemeModel>, NoParams> {
  final FirebaseFirestore firestore;
  FairebaseThemeDatasource({@required this.firestore});
  @override
  Future<Stream<FirebaseResultadoThemeModel>> call(
      {NoParams parametros}) async {
    try {
      final DocumentReference doc =
          firestore.collection("settingstheme").doc("theme");
      DocumentSnapshot docReference = await doc.get();
      FirebaseResultadoThemeModel tema =
          FirebaseResultadoThemeModel.fromDocument(docReference);
      if (tema.user.length > 0) {
        Stream<FirebaseResultadoThemeModel> themeData =
            doc.snapshots().map((event) {
          return FirebaseResultadoThemeModel.fromDocument(event);
        });
        return themeData;
      } else {
        throw Exception("Falha ao carregar os dados: Usuario Inválido");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
