import 'package:corelojaapp/app/settings/configuracao_geral/configuracao_geral_features/carregar_theme/domain/entities/resultado_theme.dart';
import 'package:corelojaapp/app/settings/configuracao_geral/configuracao_geral_features/carregar_theme/infra/datasources/carregar_theme_datasource.dart';
import 'package:corelojaapp/app/settings/configuracao_geral/configuracao_geral_features/carregar_theme/infra/repositories_impl/carregar_theme_repository_impl.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:corelojaapp/app/shared/utilitario/resultado_sucesso_ou_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class CarregarThemeDatasourceMock extends Mock
    implements CarregarThemeDatasource {}

main() {
  final datasource = CarregarThemeDatasourceMock();
  final repository = CarregarThemeRepositoryImpl(datasource: datasource);

  test('Deve retornar um RetornoSucessoOuErro', () async {
    final testeTheme = BehaviorSubject<ResultadoTheme>();
    testeTheme.add(ResultadoTheme(accent: {"r": 58}, user: "paulo"));
    RetornoSucessoOuErro<Stream<ResultadoTheme>> testeFire =
        SucessoResultado(result: testeTheme);

    when(datasource.getTheme()).thenAnswer((_) => Future(() => testeFire));

    final result = await repository.carregarTheme();
    print(
      "teste result => ${result.fold(sucesso: (value) => value.result, error: (value) => value.error)}",
    );
    expect(result, isA<RetornoSucessoOuErro>());
    testeTheme.close();
  });

  test(
      'Deve retornar um RetornoSucessoOuErro successo com a Stream<ResultadoThemeModel>',
      () async {
    final testeTheme = BehaviorSubject<ResultadoTheme>();
    testeTheme.add(ResultadoTheme(accent: {"r": 58}, user: "paulo"));
    RetornoSucessoOuErro<Stream<ResultadoTheme>> testeFire =
        SucessoResultado(result: testeTheme);

    when(datasource.getTheme()).thenAnswer((_) => Future(() => testeFire));

    final result = await repository.carregarTheme();
    print(
      "teste result => ${result.fold(sucesso: (value) => value.result, error: (value) => value.error)}",
    );
    expect(
        result.fold(
          sucesso: (value) => value.result,
          error: (value) => value.error,
        ),
        isA<Stream<ResultadoTheme>>());
    testeTheme.close();
  });

  test(
      'Deve retornar um RetornoSucessoOuErro error com um ErroInesperado Cod.02-1',
      () async {
    final testeTheme = BehaviorSubject<ResultadoTheme>();
    testeTheme.add(ResultadoTheme(accent: {"r": 58}, user: "paulo"));
    RetornoSucessoOuErro<Stream<ResultadoTheme>> testeFire = ErrorResultado(
      error: ErroInesperado(
        mensagem: " Erro ao carregar os dados Cod.02-2",
      ),
    );

    when(datasource.getTheme()).thenAnswer((_) => Future(() => testeFire));

    final result = await repository.carregarTheme();
    print(
      "teste result => ${result.fold(sucesso: (value) => value.result, error: (value) => value.error)}",
    );
    expect(
        result.fold(
          sucesso: (value) => value.result,
          error: (value) => value.error,
        ),
        isA<ErroInesperado>());
    testeTheme.close();
  });

  test(
      'Deve retornar um RetornoSucessoOuErro error com um ErroInesperado Cod.02-2',
      () async {
    when(datasource.getTheme()).thenThrow(Exception());

    final result = await repository.carregarTheme();
    print(
      "teste result => ${result.fold(sucesso: (value) => value.result, error: (value) => value.error)}",
    );
    expect(
        result.fold(
          sucesso: (value) => value.result,
          error: (value) => value.error,
        ),
        isA<ErroInesperado>());
  });
}
