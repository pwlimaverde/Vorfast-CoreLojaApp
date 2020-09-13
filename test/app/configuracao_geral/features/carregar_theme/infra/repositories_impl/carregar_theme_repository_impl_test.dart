import 'package:corelojaapp/app/configuracao_geral/features/carregar_theme/domain/entities/resultado_theme.dart';
import 'package:corelojaapp/app/configuracao_geral/features/carregar_theme/domain/status/carregar_theme_usecase_status.dart';
import 'package:corelojaapp/app/configuracao_geral/features/carregar_theme/infra/datasources/carregar_theme_datasource.dart';
import 'package:corelojaapp/app/configuracao_geral/features/carregar_theme/infra/repositories_impl/carregar_theme_repository_impl.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class CarregarThemeDatasourceMock extends Mock
    implements CarregarThemeDatasource {}

main() {
  final datasource = CarregarThemeDatasourceMock();
  final repository = CarregarThemeRepositoryImpl(datasource: datasource);

  test('Deve retornar um CarregarThemeStatus', () {
    final testeFire = BehaviorSubject<ResultadoTheme>();
    testeFire.add(ResultadoTheme(accent: {"r": 58}, user: "paulo"));

    when(datasource.getTheme()).thenAnswer((_) => testeFire);

    final result = repository.carregarTheme();
    expect(result, isA<Future<CarregarThemeStatus>>());
    testeFire.close();
  });

  test(
      'Deve retornar um CarregarThemeStatus.success com a Stream<ResultadoThemeModel>',
      () async {
    final testeFire = BehaviorSubject<ResultadoTheme>();
    testeFire.add(ResultadoTheme(accent: {"r": 58}, user: "paulo"));

    when(datasource.getTheme()).thenAnswer((_) => testeFire);

    final result = await repository.carregarTheme();
    expect(result.successGet, isA<Stream<ResultadoTheme>>());
    testeFire.close();
  });

  test('Deve retornar um CarregarThemeStatus.error com um ErroInesperado',
      () async {
    final testeFire = BehaviorSubject<ResultadoTheme>();
    testeFire.add(ResultadoTheme(accent: {"r": 58}));

    when(datasource.getTheme()).thenThrow(Exception());

    final result = await repository.carregarTheme();
    expect(result.errorGet, isA<ErroInesperado>());
    testeFire.close();
  });
}
