import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import 'model/firebase_resultado_usuario_model.dart';

class FirebaseCarregarUsuarioDatasourse
    extends Datasource<Stream<FirebaseResultadoUsuarioModel>, NoParams> {
  final FirebaseFirestore firestore;
  final auth.FirebaseAuth authInstance;

  FirebaseCarregarUsuarioDatasourse({
    @required this.firestore,
    @required this.authInstance,
  });

  @override
  Future<Stream<FirebaseResultadoUsuarioModel>> call(
      {NoParams parametros}) async {
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
          return usuarioData;
        } else {
          throw Exception("Falha ao carregar os dados: Usuario Inválido");
        }
      } else {
        throw Exception("Falha ao carregar os dados: Usuario Inválido");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<auth.User> _usuarioLogado() async {
    return authInstance.currentUser;
  }
}
