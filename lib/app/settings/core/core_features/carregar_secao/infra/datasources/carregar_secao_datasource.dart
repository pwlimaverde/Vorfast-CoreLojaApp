import '../../domain/entities/resultado_secao.dart';

abstract class CarregarSecaoDatasource {
  Stream<List<ResultadoSecao>> getSecao();
}
