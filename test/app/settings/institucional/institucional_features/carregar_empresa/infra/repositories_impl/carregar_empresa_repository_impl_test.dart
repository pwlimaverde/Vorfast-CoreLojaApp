import 'package:corelojaapp/app/settings/institucional/institucional_features/carregar_empresa/domain/entities/resultado_empresa.dart';
import 'package:corelojaapp/app/settings/institucional/institucional_features/carregar_empresa/infra/datasources/carregar_empresa_datasource.dart';
import 'package:corelojaapp/app/settings/institucional/institucional_features/carregar_empresa/infra/repositories_impl/carregar_empresa_repository_impl.dart';
import 'package:corelojaapp/app/settings/erros/erros.dart';
import 'package:corelojaapp/app/shared/utilitario/resultado_sucesso_ou_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class CarregarEmpresaDatasourceMock extends Mock
    implements CarregarEmpresaDatasource {}

main() {
  final datasource = CarregarEmpresaDatasourceMock();
  final repository = CarregarEmpresaRepositoryImpl(datasource: datasource);

  test('Deve retornar um RetornoSucessoOuErro', () async {
    final testeEmpresa = BehaviorSubject<ResultadoEmpresa>();
    testeEmpresa.add(ResultadoEmpresa(nome: "vorfast", licenca: true));
    RetornoSucessoOuErro<Stream<ResultadoEmpresa>> testeFire =
        SucessoRetorno(resultado: testeEmpresa);

    when(datasource.carregarEmpresa())
        .thenAnswer((_) => Future(() => testeFire));

    final result = await repository.carregarEmpresa();
    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );
    expect(result, isA<RetornoSucessoOuErro>());
    testeEmpresa.close();
  });

  test(
      'Deve retornar um RetornoSucessoOuErro successo com a Stream<ResultadoEmpresa>',
      () async {
    final testeEmpresa = BehaviorSubject<ResultadoEmpresa>();
    testeEmpresa.add(ResultadoEmpresa(nome: "vorfast", licenca: true));
    RetornoSucessoOuErro<Stream<ResultadoEmpresa>> testeFire =
        SucessoRetorno(resultado: testeEmpresa);

    when(datasource.carregarEmpresa())
        .thenAnswer((_) => Future(() => testeFire));

    final result = await repository.carregarEmpresa();
    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.error,
        ),
        isA<Stream<ResultadoEmpresa>>());
    testeEmpresa.close();
  });

  test(
      'Deve retornar um RetornoSucessoOuErro error com um ErroInesperado Cod.02-1',
      () async {
    final testeEmpresa = BehaviorSubject<ResultadoEmpresa>();
    testeEmpresa.add(ResultadoEmpresa(nome: "vorfast", licenca: true));
    RetornoSucessoOuErro<Stream<ResultadoEmpresa>> testeFire = ErroRetorno(
      erro: ErroInesperado(
        mensagem: " Erro ao carregar os dados da Empresa - Cod.02-1",
      ),
    );

    when(datasource.carregarEmpresa())
        .thenAnswer((_) => Future(() => testeFire));

    final result = await repository.carregarEmpresa();
    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );
    expect(
      result.fold(
        sucesso: (value) => value.resultado,
        erro: (value) => value.error,
      ),
      isA<ErroInesperado>(),
    );
    testeEmpresa.close();
  });

  test(
      'Deve retornar um RetornoSucessoOuErro error com um ErroInesperado Cod.02-2',
      () async {
    when(datasource.carregarEmpresa()).thenThrow(Exception());

    final result = await repository.carregarEmpresa();
    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );
    expect(
      result.fold(
        sucesso: (value) => value.resultado,
        erro: (value) => value.error,
      ),
      isA<ErroInesperado>(),
    );
  });
}
