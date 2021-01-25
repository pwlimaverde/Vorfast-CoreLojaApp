import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

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
        return ErroRetorno(
            erro: ErroInesperado(mensagem: "Erro ao fazer o SignOut Cod.01-1"));
      }
      return ErroRetorno(
          erro: ErroInesperado(mensagem: "Erro ao fazer o SignOut Cod.01-2"));
    } catch (e) {
      return ErroRetorno(
          erro: ErroInesperado(
              mensagem: "${e.toString()} - Erro ao fazer o SignOut Cod.01-3"));
    }
  }
}
