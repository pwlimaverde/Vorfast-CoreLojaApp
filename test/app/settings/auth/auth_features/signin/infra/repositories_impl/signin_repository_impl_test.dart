import 'package:corelojaapp/app/settings/auth/auth_features/signin/infra/datasources/signin_datasource.dart';
import 'package:corelojaapp/app/settings/auth/auth_features/signin/infra/repositories_impl/signin_repository_impl.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:corelojaapp/app/shared/utilitario/resultado_sucesso_ou_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SignInDatasourceMock extends Mock implements SignInDatasource {}

main() {
  final datasource = SignInDatasourceMock();
  final repository = SignInRepositoryImpl(datasource: datasource);

  test('Deve retornar um RetornoSucessoOuErro', () async {
    when(datasource()).thenAnswer((_) => Future.value(true));

    final result = await repository.signIn();
    print(
      "teste result tipo => $result",
    );
    print(
        "teste result => ${result.fold(sucesso: (value) => value.result, error: (value) => value.error)}");
    expect(result, isA<RetornoSucessoOuErro>());
  });

  test('Deve retornar um RetornoSucessoOuErro successo com valor true',
      () async {
    when(datasource()).thenAnswer((_) => Future.value(true));

    final result = await repository.signIn();
    print(
      "teste result tipo => $result",
    );
    print(
        "teste result => ${result.fold(sucesso: (value) => value.result, error: (value) => value.error)}");
    expect(
      result.fold(
        sucesso: (value) => value.result,
        error: (value) => value.error,
      ),
      true,
    );
  });

  test('Deve retornar um RetornoSucessoOuErro successo com valor false',
      () async {
    when(datasource()).thenAnswer((_) => Future.value(false));

    final result = await repository.signIn();
    print(
      "teste result tipo => $result",
    );
    print(
        "teste result => ${result.fold(sucesso: (value) => value.result, error: (value) => value.error)}");
    expect(
      result.fold(
        sucesso: (value) => value.result,
        error: (value) => value.error,
      ),
      false,
    );
  });

  test('Deve retornar um Erro ao SignIn Cod.02-1', () async {
    when(datasource()).thenThrow(Exception());

    final result = await repository.signIn();
    print(
      "teste result tipo => $result",
    );
    print(
        "teste result => ${result.fold(sucesso: (value) => value.result, error: (value) => value.error)}");
    expect(
      result.fold(
        sucesso: (value) => value.result,
        error: (value) => value.error,
      ),
      isA<ErroInesperado>(),
    );
  });
}
