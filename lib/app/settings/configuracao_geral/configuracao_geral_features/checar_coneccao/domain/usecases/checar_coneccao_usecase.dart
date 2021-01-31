import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import '../repositories/checar_coneccao_repository.dart';
import '../../../../../../shared/utilitario/erros.dart';

class ChecarConeccaoUsecase extends UseCase<bool, NoParams> {
  final ChecarConeccaoRepository repository;

  ChecarConeccaoUsecase({@required this.repository});

  @override
  Future<RetornoSucessoOuErro<bool>> call({NoParams parametros}) async {
    try {
      RetornoSucessoOuErro<bool> check = await repository.checarConeccao();
      if (check is SucessoRetorno<bool>) {
        if (check.resultado) {
          return check;
        }
        return ErroRetorno(
            erro: ErrorConeccao(mensagem: "Você está offline Cod.01-1"));
      }
      return ErroRetorno(
          erro: ErrorConeccao(
              mensagem: "Erro ao recuperar informação de conexão Cod.01-2"));
    } catch (e) {
      return ErroRetorno(
          erro: ErrorConeccao(
              mensagem:
                  "${e.toString()} - Erro ao recuperar informação de conexão Cod.01-3"));
    }
  }
}
