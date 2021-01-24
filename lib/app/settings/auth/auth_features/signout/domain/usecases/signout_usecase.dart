import 'package:meta/meta.dart';

import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../../../../erros/erros.dart';
import '../repositories/signout_repository.dart';

abstract class SignOutUsecase {
  Future<RetornoSucessoOuErro> call();
}

class SignOutUsecaseImpl implements SignOutUsecase {
  final SignOutRepository repository;

  SignOutUsecaseImpl({required this.repository});

  @override
  Future<RetornoSucessoOuErro> call() async {
    try {
      RetornoSucessoOuErro check = await repository.signOut();
      if (check is SucessoRetorno<bool>) {
        if (check.resultado) {
          return check;
        }
        return ErrorRetorno(
            erro: ErroInesperado(mensagem: "Erro ao fazer o SignOut Cod.01-1"));
      }
      return ErrorRetorno(
          erro: ErroInesperado(mensagem: "Erro ao fazer o SignOut Cod.01-2"));
    } catch (e) {
      return ErrorRetorno(
          erro: ErroInesperado(
              mensagem: "${e.toString()} - Erro ao fazer o SignOut Cod.01-3"));
    }
  }
}
