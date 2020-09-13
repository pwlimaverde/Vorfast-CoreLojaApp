import 'package:meta/meta.dart';
import '../../domain/status/carregar_theme_usecase_status.dart';
import '../../domain/entities/resultado_theme.dart';
import '../../domain/repositories/carregar_theme_repository.dart';
import '../../../../../../shared/utilitario/erros.dart';

abstract class CarregarThemeUsecase {
  Future<CarregarThemeStatus> call();
}

class CarregarThemeUsecaseImpl implements CarregarThemeUsecase {
  final CarregarThemeRepository repository;

  CarregarThemeUsecaseImpl({@required this.repository});

  @override
  Future<CarregarThemeStatus> call() async {
    try {
      CarregarThemeStatus result = await repository.carregarTheme();
      if (result == CarregarThemeStatus.success) {
        Stream<ResultadoTheme> themeDados = result.successGet;
        ResultadoTheme resultadoDados =
            await themeDados.map((event) => event).first;
        if (resultadoDados.user.length > 0) {
          return result;
        }
        return CarregarThemeStatus.error
          ..errorSet = ErroInesperado(
              mensagem: "Erro ao carregar os dados do thema Cod.01-1");
      }
      return CarregarThemeStatus.error
        ..errorSet = ErroInesperado(
            mensagem: "Erro ao carregar os dados do thema Cod.01-2");
    } catch (e) {
      return CarregarThemeStatus.error
        ..errorSet = ErroInesperado(
          mensagem:
              "${e.toString()} - Erro ao carregar os dados do thema Cod.01-3",
        );
    }
  }
}
