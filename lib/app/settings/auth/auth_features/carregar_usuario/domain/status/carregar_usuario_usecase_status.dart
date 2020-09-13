import '../entities/resultado_usuario.dart';
import '../../../../../../shared/utilitario/erros.dart';

enum CarregarUsuarioStatus {
  success,
  error,
}

extension CarregarUsuarioStatusExt on CarregarUsuarioStatus {
  static AppError _error;
  static Stream<ResultadoUsuario> _success;

  AppError get errorGet => _error;
  set errorSet(valor) {
    _error = valor;
    _success = null;
  }

  Stream<ResultadoUsuario> get successGet => _success;
  set successSet(valor) {
    _success = valor;
    _error = null;
  }
}
