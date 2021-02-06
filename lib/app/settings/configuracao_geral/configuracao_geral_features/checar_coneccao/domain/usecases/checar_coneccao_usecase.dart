import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import '../../../../../../shared/utilitario/erros.dart';
import '../../../../../../shared/utilitario/tempo_execucao.dart';

class ChecarConeccaoUsecase extends UseCase<bool, NoParams> {
  final Repositorio<bool, NoParams> repository;
  final bool mostrarTempoExecucao;

  ChecarConeccaoUsecase({@required this.repository, this.mostrarTempoExecucao});

  @override
  Future<RetornoSucessoOuErro<bool>> call(
      {@required NoParams parametros}) async {
    TempoExecucao tempo = TempoExecucao();
    tempo.iniciar();

    final resultado = await retornoRepositorio(
      repositorio: repository,
      erro: ErrorConeccao(
          mensagem: "Erro ao recuperar informação de conexão Cod.01-1"),
      parametros: NoParams(),
    );
    if (resultado is SucessoRetorno<bool>) {
      if (!resultado.resultado) {
        if (mostrarTempoExecucao ?? false) {
          tempo.terminar();
          print(
              "Tempo de Execução com erro do ChecarConeccaoPresenter: ${tempo.calcularExecucao()}ms");
        }
        return ErroRetorno(
            erro: ErrorConeccao(mensagem: "Você está offline Cod.01-2"));
      }
    }
    if (mostrarTempoExecucao ?? false) {
      tempo.terminar();
      print(
          "Tempo de Execução do ChecarConeccaoPresenter: ${tempo.calcularExecucao()}ms");
    }
    return resultado;
  }

  consultaConectividade() {}
}
