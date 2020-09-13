import '../status/carregar_theme_usecase_status.dart';

abstract class CarregarThemeRepository {
  Future<CarregarThemeStatus> carregarTheme();
}
