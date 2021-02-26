import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../../../shared/utilitario/erros.dart';
import 'model/firebase_resultado_anuncio_model.dart';
import 'model/firebase_resultado_secao_model.dart';

class FirebaseSecaoDatasourse
    implements Datasource<Stream<List<FirebaseResultadoSecaoModel>>, NoParams> {
  final FirebaseFirestore firestore;

  FirebaseSecaoDatasourse({@required this.firestore});

  @override
  Future<Stream<List<FirebaseResultadoSecaoModel>>> call(
      {NoParams parametros}) async {
    try {
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
    } catch (e) {
      throw ErroCarregarSecoes(
          mensagem: "Falha ao carregar os dados das seções - Cod.03-1");
    }
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
