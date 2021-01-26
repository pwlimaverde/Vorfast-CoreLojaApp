import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import '../datasources/signin_datasource.dart';
import '../../domain/repositories/signin_repository.dart';
import '../../../../../auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';

class SignInRepositoryImpl implements SignInRepository {
  final SignInDatasource datasource;

  SignInRepositoryImpl({@required this.datasource});

  @override
  Future<RetornoSucessoOuErro> signIn(
      {String email, String pass, ResultadoUsuario user}) async {
    try {
      bool estaSignIn = await datasource(email: email, pass: pass, user: user);
      if (estaSignIn) {
        return SucessoRetorno<bool>(resultado: true);
      }
      return SucessoRetorno<bool>(resultado: false);
    } catch (e) {
      return ErroRetorno(
        erro: ErroInesperado(
          mensagem: "${e.toString()} - Erro ao fazer o SignIn Cod.02-1",
        ),
      );
    }
  }
}
