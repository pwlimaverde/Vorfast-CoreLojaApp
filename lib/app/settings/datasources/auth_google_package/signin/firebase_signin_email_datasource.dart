import 'dart:async';

import 'package:auth_google_package/auth_google_package.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class FarebaseSignInEmailDatasource
    implements Datasource<bool, ParametrosSignIn> {
  final auth.FirebaseAuth authInstance;

  FarebaseSignInEmailDatasource({
    @required this.authInstance,
  });

  @override
  Future<bool> call({@required ParametrosSignIn parametros}) async {
    try {
      if (parametros.email == null || parametros.pass == null) {
        return false;
      }
      auth.UserCredential userLogado =
          await authInstance.signInWithEmailAndPassword(
        email: parametros.email,
        password: parametros.pass,
      );
      if (userLogado != null && userLogado.user.uid.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
