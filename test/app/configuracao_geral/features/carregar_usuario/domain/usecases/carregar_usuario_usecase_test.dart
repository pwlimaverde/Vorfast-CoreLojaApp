import 'package:corelojaapp/app/configuracao_geral/features/carregar_usuario/domain/entities/resultado_usuario.dart';
import 'package:corelojaapp/app/configuracao_geral/features/carregar_usuario/domain/repositories/carregar_usuario_repository.dart';
import 'package:corelojaapp/app/configuracao_geral/features/carregar_usuario/domain/status/carregar_usuario_usecase_status.dart';
import 'package:corelojaapp/app/configuracao_geral/features/carregar_usuario/domain/usecases/carregar_usuario_usecase.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class CarregarUsuarioRepositoryMock extends Mock
    implements CarregarUsuarioRepository {}

main() {
  final repository = CarregarUsuarioRepositoryMock();
  final carregarUsuario = CarregarUsuarioUsecaseImpl(repository: repository);

  test('Deve retornar um CarregarUsuarioStatus', () async {
    final testeFire = BehaviorSubject<ResultadoUsuario>();
    testeFire.add(ResultadoUsuario(nome: "paulo", administrador: true));
    when(repository.carregarUsuario()).thenAnswer((_) {
      return Future.value(
          CarregarUsuarioStatus.success..successSet = testeFire);
    });

    final result = await carregarUsuario();
    expect(result, isA<CarregarUsuarioStatus>());
    testeFire.close();
  });

  test(
      'Deve retornar um CarregarUsuarioStatus.success com a Stream de ResultadoUsuario',
      () async {
    final testeFire = BehaviorSubject<ResultadoUsuario>();
    testeFire.add(ResultadoUsuario(nome: "paulo", administrador: true));
    when(repository.carregarUsuario()).thenAnswer((_) {
      return Future.value(
          CarregarUsuarioStatus.success..successSet = testeFire);
    });

    final result = await carregarUsuario();
    expect(result.successGet, isA<Stream<ResultadoUsuario>>());
    testeFire.close();
  });

  test('Deve retornar um CarregarUsuarioStatus.error Stream vazia', () async {
    final testeFire = BehaviorSubject<ResultadoUsuario>();
    testeFire.add(ResultadoUsuario());
    when(repository.carregarUsuario()).thenAnswer((_) {
      return Future.value(
          CarregarUsuarioStatus.success..successSet = testeFire);
    });

    final result = await carregarUsuario();
    expect(result.errorGet, isA<ErroInesperado>());
    testeFire.close();
  });

  test('Deve retornar um CarregarUsuarioStatus.error com um AppError',
      () async {
    when(repository.carregarUsuario()).thenThrow(Exception());

    final result = await carregarUsuario();
    expect(result.errorGet, isA<ErroInesperado>());
  });
}
