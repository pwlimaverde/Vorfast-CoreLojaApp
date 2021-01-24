import 'package:corelojaapp/app/shared/utilitario/usecase.dart';
import 'package:meta/meta.dart';
import '../repositories/checar_coneccao_repository.dart';
import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../../../../../shared/utilitario/erros.dart';

class ChecarConeccaoUsecase implements UseCase<bool, NoParams> {
  final ChecarConeccaoRepository repository;

  ChecarConeccaoUsecase({@required this.repository});

  @override
  Future<RetornoSucessoOuErro<bool>> call(NoParams parametros) async {
    try {
      RetornoSucessoOuErro<bool> check = await repository.checarConeccao();
      if (check is SucessoResultado<bool>) {
        if (check.result) {
          return check;
        }
        return ErrorResultado(
            error: ErrorConeccao(mensagem: "Você está offline Cod.01-1"));
      }
      return ErrorResultado(
          error: ErrorConeccao(
              mensagem: "Erro ao recuperar informação de conexão Cod.01-2"));
    } catch (e) {
      return ErrorResultado(
          error: ErrorConeccao(
              mensagem:
                  "${e.toString()} - Erro ao recuperar informação de conexão Cod.01-3"));
    }
  }
}
