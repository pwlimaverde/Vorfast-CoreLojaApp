import '../../../../../../shared/utilitario/erros.dart';

enum SignInStatus {
  success,
  error,
}

extension SignInStatusExt on SignInStatus {
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
