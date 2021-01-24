import 'package:corelojaapp/app/settings/institucional/institucional_features/carregar_empresa/domain/entities/resultado_empresa.dart';
import 'package:corelojaapp/app/settings/institucional/institucional_features/carregar_empresa/domain/repositories/carregar_empresa_repository.dart';
import 'package:corelojaapp/app/settings/institucional/institucional_presenter/institucional_presenter.dart';
import 'package:corelojaapp/app/settings/erros/erros.dart';
import 'package:corelojaapp/app/shared/utilitario/resultado_sucesso_ou_error.dart';
import 'package:corelojaapp/app/shared/utilitario/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class CarregarEmpresaRepositoryMock extends Mock
    implements CarregarEmpresaRepository {}

main() {
  final repository = CarregarEmpresaRepositoryMock();
  final carregarEmpresa = CarregarEmpresaUsecase(repository: repository);

  test('Deve retornar um RetornoSucessoOuErro', () async {
    final testeFire = BehaviorSubject<ResultadoEmpresa>();
    testeFire.add(ResultadoEmpresa(nome: "vorfast", licenca: true));
    when(repository.carregarEmpresa()).thenAnswer((_) {
      return Future.value(
        SucessoRetorno(
          result: testeFire,
        ),
      );
    });

    final result = await carregarEmpresa(NoParams());
    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );
    expect(result, isA<RetornoSucessoOuErro>());
    testeFire.close();
  });

  test(
      'Deve retornar um RetornoSucessoOuErro successo com a Stream de ResultadoEmpresa',
      () async {
    final testeFire = BehaviorSubject<ResultadoEmpresa>();
    testeFire.add(ResultadoEmpresa(nome: "vorfast", licenca: true));
    when(repository.carregarEmpresa()).thenAnswer((_) {
      return Future.value(
        SucessoRetorno<Stream<ResultadoEmpresa>>(
          result: testeFire,
        ),
      );
    });

    final result = await carregarEmpresa(NoParams());
    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.error,
        ),
        isA<Stream<ResultadoEmpresa>>());
    testeFire.close();
  });

  test('Deve retornar um RetornoSucessoOuErro error com um AppError Cod.01-1',
      () async {
    final testeFire = BehaviorSubject<ResultadoEmpresa>();
    testeFire.add(ResultadoEmpresa(nome: "vorfast", licenca: true));
    when(repository.carregarEmpresa()).thenAnswer((_) {
      return Future.value(
        ErrorRetorno(
          erro: ErroInesperado(
            mensagem: "Erro ao carregar os dados da Empresa Cod.01-1",
          ),
        ),
      );
    });

    final result = await carregarEmpresa(NoParams());
    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.error,
        ),
        isA<ErroInesperado>());
    testeFire.close();
  });

  test('Deve retornar um RetornoSucessoOuErro error com um AppError Cod.01-2',
      () async {
    final testeFire = BehaviorSubject<ResultadoEmpresa>();
    testeFire.add(ResultadoEmpresa(nome: "vorfast", licenca: true));
    when(repository.carregarEmpresa()).thenThrow(Exception());

    final result = await carregarEmpresa(NoParams());
    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.error,
        ),
        isA<ErroInesperado>());
    testeFire.close();
  });
}
