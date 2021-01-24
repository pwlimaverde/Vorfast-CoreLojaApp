import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';

import '../../infra/datasources/recuperar_senha_email_datasource.dart';

class FarebaseRecuperarSenhaEmailDatasource
    implements RecuperarSenhaEmailDatasource {
  final auth.FirebaseAuth authInstance;

  FarebaseRecuperarSenhaEmailDatasource({
    required this.authInstance,
  });

  @override
  Future<bool> recuperarSenhaEmailFirebase({required String email}) async {
    try {
      if (email == null) {
        return false;
      }
      return await authInstance.sendPasswordResetEmail(email: email).then((_) {
        return true;
      });
    } catch (e) {
      return false;
    }
  }
}
