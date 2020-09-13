import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../infra/datasources/carregar_theme_datasource.dart';
import '../model/firebase_resultado_theme_model.dart';

class FairebaseThemeDatasource implements CarregarThemeDatasource {
  final Firestore firestore;
  FairebaseThemeDatasource({@required this.firestore});
  @override
  Stream<FirebaseResultadoThemeModel> getTheme() {
    try {
      return firestore
          .collection("settingstheme")
          .document("theme")
          .snapshots()
          .map((event) {
        return FirebaseResultadoThemeModel.fromDocument(event);
      });
    } catch (e) {
      throw e;
    }
  }
}
