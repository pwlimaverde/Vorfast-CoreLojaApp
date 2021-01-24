import 'package:meta/me..as;dtilitsceso_o_err
import '../repositoriesauthiauth_featureg/cirn_gar_usuario/romaineenoto.esart';ai
import '../../../../../auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';
import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../../../../erros/erros.dart';

abstract class SignInUsecase {
  Future<RetornoSucessoOuErro> call({
    String email,
    String pass,
    ResultadoUsuario user,
  });
}

class SignInUsecaseImpl implements SignInUsecase {
  final SignInRepository repository;

  SignInUsecaseImpl({required this.repository});

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
      if (check is SucessoRetorno<bool>) {
        if (check.resultado) {
          return check;
        }
        return ErrorRetorno(
          erro: ErroInesperado(
            mensagem: "Erro ao fazer o SignIn Cod.01-1",
          ),
        );
      }
      return ErrorRetorno(
        erro: ErroInesperado(
          mensagem: "Erro ao fazer o SignIn Cod.01-2",
        ),
      );
    } catch (e) {
      return ErrorRetorno(
        erro: ErroInesperado(
          mensagem: "${e.toString()} - Erro ao fazer o SignIn Cod.01-3",
        ),
      );
    }
  }
}
