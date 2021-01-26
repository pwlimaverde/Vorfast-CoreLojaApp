import '../status/carregar_secao_usecase_status.dart';

abstract class CarregarSecaoRepository {
  Future<CarregarSecaoStatus> carregarSecao();
}
