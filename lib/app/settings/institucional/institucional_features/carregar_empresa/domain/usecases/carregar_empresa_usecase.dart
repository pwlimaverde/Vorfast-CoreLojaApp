import 'package:meta/meta.dart';

import '../../../../../../shared/utilitario/erros.dart';
import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../../../../../shared/utilitario/usecase.dart';
import '../entities/resultado_empresa.dart';
import '../repositories/carregar_empresa_repository.dart';

class CarregarEmpresaUsecase
    implements UseCase<Stream<ResultadoEmpresa>, NoParams> {
  final CarregarEmpresaRepository repository;

  CarregarEmpresaUsecase({@required this.repository});

  @override
  Future<RetornoSucessoOuErro<Stream<ResultadoEmpresa>>> call(
      NoParams parametros) async {
    try {
      RetornoSucessoOuErro<Stream<ResultadoEmpresa>> result =
          await repository.carregarEmpresa();
      if (result is SucessoResultado<Stream<ResultadoEmpresa>>) {
        return result;
      } else {
        return ErrorResultado(
          error: ErroInesperado(
            mensagem: "Erro ao carregar os dados da Empresa Cod.01-1",
          ),
        );
      }
    } catch (e) {
      return ErrorResultado(
        error: ErroInesperado(
          mensagem:
              "${e.toString()} - Erro ao carregar os dados da Empresa Cod.01-2",
        ),
      );
    }
  }
}