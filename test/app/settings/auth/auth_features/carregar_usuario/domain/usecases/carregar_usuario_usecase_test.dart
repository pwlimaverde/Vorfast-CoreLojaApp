import 'package:corelojaapp/app/settings/auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';
import 'package:corelojaapp/app/settings/auth/auth_features/carregar_usuario/domain/repositories/carregar_usuario_repository.dart';
import 'package:corelojaapp/app/settings/auth/auth_presenter/auth_presenter.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:corelojaapp/app/shared/utilitario/resultado_sucesso_ou_error.dart';
import 'package:corelojaapp/app/shared/utilitario/usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class CarregarUsuarioRepositoryMock extends Mock
    implements CarregarUsuarioRepository {}

main() {
  final repository = CarregarUsuarioRepositoryMock();
  final carregarUsuario = CarregarUsuarioUsecase(repository: repository);

  test('Deve retornar um RetornoSucessoOuErro', () async {
    final testeFire = BehaviorSubject<ResultadoUsuario>();
    testeFire.add(ResultadoUsuario(nome: "paulo", administrador: true));
    when(repository.carregarUsuario()).thenAnswer((_) {
      return Future.value(
        SucessoResultado<Stream<ResultadoUsuario>>(
          result: testeFire,
        ),
      );
    });

    final result = await carregarUsuario(NoParams());
    print(
      "teste result tipo => $result",
    );
    print(
      "teste result => ${result.fold(sucesso: (value) => value.result, error: (value) => value.error)}",
    );
    expect(result, isA<RetornoSucessoOuErro>());
    testeFire.close();
  });

  test(
      'Deve retornar um RetornoSucessoOuErro successo com a Stream de ResultadoUsuario',
      () async {
    final testeFire = BehaviorSubject<ResultadoUsuario>();
    testeFire.add(ResultadoUsuario(nome: "paulo", administrador: true));
    when(repository.carregarUsuario()).thenAnswer((_) {
      return Future.value(
        SucessoResultado<Stream<ResultadoUsuario>>(
          result: testeFire,
        ),
      );
    });

    final result = await carregarUsuario(NoParams());
    print(
      "teste result tipo => $result",
    );
    print(
      "teste result => ${result.fold(sucesso: (value) => value.result, error: (value) => value.error)}",
    );
    expect(
        result.fold(
          sucesso: (value) => value.result,
          error: (value) => value.error,
        ),
        isA<Stream<ResultadoUsuario>>());
    testeFire.close();
  });

  test('Deve retornar um RetornoSucessoOuErro error com um AppError Cod.01-1',
      () async {
    final testeFire = BehaviorSubject<ResultadoUsuario>();
    testeFire.add(ResultadoUsuario());
    when(repository.carregarUsuario()).thenAnswer((_) {
      return Future.value(
        ErrorResultado(
          error: ErroInesperado(
            mensagem: "Erro ao carregar os dados do usuario",
          ),
        ),
      );
    });

    final result = await carregarUsuario(NoParams());
    print(
      "teste result tipo => $result",
    );
    print(
      "teste result => ${result.fold(sucesso: (value) => value.result, error: (value) => value.error)}",
    );
    expect(
        result.fold(
          sucesso: (value) => value.result,
          error: (value) => value.error,
        ),
        isA<ErroInesperado>());
    testeFire.close();
  });

  test('Deve retornar um RetornoSucessoOuErro error com um AppError Cod.01-2',
      () async {
    when(repository.carregarUsuario()).thenThrow(Exception());

    final result = await carregarUsuario(NoParams());
    print(
      "teste result tipo => $result",
    );
    print(
      "teste result => ${result.fold(sucesso: (value) => value.result, error: (value) => value.error)}",
    );
    expect(
        result.fold(
          sucesso: (value) => value.result,
          error: (value) => value.error,
        ),
        isA<ErroInesperado>());
  });
}
