import 'package:corelojaapp/app/configuracao_geral/features/checar_coneccao/domain/repositories/checar_coneccao_repository.dart';
import 'package:corelojaapp/app/configuracao_geral/features/checar_coneccao/domain/status/checar_coneccao_usecase_status.dart';
import 'package:corelojaapp/app/configuracao_geral/features/checar_coneccao/domain/usecases/checar_coneccao_usecase.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ChecarConeccaoRepositoryMock extends Mock
    implements ChecarConeccaoRepository {}

main() {
  final repository = ChecarConeccaoRepositoryMock();
  final checarConeccao = ChecarConeccaoUsecaseImpl(repository: repository);

  test('Deve Retornar um ChecarConeccaoStatus', () async {
    when(repository.checarConeccao()).thenAnswer(
        (_) => Future.value(ChecarConeccaoStatus.success..successSet = true));

    final result = await checarConeccao();
    expect(result, isA<ChecarConeccaoStatus>());
  });

  test('Deve Retornar um ChecarConeccaoStatus.success com valor true',
      () async {
    when(repository.checarConeccao()).thenAnswer(
        (_) => Future.value(ChecarConeccaoStatus.success..successSet = true));

    final result = await checarConeccao();
    expect(result.successGet, isA<bool>());
  });

  test('Deve Retornar um ErrorConeccao - Você está offline', () async {
    when(repository.checarConeccao()).thenAnswer(
        (_) => Future.value(ChecarConeccaoStatus.success..successSet = false));

    final result = await checarConeccao();
    expect(result.errorGet, isA<ErrorConeccao>());
  });

  test(
      'Deve Retornar um ErrorConeccao - Erro ao recuperar informação de conexão',
      () async {
    when(repository.checarConeccao()).thenAnswer(
        (_) => Future.value(ChecarConeccaoStatus.error..errorSet = false));

    final result = await checarConeccao();
    expect(result.errorGet, isA<ErrorConeccao>());
  });

  test(
      'Deve Retornar um ErrorConeccao - Erro ao recuperar informação de conexão',
      () async {
    when(repository.checarConeccao()).thenThrow(Exception());

    final result = await checarConeccao();
    expect(result.errorGet, isA<ErrorConeccao>());
  });
}
