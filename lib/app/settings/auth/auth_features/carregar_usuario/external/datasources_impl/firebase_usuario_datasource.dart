import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';

import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../infra/datasources/carregar_usuario_datasource.dart';
import '../model/firebase_resultado_usuario_model.dart';

class FirebaseUsuarioDatasourse implements CarregarUsuarioDatasource {
  final FirebaseFirestore firestore;
  final auth.FirebaseAuth authInstance;

  FirebaseUsuarioDatasourse({
    @required this.firestore,
    @required this.authInstance,
  });

  @override
  Future<RetornoSucessoOuErro<Stream<FirebaseResultadoUsuarioModel>>>
      carregarUsuario() async {
    try {
      auth.User _user = await _usuarioLogado().then((value) => value);
      if (_user.uid.length > 0) {
        DocumentReference doc = firestore.collection("user").doc(_user.uid);
        DocumentSnapshot docExiste = await doc.get();
        if (docExiste.exists) {
          Stream<FirebaseResultadoUsuarioModel> usuarioData =
              doc.snapshots().map((doc) {
            return FirebaseResultadoUsuarioModel.fromDocument(
              doc: doc,
              user: _user,
            );
          });
          return SucessoResultado(result: usuarioData);
        } else {
          return ErrorResultado(
            error: ErroInesperado(
              mensagem: "Erro ao carregar os dados Cod.03-1",
            ),
          );
        }
      } else {
        return ErrorResultado(
          error: ErroInesperado(
            mensagem: "Erro ao carregar os dados Cod.03-2",
          ),
        );
      }
    } catch (e) {
      return ErrorResultado(
        error: ErroInesperado(
          mensagem: "${e.toString()} Erro ao carregar os dados Cod.03-3",
        ),
      );
    }
  }

  Future<auth.User> _usuarioLogado() async {
    return authInstance.currentUser;
  }
}
