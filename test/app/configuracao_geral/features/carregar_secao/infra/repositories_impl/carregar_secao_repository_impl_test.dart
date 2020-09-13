import 'package:corelojaapp/app/configuracao_geral/features/carregar_secao/domain/entities/resultado_secao.dart';
import 'package:corelojaapp/app/configuracao_geral/features/carregar_secao/domain/status/carregar_secao_usecase_status.dart';
import 'package:corelojaapp/app/configuracao_geral/features/carregar_secao/infra/datasources/carregar_secao_datasource.dart';
import 'package:corelojaapp/app/configuracao_geral/features/carregar_secao/infra/repositories_impl/carregar_secao_repository_impl.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class CarregarSecaoDatasourceMock extends Mock
    implements CarregarSecaoDatasource {}

main() {
  final datasource = CarregarSecaoDatasourceMock();
  final repository = CarregarSecaoRepositoryImpl(datasource: datasource);

  test('Deve retornar um CarregarSecaoStatus', () {
    final testeFire = BehaviorSubject<List<ResultadoSecao>>();
    testeFire.add([
      ResultadoSecao(cor: {"r": 58}, nome: "novidades"),
      ResultadoSecao(cor: {"r": 58}, nome: "promoção"),
    ]);

    when(datasource.getSecao()).thenAnswer((_) => testeFire);

    final result = repository.carregarSecao();
    expect(result, isA<Future<CarregarSecaoStatus>>());
    testeFire.close();
  });

  test(
      'Deve retornar um CarregarSecaoStatus.success com a Stream<ResultadoSecaoModel>',
      () async {
    final testeFire = BehaviorSubject<List<ResultadoSecao>>();
    testeFire.add([
      ResultadoSecao(cor: {"r": 58}, nome: "novidades"),
      ResultadoSecao(cor: {"r": 58}, nome: "promoção"),
    ]);

    when(datasource.getSecao()).thenAnswer((_) => testeFire);

    final result = await repository.carregarSecao();
    expect(result.successGet, isA<Stream<List<ResultadoSecao>>>());
    testeFire.close();
  });

  test('Deve retornar um CarregarSecaoStatus.error com um ErroInesperado',
      () async {
    final testeFire = BehaviorSubject<ResultadoSecao>();

    when(datasource.getSecao()).thenThrow(Exception());

    final result = await repository.carregarSecao();
    expect(result.errorGet, isA<ErroInesperado>());
    testeFire.close();
  });
}
