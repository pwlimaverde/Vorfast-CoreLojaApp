import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';

abstract class ChecarConeccaoRepository {
  Future<RetornoSucessoOuErro<bool>> checarConeccao();
}
