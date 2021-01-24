import 'package:meta/meta.dart';

import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../../../../../shared/utilitario/usecase.dart';
import '../../../../../erros/erros.dart';
import '../repositories/recuperar_senha_email_repository.dart';

class RecuperarSenhaEmailUsecaseImpl
    implements UseCase<bool, ParametrosRecuperarSenhaEmail> {
  final RecuperarSenhaEmailRepository repository;

  RecuperarSenhaEmailUsecaseImpl({required this.repository});

  @override
  Future<RetornoSucessoOuErro<bool>> call(
      ParametrosRecuperarSenhaEmail parametros) async {
    try {
      RetornoSucessoOuErro<bool> check =
          await repository.recuperarSenhaEmail(email: parametros.email);
      if (check is SucessoRetorno<bool>) {
        if (check.resultado) {
          return check;
        } else {
          return ErrorRetorno(
              erro: ErroInesperado(
                  mensagem: "Erro ao RecuperarSenhaEmail Cod.01-1"));
        }
      } else {
        return ErrorRetorno(
            erro: ErroInesperado(
                mensagem: "Erro ao RecuperarSenhaEmail Cod.01-2"));
      }
    } catch (e) {
      return ErrorRetorno(
          erro: ErroInesperado(
              mensagem:
                  "${e.toString()} - Erro ao RecuperarSenhaEmail Cod.01-3"));
    }
  }
}

class ParametrosRecuperarSenhaEmail {
  final String email;

  ParametrosRecuperarSenhaEmail({required this.email});
}
