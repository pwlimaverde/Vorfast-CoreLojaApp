import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import 'model/firebase_resultado_theme_model.dart';

class FairebaseThemeDatasource2
    implements Datasource<Stream<FirebaseResultadoThemeModel>, NoParams> {
  final FirebaseFirestore firestore;
  FairebaseThemeDatasource2({@required this.firestore});
  @override
  Future<Stream<FirebaseResultadoThemeModel>> call(
      {NoParams parametros}) async {
    try {
      Stream<FirebaseResultadoThemeModel> themeData = firestore
          .collection("settingstheme")
          .doc("theme")
          .snapshots()
          .map((event) {
        return FirebaseResultadoThemeModel.fromDocument(event);
      });
      return themeData;
    } catch (e) {
      throw Exception(e);
    }
  }
}
