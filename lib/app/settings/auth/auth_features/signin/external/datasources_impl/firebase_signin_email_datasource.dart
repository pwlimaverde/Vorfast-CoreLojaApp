import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';

import '../../../../../auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';
import '../../infra/datasources/signin_datasource.dart';

class FarebaseSignInEmailDatasource implements SignInDatasource {
  final auth.FirebaseAuth authInstance;

  FarebaseSignInEmailDatasource({
    required this.authInstance,
  });

  @override
  Future<bool> call({
    String email,
    String pass,
    ResultadoUsuario user,
  }) async {
    try {
      if (email == null || pass == null) {
        return false;
      }
      auth.UserCredential userLogado =
          await authInstance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      if (userLogado != null && userLogado.user.uid.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
