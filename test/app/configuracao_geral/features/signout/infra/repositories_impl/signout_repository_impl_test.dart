import 'package:corelojaapp/app/configuracao_geral/features/signout/domain/status/signout_usecase_status.dart';
import 'package:corelojaapp/app/configuracao_geral/features/signout/infra/datasources/signout_datasource.dart';
import 'package:corelojaapp/app/configuracao_geral/features/signout/infra/repositories_impl/signout_repository_impl.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SignOutDatasourceMock extends Mock implements SignOutDatasource {}

main() {
  final datasource = SignOutDatasourceMock();
  final repository = SignOutRepositoryImpl(datasource: datasource);

  test('Deve retornar um SignOutStatus', () async {
    when(datasource.signOutFirebase()).thenAnswer((_) => Future.value(true));

    final result = await repository.signOut();
    expect(result, isA<SignOutStatus>());
  });

  test('Deve retornar um SignOutStatus.success com valor true', () async {
    when(datasource.signOutFirebase()).thenAnswer((_) => Future.value(true));

    final result = await repository.signOut();
    expect(result.successGet, true);
  });

  test('Deve retornar um SignOutStatus.success com valor false', () async {
    when(datasource.signOutFirebase()).thenAnswer((_) => Future.value(false));

    final result = await repository.signOut();
    expect(result.successGet, false);
  });

  test('Deve retornar um SignOutStatus.error com valor ErroInesperado',
      () async {
    when(datasource.signOutFirebase()).thenThrow(Exception());

    final result = await repository.signOut();
    expect(result.errorGet, isA<ErroInesperado>());
  });
}
