import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../entities/resultado_empresa.dart';

abstract class CarregarEmpresaRepository {
  Future<RetornoSucessoOuErro<Stream<ResultadoEmpresa>>> carregarEmpresa();
}
