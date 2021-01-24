import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../domain/entities/resultado_empresa.dart';

abstract class CarregarEmpresaDatasource {
  Future<RetornoSucessoOuErro<Stream<ResultadoEmpresa>>> carregarEmpresa();
}
