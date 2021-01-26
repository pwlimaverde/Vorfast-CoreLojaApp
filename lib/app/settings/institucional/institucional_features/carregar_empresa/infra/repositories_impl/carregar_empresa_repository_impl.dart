import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import '../datasources/carregar_empresa_datasource.dart';
import '../../domain/entities/resultado_empresa.dart';
import '../../domain/repositories/carregar_empresa_repository.dart';

class CarregarEmpresaRepositoryImpl implements CarregarEmpresaRepository {
  final CarregarEmpresaDatasource datasource;

  CarregarEmpresaRepositoryImpl({@required this.datasource});

  @override
  Future<RetornoSucessoOuErro<Stream<ResultadoEmpresa>>>
      carregarEmpresa() async {
    try {
      RetornoSucessoOuErro<Stream<ResultadoEmpresa>> empresaData =
          await datasource.carregarEmpresa();
      if (empresaData is SucessoRetorno<Stream<ResultadoEmpresa>>) {
        return empresaData;
      } else {
        return ErroRetorno(
          erro: ErroInesperado(
              mensagem: "Erro ao carregar os dados da Empresa - Cod.02-1"),
        );
      }
    } catch (e) {
      return ErroRetorno(
        erro: ErroInesperado(
          mensagem:
              "${e.toString()} - Erro ao carregar os dados da Empresa - Cod.02-2",
        ),
      );
    }
  }
}
