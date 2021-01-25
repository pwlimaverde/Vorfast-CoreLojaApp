import 'package:corelojaapp/app/settings/auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';
import 'package:corelojaapp/app/settings/auth/auth_features/carregar_usuario/infra/datasources/carregar_usuario_datasource.dart';
import 'package:corelojaapp/app/settings/auth/auth_features/carregar_usuario/infra/repositories_impl/carregar_usuario_repository_impl.dart';
import 'package:corelojaapp/app/settings/erros/erros.dart';
import 'package:corelojaapp/app/shared/utilitario/resultado_sucesso_ou_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class CarregarUsuarioDatasourceMock extends Mock
    implements CarregarUsuarioDatasource {}

main() {
  final datasource = CarregarUsuarioDatasourceMock();
  final repository = CarregarUsuarioRepositoryImpl(datasource: datasource);

  test('Deve retornar um RetornoSucessoOuErro', () async {
    final testeUsuario = BehaviorSubject<ResultadoUsuario>();
    testeUsuario.add(ResultadoUsuario(id: "teste", nome: "paulo"));
    RetornoSucessoOuErro<Stream<ResultadoUsuario>> testeFire =
        SucessoRetorno(resultado: testeUsuario);

    when(datasource.carregarUsuario())
        .thenAnswer((_) => Future(() => testeFire));

    final result = await repository.carregarUsuario();
    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );
    expect(result, isA<RetornoSucessoOuErro>());
    testeUsuario.close();
  });

  test(
      'Deve retornar um RetornoSucessoOuErro successo com a Stream<ResultadoUsuarioModel>',
      () async {
    final testeUsuario = BehaviorSubject<ResultadoUsuario>();
    testeUsuario.add(ResultadoUsuario(id: "teste", nome: "paulo"));
    RetornoSucessoOuErro<Stream<ResultadoUsuario>> testeFire =
        SucessoRetorno(resultado: testeUsuario);

    when(datasource.carregarUsuario())
        .thenAnswer((_) => Future(() => testeFire));

    final result = await repository.carregarUsuario();
    print(
      "teste result tipo => $result",
    );
    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.error,
        ),
        isA<Stream<ResultadoUsuario>>());
    testeUsuario.close();
  });

  test(
      'Deve retornar um RetornoSucessoOuErro error com um ErroInesperado Cod.02-1',
      () async {
    final testeUsuario = BehaviorSubject<ResultadoUsuario>();
    testeUsuario.add(ResultadoUsuario(id: "teste", nome: "paulo"));
    RetornoSucessoOuErro<Stream<ResultadoUsuario>> testeFire = ErroRetorno(
      erro: ErroInesperado(
        mensagem: " Erro ao carregar os dados do Useario - Cod.02-1",
      ),
    );

    when(datasource.carregarUsuario())
        .thenAnswer((_) => Future(() => testeFire));

    final result = await repository.carregarUsuario();
    print(
      "teste result tipo => $result",
    );
    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.error,
        ),
        isA<ErroInesperado>());
    testeUsuario.close();
  });

  test(
      'Deve retornar um RetornoSucessoOuErro error com um ErroInesperado Cod.02-2',
      () async {
    when(datasource.carregarUsuario()).thenThrow(Exception());

    final result = await repository.carregarUsuario();
    print(
      "teste result tipo => $result",
    );
    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.error,
        ),
        isA<ErroInesperado>());
  });
}
