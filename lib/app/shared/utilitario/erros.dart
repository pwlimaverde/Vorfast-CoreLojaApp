import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:meta/meta.dart';

class ErroConeccao implements AppErro {
  final String mensagem;
  ErroConeccao({@required this.mensagem});

  @override
  String toString() {
    return "ErroConeccao - $mensagem";
  }
}

class ErroCarregarUsuario implements AppErro {
  final String mensagem;
  ErroCarregarUsuario({@required this.mensagem});

  @override
  String toString() {
    return "ErroCarregarUsuario - $mensagem";
  }
}

class ErroCarregarEmpresa implements AppErro {
  final String mensagem;
  ErroCarregarEmpresa({@required this.mensagem});

  @override
  String toString() {
    return "ErroCarregarEmpresa - $mensagem";
  }
}

class ErroCarregarTema implements AppErro {
  final String mensagem;
  ErroCarregarTema({@required this.mensagem});

  @override
  String toString() {
    return "ErroCarregarTema - $mensagem";
  }
}

class ErroRecuperarSenhaEmail implements AppErro {
  final String mensagem;
  ErroRecuperarSenhaEmail({@required this.mensagem});

  @override
  String toString() {
    return "ErroRecuperarSenhaEmail - $mensagem";
  }
}
