import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../../../../shared/utilitario/erros.dart';
import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../infra/datasources/carregar_empresa_datasource.dart';
import '../model/firebase_resultado_empresa_model.dart';

class FirebaseEmpresaDatasourse implements CarregarEmpresaDatasource {
  final FirebaseFirestore firestore;

  FirebaseEmpresaDatasourse({
    @required this.firestore,
  });

  @override
  Future<RetornoSucessoOuErro<Stream<FirebaseResultadoEmpresaModel>>>
      carregarEmpresa() async {
    try {
      Stream<FirebaseResultadoEmpresaModel> empresaData =
          firestore.collection("empresa").doc("dados").snapshots().map((doc) {
        return FirebaseResultadoEmpresaModel.fromDocument(doc: doc);
      });
      return SucessoResultado(result: empresaData);
    } catch (e) {
      return ErrorResultado(
        error: ErroInesperado(
          mensagem: "${e.toString()} Erro ao carregar os dados Cod.03-1",
        ),
      );
    }
  }
}
