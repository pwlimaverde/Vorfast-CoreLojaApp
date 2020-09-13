import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/firebase_resultado_empresa_model.dart';
import '../../infra/datasources/carregar_empresa_datasource.dart';

class FirebaseEmpresaDatasourse implements CarregarEmpresaDatasource {
  final Firestore firestore;

  FirebaseEmpresaDatasourse({
    @required this.firestore,
  });

  @override
  Stream<FirebaseResultadoEmpresaModel> carregarEmpresa() {
    try {
      return firestore
          .collection("empresa")
          .document("dados")
          .snapshots()
          .map((doc) {
        return FirebaseResultadoEmpresaModel.fromDocument(
          doc: doc,
        );
      });
    } catch (e) {
      throw e;
    }
  }
}
