import 'package:meta/meta.dart';
import '../repositories/signout_repository.dart';
import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../../../../../shared/utilitario/erros.dart';

abstract class SignOutUsecase {
  Future<RetornoSucessoOuErro> call();
}

class SignOutUsecaseImpl implements SignOutUsecase {
  final SignOutRepository repository;

  SignOutUsecaseImpl({@required this.repository});

  @override
  Future<RetornoSucessoOuErro> call() async {
    try {
      RetornoSucessoOuErro check = await repository.signOut();
      if (check is SucessoResultado<bool>) {
        if (check.result) {
          return check;
        }
        return ErrorResultado(
            error:
                ErroInesperado(mensagem: "Erro ao fazer o SignOut Cod.01-1"));
      }
      return ErrorResultado(
          error: ErroInesperado(mensagem: "Erro ao fazer o SignOut Cod.01-2"));
    } catch (e) {
      return ErrorResultado(
          error: ErroInesperado(
              mensagem: "${e.toString()} - Erro ao fazer o SignOut Cod.01-3"));
    }
  }
}
