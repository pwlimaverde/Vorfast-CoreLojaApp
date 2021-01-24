import 'package:corelojaapp/app/settings/configuracao_geral/configuracao_geral_features/checar_coneccao/domain/repositories/checar_coneccao_repository.dart';
import 'package:corelojaapp/app/settings/configuracao_geral/configuracao_geral_presenter/configuracao_geral_presenter.dart';
import 'package:corelojaapp/app/settings/erros/erros.dart';
import 'package:corelojaapp/app/shared/utilitario/resultado_sucesso_ou_error.dart';
import 'package:corelojaapp/app/shared/utilitario/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ChecarConeccaoRepositoryMock extends Mock
    implements ChecarConeccaoRepository {}

main() {
  final repository = ChecarConeccaoRepositoryMock();
  final checarConeccao = ChecarConeccaoUsecase(repository: repository);

  test('Deve Retornar um RetornoSucessoOuErro', () async {
    when(repository.checarConeccao())
        .thenAnswer((_) => Future.value(SucessoRetorno<bool>(result: true)));

    final result = await checarConeccao(NoParams());
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}");
    expect(result, isA<RetornoSucessoOuErro>());
  });

  test('Deve Retornar um RetornoSucessoOuErro Sucesso com valor true',
      () async {
    when(repository.checarConeccao())
        .thenAnswer((_) => Future.value(SucessoRetorno<bool>(result: true)));

    final result = await checarConeccao(NoParams());
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}");
    expect(
        result.fold(
            sucesso: (value) => value.resultado, erro: (value) => value.error),
        isA<bool>());
  });

  test('Deve Retornar um ErrorConeccao - Você está offline', () async {
    when(repository.checarConeccao())
        .thenAnswer((_) => Future.value(SucessoRetorno<bool>(result: false)));

    final result = await checarConeccao(NoParams());
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}");
    expect(
        result.fold(
            sucesso: (value) => value.resultado, erro: (value) => value.error),
        isA<ErrorConeccao>());
  });

  test(
      'Deve Retornar um ErrorConeccao - Erro ao recuperar informação de conexão Cod.01-2',
      () async {
    when(repository.checarConeccao()).thenAnswer((_) => Future.value(
        ErrorRetorno(
            erro: ErrorConeccao(
                mensagem: "Erro ao recuperar informação de conexão"))));

    final result = await checarConeccao(NoParams());
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}");
    expect(
        result.fold(
            sucesso: (value) => value.resultado, erro: (value) => value.error),
        isA<ErrorConeccao>());
  });

  test(
      'Deve Retornar um ErrorConeccao - Erro ao recuperar informação de conexão Cod.01-3',
      () async {
    when(repository.checarConeccao()).thenThrow(Exception());

    final result = await checarConeccao(NoParams());
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}");
    expect(
        result.fold(
            sucesso: (value) => value.resultado, erro: (value) => value.error),
        isA<ErrorConeccao>());
  });
}
