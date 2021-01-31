import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../entities/resultado_empresa.dart';
import '../repositories/carregar_empresa_repository.dart';

class CarregarEmpresaUsecase
    extends UseCase<Stream<ResultadoEmpresa>, NoParams> {
  final CarregarEmpresaRepository repository;

  CarregarEmpresaUsecase({@required this.repository});

  @override
  Future<RetornoSucessoOuErro<Stream<ResultadoEmpresa>>> call(
      {NoParams parametros}) async {
    try {
      RetornoSucessoOuErro<Stream<ResultadoEmpresa>> result =
          await repository.carregarEmpresa();
      if (result is SucessoRetorno<Stream<ResultadoEmpresa>>) {
        return result;
      } else {
        return ErroRetorno(
          erro: ErroInesperado(
            mensagem: "Erro ao carregar os dados da Empresa Cod.01-1",
          ),
        );
      }
    } catch (e) {
      return ErroRetorno(
        erro: ErroInesperado(
          mensagem:
              "${e.toString()} - Erro ao carregar os dados da Empresa Cod.01-2",
        ),
      );
    }
  }
}
