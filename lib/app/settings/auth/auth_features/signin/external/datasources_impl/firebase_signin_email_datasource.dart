import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../../../../../auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';
import '../../infra/datasources/signin_datasource.dart';

class FarebaseSignInEmailDatasource implements SignInDatasource {
  final FirebaseAuth auth;

  FarebaseSignInEmailDatasource({
    @required this.auth,
  });

  @override
  Future<bool> call({
    String email,
    String pass,
    ResultadoUsuario user,
  }) async {
    if (email == null || pass == null) {
      return false;
    }
    return auth
        .signInWithEmailAndPassword(
      email: email,
      password: pass,
    )
        .then((value) {
      return true;
    }).catchError((error) {
      return false;
    });
  }
}
