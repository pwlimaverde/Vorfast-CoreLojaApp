import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../../domain/entities/resultado_empresa.dart';

abstract class CarregarEmpresaDatasource {
  Future<RetornoSucessoOuErro<Stream<ResultadoEmpresa>>> carregarEmpresa();
}
