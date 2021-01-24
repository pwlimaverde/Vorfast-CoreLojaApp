import 'package:meta/meta.dart';
import '../datasources/carregar_empresa_datasource.dart';
import '../../domain/entities/resultado_empresa.dart';
import '../../domain/repositories/carregar_empresa_repository.dart';
import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../../../../../shared/utilitario/erros.dart';

class CarregarEmpresaRepositoryImpl implements CarregarEmpresaRepository {
  final CarregarEmpresaDatasource datasource;

  CarregarEmpresaRepositoryImpl({@required this.datasource});

  @override
  Future<RetornoSucessoOuErro<Stream<ResultadoEmpresa>>>
      carregarEmpresa() async {
    try {
      RetornoSucessoOuErro<Stream<ResultadoEmpresa>> empresaData =
          await datasource.carregarEmpresa();
      if (empresaData is SucessoResultado<Stream<ResultadoEmpresa>>) {
        return empresaData;
      } else {
        return ErrorResultado(
          error: ErroInesperado(
              mensagem: "Erro ao carregar os dados da Empresa - Cod.02-1"),
        );
      }
    } catch (e) {
      return ErrorResultado(
        error: ErroInesperado(
          mensagem:
              "${e.toString()} - Erro ao carregar os dados da Empresa - Cod.02-2",
        ),
      );
    }
  }
}
