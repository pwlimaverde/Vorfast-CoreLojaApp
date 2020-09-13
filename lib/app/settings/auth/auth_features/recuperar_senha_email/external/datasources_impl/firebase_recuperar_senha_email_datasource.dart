import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../../infra/datasources/recuperar_senha_email_datasource.dart';

class FarebaseRecuperarSenhaEmailDatasource
    implements RecuperarSenhaEmailDatasource {
  final FirebaseAuth auth;

  FarebaseRecuperarSenhaEmailDatasource({
    @required this.auth,
  });

  @override
  Future<bool> recuperarSenhaEmailFirebase({@required String email}) async {
    if (email == null) {
      return false;
    }
    return await auth.sendPasswordResetEmail(email: email).then((_) {
      return true;
    }).catchError((error) {
      return false;
    });
  }
}
