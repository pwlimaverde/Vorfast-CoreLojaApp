import 'package:corelojaapp/app/configuracao_geral/features/carregar_theme/domain/entities/resultado_theme.dart';
import 'package:corelojaapp/app/configuracao_geral/features/carregar_theme/domain/repositories/carregar_theme_repository.dart';
import 'package:corelojaapp/app/configuracao_geral/features/carregar_theme/domain/status/carregar_theme_usecase_status.dart';
import 'package:corelojaapp/app/configuracao_geral/features/carregar_theme/domain/usecases/carregar_theme_usecase.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class CarregarThemeRepositoryMock extends Mock
    implements CarregarThemeRepository {}

main() {
  final repository = CarregarThemeRepositoryMock();
  final carregarThema = CarregarThemeUsecaseImpl(repository: repository);

  test('Deve retornar um CarregarThemeStatus', () async {
    final testeFire = BehaviorSubject<ResultadoTheme>();
    testeFire.add(ResultadoTheme(accent: {"r": 58}, user: "paulo"));
    when(repository.carregarTheme()).thenAnswer((_) {
      return Future.value(CarregarThemeStatus.success..successSet = testeFire);
    });

    final result = await carregarThema();
    expect(result, isA<CarregarThemeStatus>());
    testeFire.close();
  });

  test(
      'Deve retornar um CarregarThemeStatus.success com a Stream de ResultadoTheme',
      () async {
    final testeFire = BehaviorSubject<ResultadoTheme>();
    testeFire.add(ResultadoTheme(accent: {"r": 58}, user: "paulo"));
    when(repository.carregarTheme()).thenAnswer((_) {
      return Future.value(CarregarThemeStatus.success..successSet = testeFire);
    });

    final result = await carregarThema();
    expect(result.successGet, isA<Stream<ResultadoTheme>>());
    testeFire.close();
  });

  test('Deve retornar um CarregarThemeStatus.error Stream vazia', () async {
    final testeFire = BehaviorSubject<ResultadoTheme>();
    testeFire.add(ResultadoTheme());
    when(repository.carregarTheme()).thenAnswer((_) {
      return Future.value(CarregarThemeStatus.success..successSet = testeFire);
    });

    final result = await carregarThema();
    expect(result.errorGet, isA<ErroInesperado>());
    testeFire.close();
  });

  test('Deve retornar um CarregarThemeStatus.error com um AppError', () async {
    when(repository.carregarTheme()).thenThrow(Exception());

    final result = await carregarThema();
    expect(result.errorGet, isA<ErroInesperado>());
  });
}
