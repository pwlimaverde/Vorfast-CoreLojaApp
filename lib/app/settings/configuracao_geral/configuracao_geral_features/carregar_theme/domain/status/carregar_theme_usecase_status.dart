import '../../../../../../shared/utilitario/erros.dart';

import '../entities/resultado_theme.dart';

enum CarregarThemeStatus {
  success,
  error,
}

extension CarregarThemeStatusExt on CarregarThemeStatus {
  static AppError _error;
  static Stream<ResultadoTheme> _success;

  AppError get errorGet => _error;
  set errorSet(valor) {
    _error = valor;
    _success = null;
  }

  Stream<ResultadoTheme> get successGet => _success;
  set successSet(valor) {
    _success = valor;
    _error = null;
  }
}
