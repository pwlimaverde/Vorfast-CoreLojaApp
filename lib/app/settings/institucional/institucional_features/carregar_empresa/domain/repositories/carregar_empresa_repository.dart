import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../entities/resultado_empresa.dart';

abstract class CarregarEmpresaRepository {
  Future<RetornoSucessoOuErro<Stream<ResultadoEmpresa>>> carregarEmpresa();
}
