import '../entities/resultado_empresa.dart';
import '../../../../../../shared/utilitario/erros.dart';

enum CarregarEmpresaStatus {
  success,
  error,
}

extension CarregarEmpresaStatusExt on CarregarEmpresaStatus {
  static AppError _error;
  static Stream<ResultadoEmpresa> _success;

  AppError get errorGet => _error;
  set errorSet(valor) {
    _error = valor;
    _success = null;
  }

  Stream<ResultadoEmpresa> get successGet => _success;
  set successSet(valor) {
    _success = valor;
    _error = null;
  }
}
