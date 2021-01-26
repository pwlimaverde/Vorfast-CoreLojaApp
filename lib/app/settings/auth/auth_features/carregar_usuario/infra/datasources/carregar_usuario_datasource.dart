import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../../domain/entities/resultado_usuario.dart';

abstract class CarregarUsuarioDatasource {
  Future<RetornoSucessoOuErro<Stream<ResultadoUsuario>>> carregarUsuario();
}
