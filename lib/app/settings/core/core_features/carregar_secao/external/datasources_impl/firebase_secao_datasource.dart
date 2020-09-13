import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/firebase_resultado_anuncio_model.dart';
import '../model/firebase_resultado_secao_model.dart';
import '../../infra/datasources/carregar_secao_datasource.dart';

class FirebaseSecaoDatasourse implements CarregarSecaoDatasource {
  final Firestore firestore;

  FirebaseSecaoDatasourse({@required this.firestore});

  @override
  Stream<List<FirebaseResultadoSecaoModel>> getSecao() {
    return firestore
        .collection("secao")
        .orderBy("prioridade")
        .snapshots()
        .map((query) {
      return query.documents.map((doc) {
        return FirebaseResultadoSecaoModel.fromDocument(
            doc, _getAnuncios(doc.reference));
      }).toList();
    });
  }

  Stream<List<FirebaseResultadoAnuncioModel>> _getAnuncios(
      DocumentReference doc) {
    return doc.collection("anuncios").snapshots().map((query) {
      return query.documents.map((doc) {
        return FirebaseResultadoAnuncioModel.fromDocument(doc);
      }).toList();
    });
  }
}
