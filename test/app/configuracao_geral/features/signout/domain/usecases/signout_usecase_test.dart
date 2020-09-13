import 'package:corelojaapp/app/configuracao_geral/features/signout/domain/repositories/signout_repository.dart';
import 'package:corelojaapp/app/configuracao_geral/features/signout/domain/status/signout_usecase_status.dart';
import 'package:corelojaapp/app/configuracao_geral/features/signout/domain/usecases/signout_usecase.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SignOutRepositoryMock extends Mock implements SignOutRepository {}

main() {
  final repository = SignOutRepositoryMock();
  final signOut = SignOutUsecaseImpl(repository: repository);

  test('Deve Retornar um SignOutStatus', () async {
    when(repository.signOut()).thenAnswer(
        (_) => Future.value(SignOutStatus.success..successSet = true));

    final result = await signOut();
    expect(result, isA<SignOutStatus>());
  });

  test('Deve Retornar um SignOutStatus.success com valor true', () async {
    when(repository.signOut()).thenAnswer(
        (_) => Future.value(SignOutStatus.success..successSet = true));

    final result = await signOut();
    expect(result.successGet, isA<bool>());
  });

  test('Deve Retornar um ErroInesperado - Erro ao fazer o SignOut', () async {
    when(repository.signOut()).thenAnswer(
        (_) => Future.value(SignOutStatus.success..successSet = false));

    final result = await signOut();
    expect(result.errorGet, isA<ErroInesperado>());
  });

  test('Deve Retornar um ErroInesperado - Erro ao fazer o SignOut', () async {
    when(repository.signOut())
        .thenAnswer((_) => Future.value(SignOutStatus.error..errorSet = false));

    final result = await signOut();
    expect(result.errorGet, isA<ErroInesperado>());
  });

  test('Deve Retornar um ErroInesperado - Erro ao fazer o SignOut', () async {
    when(repository.signOut()).thenThrow(Exception());

    final result = await signOut();
    expect(result.errorGet, isA<ErroInesperado>());
  });
}
