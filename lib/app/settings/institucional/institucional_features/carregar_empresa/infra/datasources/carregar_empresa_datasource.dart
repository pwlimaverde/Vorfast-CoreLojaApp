import '../../domain/entities/resultado_empresa.dart';

abstract class CarregarEmpresaDatasource {
  Stream<ResultadoEmpresa> carregarEmpresa();
}
