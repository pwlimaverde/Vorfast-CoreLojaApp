import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../domain/entities/resultado_theme.dart';

abstract class CarregarThemeDatasource {
  Future<RetornoSucessoOuErro<Stream<ResultadoTheme>>> getTheme();
}
