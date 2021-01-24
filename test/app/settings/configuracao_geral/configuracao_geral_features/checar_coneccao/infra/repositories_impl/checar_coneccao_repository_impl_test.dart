import 'package:corelojaapp/app/settings/configuracao_geral/configuracao_geral_features/checar_coneccao/infra/datasources/checar_coneccao_datasource.dart';
import 'package:corelojaapp/app/settings/configuracao_geral/configuracao_geral_features/checar_coneccao/infra/repositories_impl/checar_coneccao_repository_impl.dart';
import 'package:corelojaapp/app/settings/erros/erros.dart';
import 'package:corelojaapp/app/shared/utilitario/resultado_sucesso_ou_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ChecarConeccaoDatasourceMock extends Mock
    implements ChecarConeccaoDatasource {}

main() {
  final datasource = ChecarConeccaoDatasourceMock();
  final repository = ChecarConeccaoRepositoryImpl(datasource: datasource);

  test('Deve retornar um RetornoSucessoOuErro', () async {
    when(datasource.isOnline).thenAnswer((_) => Future.value(true));

    final result = await repository.checarConeccao();
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}");
    expect(result, isA<RetornoSucessoOuErro>());
  });

  test('Deve retornar um RetornoSucessoOuErro success com valor true',
      () async {
    when(datasource.isOnline).thenAnswer((_) => Future.value(true));

    final result = await repository.checarConeccao();
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

  test('Deve retornar um RetornoSucessoOuErro success com valor false',
      () async {
    when(datasource.isOnline).thenAnswer((_) => Future.value(false));

    final result = await repository.checarConeccao();
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}");
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.error,
        ),
        false);
  });

  test('Deve retornar um RetornoSucessoOuErro error com valor ErrorConeccao',
      () async {
    when(datasource.isOnline).thenThrow(Exception());

    final result = await repository.checarConeccao();
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}");
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.error,
        ),
        isA<ErrorConeccao>());
  });
}
