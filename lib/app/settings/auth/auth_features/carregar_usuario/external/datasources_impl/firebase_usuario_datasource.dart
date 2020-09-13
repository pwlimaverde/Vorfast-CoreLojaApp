import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/firebase_resultado_usuario_model.dart';
import '../../infra/datasources/carregar_usuario_datasource.dart';

class FirebaseUsuarioDatasourse implements CarregarUsuarioDatasource {
  final Firestore firestore;
  final FirebaseAuth auth;

  FirebaseUsuarioDatasourse({
    @required this.firestore,
    @required this.auth,
  });

  @override
  Future<Stream<FirebaseResultadoUsuarioModel>> carregarUsuario() {
    try {
      return _usuarioLogado().then((userFirebase) {
        return firestore
            .collection("user")
            .document(userFirebase.uid)
            .snapshots()
            .map((doc) {
          return FirebaseResultadoUsuarioModel.fromDocument(
            doc: doc,
            user: userFirebase,
          );
        });
      });
    } catch (e) {
      throw e;
    }
  }

  Future<FirebaseUser> _usuarioLogado() async {
    return await auth.currentUser();
  }
}
