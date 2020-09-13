import 'package:meta/meta.dart';
import '../../domain/entities/resultado_empresa.dart';
import '../../domain/repositories/carregar_empresa_repository.dart';
import '../../domain/status/carregar_empresa_usecase_status.dart';
import '../../../../../../shared/utilitario/erros.dart';
import '../datasources/carregar_empresa_datasource.dart';

class CarregarEmpresaRepositoryImpl implements CarregarEmpresaRepository {
  final CarregarEmpresaDatasource datasource;

  CarregarEmpresaRepositoryImpl({@required this.datasource});

  @override
  Future<CarregarEmpresaStatus> carregarEmpresa() async {
    try {
      Stream<ResultadoEmpresa> empresaData = datasource.carregarEmpresa();
      if (await empresaData.isEmpty || empresaData == null) {
        return CarregarEmpresaStatus.error
          ..errorSet = ErroInesperado(
              mensagem: "Erro ao carregar os dados da Empresa - Cod.02-1");
      }
      return CarregarEmpresaStatus.success..successSet = empresaData;
    } catch (e) {
      return CarregarEmpresaStatus.error
        ..errorSet = ErroInesperado(
          mensagem:
              "${e.toString()} - Erro ao carregar os dados da Empresa - Cod.02-2",
        );
    }
  }
}
