import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../entities/resultado_theme.dart';

abstract class CarregarThemeRepository {
  Future<RetornoSucessoOuErro<Stream<ResultadoTheme>>> carregarTheme();
}
