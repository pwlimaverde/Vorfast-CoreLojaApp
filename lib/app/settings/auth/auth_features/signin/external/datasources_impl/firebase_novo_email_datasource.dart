import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';
import '../../../../../auth/auth_features/carregar_usuario/external/model/firebase_resultado_usuario_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../../infra/datasources/signin_datasource.dart';

class FarebaseNovoEmailDatasource implements SignInDatasource {
  final FirebaseAuth auth;
  final Firestore firestore;

  FarebaseNovoEmailDatasource({
    @required this.auth,
    @required this.firestore,
  });

  @override
  Future<bool> call({String email, String pass, ResultadoUsuario user}) async {
    if (pass == null || user == null) {
      return false;
    }
    return auth
        .createUserWithEmailAndPassword(
      email: user.email,
      password: pass,
    )
        .then((value) async {
      await _saveUserData(userFire: value.user, userData: user);
      return true;
    }).catchError((error) {
      return false;
    });
  }

  Future<void> _saveUserData(
      {FirebaseUser userFire, FirebaseResultadoUsuarioModel userData}) async {
    await firestore.collection("user").document(userFire.uid).setData({
      'nome': userData.nome,
      'id': userFire.uid,
      'email': userData.email,
      'administrador': userData.administrador,
    });
  }
}
