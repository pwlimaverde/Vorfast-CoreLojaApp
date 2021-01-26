import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../../domain/entities/resultado_theme.dart';

abstract class CarregarThemeDatasource {
  Future<RetornoSucessoOuErro<Stream<ResultadoTheme>>> getTheme();
}
