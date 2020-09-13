import 'package:corelojaapp/app/configuracao_geral/features/carregar_usuario/domain/entities/resultado_usuario.dart';
import 'package:corelojaapp/app/configuracao_geral/features/carregar_usuario/domain/status/carregar_usuario_usecase_status.dart';
import 'package:corelojaapp/app/configuracao_geral/features/carregar_usuario/infra/datasources/carregar_usuario_datasource.dart';
import 'package:corelojaapp/app/configuracao_geral/features/carregar_usuario/infra/repositories_impl/carregar_usuario_repository_impl.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class CarregarUsuarioDatasourceMock extends Mock
    implements CarregarUsuarioDatasource {}

main() {
  final datasource = CarregarUsuarioDatasourceMock();
  final repository = CarregarUsuarioRepositoryImpl(datasource: datasource);

  test('Deve retornar um CarregarUsuarioStatus', () {
    final testeFire = BehaviorSubject<ResultadoUsuario>();
    testeFire.add(ResultadoUsuario(id: "teste", nome: "paulo"));

    when(datasource.carregarUsuario())
        .thenAnswer((_) => Future(() => testeFire));

    final result = repository.carregarUsuario();
    expect(result, isA<Future<CarregarUsuarioStatus>>());
    testeFire.close();
  });

  test(
      'Deve retornar um CarregarUsuarioStatus.success com a Stream<ResultadoUsuarioModel>',
      () async {
    final testeFire = BehaviorSubject<ResultadoUsuario>();
    testeFire.add(ResultadoUsuario(id: "teste", nome: "paulo"));

    when(datasource.carregarUsuario())
        .thenAnswer((_) => Future(() => testeFire));

    final result = await repository.carregarUsuario();
    expect(result.successGet, isA<Stream<ResultadoUsuario>>());
    testeFire.close();
  });

  test('Deve retornar um CarregarUsuarioStatus.error com um ErroInesperado',
      () async {
    final testeFire = BehaviorSubject<ResultadoUsuario>();
    testeFire.add(ResultadoUsuario(id: "teste", nome: "paulo"));

    when(datasource.carregarUsuario()).thenThrow(Exception());

    final result = await repository.carregarUsuario();
    expect(result.errorGet, isA<ErroInesperado>());
    testeFire.close();
  });
}
