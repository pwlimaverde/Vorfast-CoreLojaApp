import '../status/carregar_empresa_usecase_status.dart';

abstract class CarregarEmpresaRepository {
  Future<CarregarEmpresaStatus> carregarEmpresa();
}
