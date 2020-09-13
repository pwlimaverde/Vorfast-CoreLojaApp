import '../status/checar_coneccao_usecase_status.dart';

abstract class ChecarConeccaoRepository {
  Future<ChecarConeccaoStatus> checarConeccao();
}
