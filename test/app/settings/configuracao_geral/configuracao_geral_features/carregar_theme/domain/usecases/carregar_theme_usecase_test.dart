import 'package:corelojaapp/app/settings/configuracao_geral/configuracao_geral_features/carregar_theme/domain/entities/resultado_theme.dart';
import 'package:corelojaapp/app/settings/configuracao_geral/configuracao_geral_features/carregar_theme/domain/repositories/carregar_theme_repository.dart';
import 'package:corelojaapp/app/settings/configuracao_geral/configuracao_geral_presenter/configuracao_geral_presenter.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:corelojaapp/app/shared/utilitario/resultado_sucesso_ou_error.dart';
import 'package:corelojaapp/app/shared/utilitario/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class CarregarThemeRepositoryMock extends Mock
    implements CarregarThemeRepository {}

main() {
  final repository = CarregarThemeRepositoryMock();
  final carregarThema = CarregarThemeUsecase(repository: repository);

  test('Deve retornar um RetornoSucessoOuErro', () async {
    final testeFire = BehaviorSubject<ResultadoTheme>();
    testeFire.add(
        ResultadoTheme(accent: {"r": 58}, primary: {"r": 150}, user: "paulo"));
    when(repository.carregarTheme()).thenAnswer((_) {
      return Future.value(
        SucessoRetorno(
          resultado: testeFire,
        ),
      );
    });

    final result = await carregarThema(NoParams());
    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );
    expect(result, isA<RetornoSucessoOuErro<Stream<ResultadoTheme>>>());
    testeFire.close();
  });

  test(
      'Deve retornar um RetornoSucessoOuErro successo com a Stream de ResultadoTheme',
      () async {
    final testeFire = BehaviorSubject<ResultadoTheme>();
    testeFire.add(
        ResultadoTheme(accent: {"r": 58}, primary: {"r": 150}, user: "paulo"));
    when(repository.carregarTheme()).thenAnswer((_) {
      return Future.value(
        SucessoRetorno(
          resultado: testeFire,
        ),
      );
    });

    final result = await carregarThema(NoParams());
    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.error,
        ),
        isA<Stream<ResultadoTheme>>());
    testeFire.close();
  });

  test('Deve retornar um RetornoSucessoOuErro error com um AppErro Cod.01-1',
      () async {
    final testeFire = BehaviorSubject<ResultadoTheme>();
    testeFire.add(ResultadoTheme());
    when(repository.carregarTheme()).thenAnswer((_) {
      return Future.value(
        ErroRetorno(
          erro: ErroInesperado(
            mensagem: "Erro ao carregar os dados do thema",
          ),
        ),
      );
    });

    final result = await carregarThema(NoParams());
    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.error,
        ),
        isA<ErroInesperado>());
    testeFire.close();
  });

  test('Deve retornar um RetornoSucessoOuErro error com um AppErro Cod.01-2',
      () async {
    when(repository.carregarTheme()).thenThrow(Exception());

    final result = await carregarThema(NoParams());
    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.error,
        ),
        isA<ErroInesperado>());
  });
}
