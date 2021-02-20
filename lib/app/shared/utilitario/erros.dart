import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:meta/meta.dart';

class ErrorConeccao implements AppErro {
  final String mensagem;
  ErrorConeccao({@required this.mensagem});

  @override
  String toString() {
    return "ErrorConeccao - $mensagem";
  }
}

class ErrorCarregarUsuario implements AppErro {
  final String mensagem;
  ErrorCarregarUsuario({@required this.mensagem});

  @override
  String toString() {
    return "ErrorConeccao - $mensagem";
  }
}

class ErrorCarregarEmpresa implements AppErro {
  final String mensagem;
  ErrorCarregarEmpresa({@required this.mensagem});

  @override
  String toString() {
    return "ErrorConeccao - $mensagem";
  }
}

class ErrorCarregarTema implements AppErro {
  final String mensagem;
  ErrorCarregarTema({@required this.mensagem});

  @override
  String toString() {
    return "ErrorConeccao - $mensagem";
  }
}

class ErrorRecuperarSenhaEmail implements AppErro {
  final String mensagem;
  ErrorRecuperarSenhaEmail({@required this.mensagem});

  @override
  String toString() {
    return "ErrorConeccao - $mensagem";
  }
}
