import 'package:meta/meta.dart';

import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../../../../auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';
import '../../../../../erros/erros.dart';
import '../../domain/repositories/signin_repository.dart';
import '../datasources/signin_datasource.dart';

class SignInRepositoryImpl implements SignInRepository {
  final SignInDatasource datasource;

  SignInRepositoryImpl({required this.datasource});

  @override
  Future<RetornoSucessoOuErro> signIn(
      {String email, String pass, ResultadoUsuario user}) async {
    try {
      bool estaSignIn = await datasource(email: email, pass: pass, user: user);
      if (estaSignIn) {
        return SucessoRetorno<bool>(result: true);
      }
      return SucessoRetorno<bool>(result: false);
    } catch (e) {
      return ErrorRetorno(
        erro: ErroInesperado(
          mensagem: "${e.toString()} - Erro ao fazer o SignIn Cod.02-1",
        ),
      );
    }
  }
}
