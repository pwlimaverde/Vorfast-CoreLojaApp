import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../infra/datasources/carregar_secao_datasource.dart';
import '../model/firebase_resultado_anuncio_model.dart';
import '../model/firebase_resultado_secao_model.dart';

class FirebaseSecaoDatasourse implements CarregarSecaoDatasource {
  final FirebaseFirestore firestore;

  FirebaseSecaoDatasourse({required this.firestore});

  @override
  Stream<List<FirebaseResultadoSecaoModel>> getSecao() {
    return firestore
        .collection("secao")
        .orderBy("prioridade")
        .snapshots()
        .map((query) {
      return query.docs.map((doc) {
        return FirebaseResultadoSecaoModel.fromDocument(
            doc, _getAnuncios(doc.reference));
      }).toList();
    });
  }

  Stream<List<FirebaseResultadoAnuncioModel>> _getAnuncios(
      DocumentReference doc) {
    return doc
        .collection("anuncios")
        .orderBy("prioridade")
        .snapshots()
        .map((query) {
      return query.docs.map((doc) {
        return FirebaseResultadoAnuncioModel.fromDocument(doc);
      }).toList();
    });
  }
}
