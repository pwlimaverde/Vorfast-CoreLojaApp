import 'package:corelojaapp/app/settings/auth/auth_features/signout/domain/repositories/signout_repository.dart';
import 'package:corelojaapp/app/settings/auth/auth_presenter/auth_presenter.dart';
import 'package:corelojaapp/app/settings/erros/erros.dart';
import 'package:corelojaapp/app/shared/utilitario/resultado_sucesso_ou_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SignOutRepositoryMock extends Mock implements SignOutRepository {}

main() {
  final repository = SignOutRepositoryMock();
  final recuperarSenha = SignOutUsecaseImpl(repository: repository);

  test('Deve Retornar um RetornoSucessoOuErro', () async {
    when(repository.signOut())
        .thenAnswer((_) => Future.value(SucessoRetorno<bool>(resultado: true)));

    final result = await recuperarSenha();
    print(
      "teste result tipo => $result",
    );
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}");
    expect(result, isA<RetornoSucessoOuErro>());
  });

  test('Deve Retornar um RetornoSucessoOuErro Sucesso com valor true',
      () async {
    when(repository.signOut())
        .thenAnswer((_) => Future.value(SucessoRetorno<bool>(resultado: true)));

    final result = await recuperarSenha();
    print(
      "teste result tipo => $result",
    );
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}");
    expect(
        result.fold(
            sucesso: (value) => value.resultado, erro: (value) => value.error),
        isA<bool>());
  });

  test('Deve Retornar um ErroInesperado Erro ao SignOut Cod.01-1 false',
      () async {
    when(repository.signOut()).thenAnswer(
        (_) => Future.value(SucessoRetorno<bool>(resultado: false)));

    final result = await recuperarSenha();
    print(
      "teste result tipo => $result",
    );
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}");
    expect(
        result.fold(
            sucesso: (value) => value.resultado, erro: (value) => value.error),
        isA<ErroInesperado>());
  });

  test('Deve Retornar um ErroInesperado Erro ao SignOut Cod.01-2', () async {
    when(repository.signOut()).thenAnswer((_) => Future.value(
        ErroRetorno(erro: ErrorConeccao(mensagem: "Erro ao SignOut"))));

    final result = await recuperarSenha();
    print(
      "teste result tipo => $result",
    );
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}");
    expect(
        result.fold(
            sucesso: (value) => value.resultado, erro: (value) => value.error),
        isA<ErroInesperado>());
  });

  test('Deve Retornar um ErroInesperado Erro ao SignOut Cod.01-3', () async {
    when(repository.signOut()).thenThrow(Exception());

    final result = await recuperarSenha();
    print(
      "teste result tipo => $result",
    );
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}");
    expect(
        result.fold(
            sucesso: (value) => value.resultado, erro: (value) => value.error),
        isA<ErroInesperado>());
  });
}
