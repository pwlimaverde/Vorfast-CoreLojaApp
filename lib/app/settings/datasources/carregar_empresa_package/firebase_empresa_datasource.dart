import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import 'model/firebase_resultado_empresa_model.dart';

class FirebaseEmpresaDatasource
    implements Datasource<Stream<FirebaseResultadoEmpresaModel>, NoParams> {
  final FirebaseFirestore firestore;
  FirebaseEmpresaDatasource({@required this.firestore});
  @override
  Future<Stream<FirebaseResultadoEmpresaModel>> call(
      {NoParams parametros}) async {
    try {
      final DocumentReference doc =
          firestore.collection("empresa").doc("dados");
      DocumentSnapshot docReference = await doc.get();
      FirebaseResultadoEmpresaModel empresa =
          FirebaseResultadoEmpresaModel.fromDocument(doc: docReference);
      if (empresa.licenca) {
        Stream<FirebaseResultadoEmpresaModel> empresaData =
            doc.snapshots().map((event) {
          return FirebaseResultadoEmpresaModel.fromDocument(doc: event);
        });
        return empresaData;
      } else {
        throw ErrorCarregarEmpresa(
            mensagem:
                "Falha ao carregar os dados: Empresa Inválida - Cod.03-1");
      }
    } catch (e) {
      throw ErrorCarregarEmpresa(
          mensagem: "Falha ao carregar os dados: $e - Cod.03-2");
    }
  }
}
