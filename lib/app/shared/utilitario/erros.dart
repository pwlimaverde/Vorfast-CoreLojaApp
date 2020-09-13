abstract class AppError implements Exception {}

class ErroInesperado implements AppError {
  final String mensagem;

  ErroInesperado({this.mensagem});

  @override
  String toString() {
    return "ErroInesperado - $mensagem";
  }
}

class ErrorConeccao implements AppError {
  final String mensagem;
  ErrorConeccao({this.mensagem});

  @override
  String toString() {
    return "ErrorConeccao - $mensagem";
  }
}
