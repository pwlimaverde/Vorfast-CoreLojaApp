import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../entities/resultado_usuario.dart';

abstract class CarregarUsuarioRepository {
  Future<RetornoSucessoOuErro<Stream<ResultadoUsuario>>> carregarUsuario();
}
