import 'package:meta/meta.dart';
import '../../domain/entities/resultado_theme.dart';
import '../../domain/status/carregar_theme_usecase_status.dart';
import '../datasources/carregar_theme_datasource.dart';
import '../../domain/repositories/carregar_theme_repository.dart';
import '../../../../../../shared/utilitario/erros.dart';

class CarregarThemeRepositoryImpl implements CarregarThemeRepository {
  final CarregarThemeDatasource datasource;

  CarregarThemeRepositoryImpl({@required this.datasource});

  @override
  Future<CarregarThemeStatus> carregarTheme() async {
    try {
      Stream<ResultadoTheme> themeData = datasource.getTheme();
      if (await themeData.isEmpty || themeData == null) {
        return CarregarThemeStatus.error
          ..errorSet = ErroInesperado(mensagem: "Erro ao carregar os dados");
      }
      return CarregarThemeStatus.success..successSet = themeData;
    } catch (e) {
      return CarregarThemeStatus.error
        ..errorSet = ErroInesperado(
          mensagem: e.toString(),
        );
    }
  }
}
