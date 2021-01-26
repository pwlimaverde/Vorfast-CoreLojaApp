import 'package:corelojaapp/app/settings/auth/auth_features/recuperar_senha_email/domain/repositories/recuperar_senha_email_repository.dart';
import 'package:corelojaapp/app/settings/auth/auth_presenter/auth_presenter.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:corelojaapp/app/shared/utilitario/resultado_sucesso_ou_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RecuperarSenhaEmailRepositoryMock extends Mock
    implements RecuperarSenhaEmailRepository {}

main() {
  final repository = RecuperarSenhaEmailRepositoryMock();
  final recuperarSenha = RecuperarSenhaEmailUsecaseImpl(repository: repository);

  test('Deve Retornar um RetornoSucessoOuErro Sucesso com valor true',
      () async {
    when(repository.recuperarSenhaEmail(email: "any"))
        .thenAnswer((_) => Future.value(SucessoRetorno<bool>(resultado: true)));

    final result =
        await recuperarSenha(ParametrosRecuperarSenhaEmail(email: "any"));
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

  test(
      'Deve Retornar um ErroInesperado Erro ao RecuperarSenhaEmail Cod.01-1 false',
      () async {
    when(repository.recuperarSenhaEmail(email: "any")).thenAnswer(
        (_) => Future.value(SucessoRetorno<bool>(resultado: false)));

    final result =
        await recuperarSenha(ParametrosRecuperarSenhaEmail(email: "any"));
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

  test('Deve Retornar um ErroInesperado Erro ao RecuperarSenhaEmail Cod.01-2',
      () async {
    when(repository.recuperarSenhaEmail(email: "any")).thenAnswer((_) =>
        Future.value(ErroRetorno(
            erro: ErrorConeccao(mensagem: "Erro ao RecuperarSenhaEmail"))));

    final result =
        await recuperarSenha(ParametrosRecuperarSenhaEmail(email: "any"));
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

  test('Deve Retornar um ErroInesperado Erro ao RecuperarSenhaEmail Cod.01-3',
      () async {
    when(repository.recuperarSenhaEmail(email: "any")).thenThrow(Exception());

    final result =
        await recuperarSenha(ParametrosRecuperarSenhaEmail(email: "any"));
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
