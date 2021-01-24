import 'package:corelojaapp/app/settings/auth/auth_features/recuperar_senha_email/infra/datasources/recuperar_senha_email_datasource.dart';
import 'package:corelojaapp/app/settings/auth/auth_features/recuperar_senha_email/infra/repositories_impl/recuperar_senha_email_repository_impl.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:corelojaapp/app/shared/utilitario/resultado_sucesso_ou_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RecuperarSenhaEmailDatasourceMock extends Mock
    implements RecuperarSenhaEmailDatasource {}

main() {
  final datasource = RecuperarSenhaEmailDatasourceMock();
  final repository = RecuperarSenhaEmailRepositoryImpl(datasource: datasource);

  test('Deve retornar um RetornoSucessoOuErro', () async {
    when(datasource.recuperarSenhaEmailFirebase(email: null))
        .thenAnswer((_) => Future.value(true));

    final result = await repository.recuperarSenhaEmail(email: null);
    print(
      "teste result tipo => $result",
    );
    print(
        "teste result => ${result.fold(sucesso: (value) => value.result, error: (value) => value.error)}");
    expect(result, isA<RetornoSucessoOuErro>());
  });

  test('Deve retornar um RetornoSucessoOuErro successo com valor true',
      () async {
    when(datasource.recuperarSenhaEmailFirebase(email: null))
        .thenAnswer((_) => Future.value(true));

    final result = await repository.recuperarSenhaEmail(email: null);
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
    when(datasource.recuperarSenhaEmailFirebase(email: null))
        .thenAnswer((_) => Future.value(false));

    final result = await repository.recuperarSenhaEmail(email: null);
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

  test('Deve retornar um Erro ao RecuperarSenhaEmail Cod.02-1', () async {
    when(datasource.recuperarSenhaEmailFirebase(email: null))
        .thenThrow(Exception());

    final result = await repository.recuperarSenhaEmail(email: null);
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
