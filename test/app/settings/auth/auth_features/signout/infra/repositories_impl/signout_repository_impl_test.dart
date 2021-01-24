import 'package:corelojaapp/app/settings/auth/auth_features/signout/infra/datasources/signout_datasource.dart';
import 'package:corelojaapp/app/settings/auth/auth_features/signout/infra/repositories_impl/signout_repository_impl.dart';
import 'package:corelojaapp/app/settings/erros/erros.dart';
import 'package:corelojaapp/app/shared/utilitario/resultado_sucesso_ou_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SignOutDatasourceMock extends Mock implements SignOutDatasource {}

main() {
  final datasource = SignOutDatasourceMock();
  final repository = SignOutRepositoryImpl(datasource: datasource);

  test('Deve retornar um RetornoSucessoOuErro', () async {
    when(datasource.signOutFirebase()).thenAnswer((_) => Future.value(true));

    final result = await repository.signOut();
    print(
      "teste result tipo => $result",
    );
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}");
    expect(result, isA<RetornoSucessoOuErro>());
  });

  test('Deve retornar um RetornoSucessoOuErro successo com valor true',
      () async {
    when(datasource.signOutFirebase()).thenAnswer((_) => Future.value(true));

    final result = await repository.signOut();
    print(
      "teste result tipo => $result",
    );
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}");
    expect(
      result.fold(
        sucesso: (value) => value.resultado,
        erro: (value) => value.error,
      ),
      true,
    );
  });

  test('Deve retornar um RetornoSucessoOuErro successo com valor false',
      () async {
    when(datasource.signOutFirebase()).thenAnswer((_) => Future.value(false));

    final result = await repository.signOut();
    print(
      "teste result tipo => $result",
    );
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}");
    expect(
      result.fold(
        sucesso: (value) => value.resultado,
        erro: (value) => value.error,
      ),
      false,
    );
  });

  test('Deve retornar um Erro ao SignOut Cod.02-1', () async {
    when(datasource.signOutFirebase()).thenThrow(Exception());

    final result = await repository.signOut();
    print(
      "teste result tipo => $result",
    );
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}");
    expect(
      result.fold(
        sucesso: (value) => value.resultado,
        erro: (value) => value.error,
      ),
      isA<ErroInesperado>(),
    );
  });
}
