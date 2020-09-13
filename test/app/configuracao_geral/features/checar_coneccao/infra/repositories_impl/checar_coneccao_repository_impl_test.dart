import 'package:corelojaapp/app/configuracao_geral/features/checar_coneccao/domain/status/checar_coneccao_usecase_status.dart';
import 'package:corelojaapp/app/configuracao_geral/features/checar_coneccao/infra/datasources/checar_coneccao_datasource.dart';
import 'package:corelojaapp/app/configuracao_geral/features/checar_coneccao/infra/repositories_impl/checar_coneccao_repository_impl.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ChecarConeccaoDatasourceMock extends Mock
    implements ChecarConeccaoDatasource {}

main() {
  final datasource = ChecarConeccaoDatasourceMock();
  final repository = ChecarConeccaoRepositoryImpl(datasource: datasource);

  test('Deve retornar um ChecarConeccaoStatus', () async {
    when(datasource.isOnline).thenAnswer((_) => Future.value(true));

    final result = await repository.checarConeccao();
    expect(result, isA<ChecarConeccaoStatus>());
  });

  test('Deve retornar um ChecarConeccaoStatus.success com valor true',
      () async {
    when(datasource.isOnline).thenAnswer((_) => Future.value(true));

    final result = await repository.checarConeccao();
    expect(result.successGet, true);
  });

  test('Deve retornar um ChecarConeccaoStatus.success com valor false',
      () async {
    when(datasource.isOnline).thenAnswer((_) => Future.value(false));

    final result = await repository.checarConeccao();
    expect(result.successGet, false);
  });

  test('Deve retornar um ChecarConeccaoStatus.error com valor ErrorConeccao',
      () async {
    when(datasource.isOnline).thenThrow(Exception());

    final result = await repository.checarConeccao();
    expect(result.errorGet, isA<ErrorConeccao>());
  });
}
