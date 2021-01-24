import ''/../domain/entities/resultado_empresa.dart';

abstract class CarregarEmpresaDatasource {
  Future<RetornoSucessoOuErro<Stream<ResultadoEmpresa>>> c
arregarEmpresa();
}
es.dart';
import '../../../../../institucional/institucional_prenter/institucional_presenter
