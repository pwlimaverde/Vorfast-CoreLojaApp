import 'package:meta/meta.dart';

import '../../../../../../shared/utilitario/erros.dart';
import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../domain/entities/resultado_theme.dart';
import '../../domain/repositories/carregar_theme_repository.dart';
import '../datasources/carregar_theme_datasource.dart';

class CarregarThemeRepositoryImpl implements CarregarThemeRepository {
  final CarregarThemeDatasource datasource;

  CarregarThemeRepositoryImpl({@required this.datasource});

  @override
  Future<RetornoSucessoOuErro<Stream<ResultadoTheme>>> carregarTheme() async {
    try {
      RetornoSucessoOuErro<Stream<ResultadoTheme>> themeData =
          await datasource.getTheme();
      if (themeData is SucessoResultado<Stream<ResultadoTheme>>) {
        return themeData;
      } else {
        return ErrorResultado(
          error: ErroInesperado(
            mensagem: "Erro ao carregar os dados Cod.02-1",
          ),
        );
      }
    } catch (e) {
      return ErrorResultado(
        error: ErroInesperado(
          mensagem: "${e.toString()} Erro ao carregar os dados Cod.02-2",
        ),
      );
    }
  }
}
