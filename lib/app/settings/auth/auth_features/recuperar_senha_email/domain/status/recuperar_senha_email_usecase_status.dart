import '../../../../../../shared/utilitario/erros.dart';

enum RecuperarSenhaEmailStatus {
  success,
  error,
}

extension RecuperarSenhaEmailStatusExt on RecuperarSenhaEmailStatus {
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
