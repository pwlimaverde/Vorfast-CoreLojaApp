import '../../../../../erros/erros.dart';
import '../entities/resultado_secao.dart';

enum CarregarSecaoStatus {
  success,
  error,
}

extension CarregarSecaoStatusExt on CarregarSecaoStatus {
  static AppErro _error;
  static Stream<List<ResultadoSecao>> _success;

  AppErro get errorGet => _error;
  set errorSet(valor) {
    _error = valor;
    _success = null;
  }

  Stream<List<ResultadoSecao>> get successGet => _success;
  set successSet(valor) {
    _success = valor;
    _error = null;
  }
}
