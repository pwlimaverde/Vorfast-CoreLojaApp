import 'package:auth_google_package/auth_google_package.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../../../../shared/utilitario/erros.dart';

class FarebaseRecuperarSenhaEmailDatasource
    implements Datasource<bool, ParametrosRecuperarSenhaEmail> {
  final auth.FirebaseAuth authInstance;

  FarebaseRecuperarSenhaEmailDatasource({
    @required this.authInstance,
  });

  @override
  Future<bool> call(
      {@required ParametrosRecuperarSenhaEmail parametros}) async {
    try {
      if (parametros.email == null) {
        return false;
      }
      return await authInstance
          .sendPasswordResetEmail(email: parametros.email)
          .then((_) {
        return true;
      });
    } catch (e) {
      throw ErroRecuperarSenhaEmail(
          mensagem: "Falha ao recuperar a senha pelo email: Cod.03-1");
    }
  }
}
