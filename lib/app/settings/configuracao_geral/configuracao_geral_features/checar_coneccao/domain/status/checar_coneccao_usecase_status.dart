import '../../../../../../shared/utilitario/erros.dart';

enum ChecarConeccaoStatus {
  success,
  error,
}

extension ChecarConeccaoStatusExt on ChecarConeccaoStatus {
  static AppError _error;
  static bool _success;

  AppError get errorGet => _error;
  set errorSet(valor) {
    _error = valor;
    _success = false;
  }

  bool get successGet => _success;
  set successSet(valor) {
    _success = valor;
    _error = null;
  }
}
