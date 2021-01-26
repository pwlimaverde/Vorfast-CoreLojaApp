import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import '../repositories/recuperar_senha_email_repository.dart';

class RecuperarSenhaEmailUsecase
    implements UseCase<bool, ParametrosRecuperarSenhaEmail> {
  final RecuperarSenhaEmailRepository repository;

  RecuperarSenhaEmailUsecase({@required this.repository});

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
          return ErroRetorno(
              erro: ErroInesperado(
                  mensagem: "Erro ao RecuperarSenhaEmail Cod.01-1"));
        }
      } else {
        return ErroRetorno(
            erro: ErroInesperado(
                mensagem: "Erro ao RecuperarSenhaEmail Cod.01-2"));
      }
    } catch (e) {
      return ErroRetorno(
          erro: ErroInesperado(
              mensagem:
                  "${e.toString()} - Erro ao RecuperarSenhaEmail Cod.01-3"));
    }
  }
}

class ParametrosRecuperarSenhaEmail {
  final String email;

  ParametrosRecuperarSenhaEmail({@required this.email});
}
