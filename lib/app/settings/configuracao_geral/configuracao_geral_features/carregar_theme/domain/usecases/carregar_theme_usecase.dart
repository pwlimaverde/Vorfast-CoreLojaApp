import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../../domain/entities/resultado_theme.dart';
import '../../domain/repositories/carregar_theme_repository.dart';

class CarregarThemeUsecase
    implements UseCase<Stream<ResultadoTheme>, NoParams> {
  final CarregarThemeRepository repository;

  CarregarThemeUsecase({required this.repository});

  @override
  Future<RetornoSucessoOuErro<Stream<ResultadoTheme>>> call(
      NoParams parametros) async {
    try {
      RetornoSucessoOuErro<Stream<ResultadoTheme>> result =
          await repository.carregarTheme();
      if (result is SucessoRetorno<Stream<ResultadoTheme>>) {
        return result;
      } else {
        return ErrorRetorno(
          erro: ErroInesperado(
            mensagem: "Erro ao carregar os dados do thema Cod.01-1",
          ),
        );
      }
    } catch (e) {
      return ErrorRetorno(
        erro: ErroInesperado(
          mensagem:
              "${e.toString()} - Erro ao carregar os dados do thema Cod.01-2",
        ),
      );
    }
  }
}
