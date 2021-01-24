import 'package:meta/meta.dart';
import '../repositories/signin_repository.dart';
import '../../../../../auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';
import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../../../../../shared/utilitario/erros.dart';

abstract class SignInUsecase {
  Future<RetornoSucessoOuErro> call({
    String email,
    String pass,
    ResultadoUsuario user,
  });
}

class SignInUsecaseImpl implements SignInUsecase {
  final SignInRepository repository;

  SignInUsecaseImpl({@required this.repository});

  @override
  Future<RetornoSucessoOuErro> call({
    String email,
    String pass,
    ResultadoUsuario user,
  }) async {
    try {
      RetornoSucessoOuErro check = await repository.signIn(
        email: email,
        pass: pass,
        user: user,
      );
      if (check is SucessoResultado<bool>) {
        if (check.result) {
          return check;
        }
        return ErrorResultado(
          error: ErroInesperado(
            mensagem: "Erro ao fazer o SignIn Cod.01-1",
          ),
        );
      }
      return ErrorResultado(
        error: ErroInesperado(
          mensagem: "Erro ao fazer o SignIn Cod.01-2",
        ),
      );
    } catch (e) {
      return ErrorResultado(
        error: ErroInesperado(
          mensagem: "${e.toString()} - Erro ao fazer o SignIn Cod.01-3",
        ),
      );
    }
  }
}
