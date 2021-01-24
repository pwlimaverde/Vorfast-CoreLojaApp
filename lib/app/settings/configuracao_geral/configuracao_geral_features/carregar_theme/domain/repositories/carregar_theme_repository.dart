import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../entities/resultado_theme.dart';

abstract class CarregarThemeRepository {
  Future<RetornoSucessoOuErro<Stream<ResultadoTheme>>> carregarTheme();
}
