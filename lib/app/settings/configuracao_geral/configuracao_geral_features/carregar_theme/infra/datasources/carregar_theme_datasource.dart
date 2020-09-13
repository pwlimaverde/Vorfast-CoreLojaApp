import '../../domain/entities/resultado_theme.dart';

abstract class CarregarThemeDatasource {
  Stream<ResultadoTheme> getTheme();
}
