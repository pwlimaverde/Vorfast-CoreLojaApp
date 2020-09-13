import 'package:meta/meta.dart';
import '../../../../../auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';
import '../../../../../../shared/utilitario/erros.dart';
import '../../domain/status/signin_usecase_status.dart';
import '../../domain/repositories/signin_repository.dart';
import '../datasources/signin_datasource.dart';

class SignInRepositoryImpl implements SignInRepository {
  final SignInDatasource datasource;

  SignInRepositoryImpl({@required this.datasource});

  @override
  Future<SignInStatus> signIn(
      {String email, String pass, ResultadoUsuario user}) async {
    try {
      bool estaSignIn = await datasource(email: email, pass: pass, user: user);
      if (estaSignIn) {
        return SignInStatus.success..successSet = true;
      }
      return SignInStatus.success..successSet = false;
    } catch (e) {
      return SignInStatus.error
        ..errorSet = ErroInesperado(
            mensagem: "${e.toString()} - Erro ao fazer o SignIn Cod.02-1");
    }
  }
}
