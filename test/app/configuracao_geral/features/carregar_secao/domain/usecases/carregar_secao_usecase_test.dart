import 'package:corelojaapp/app/configuracao_geral/features/carregar_secao/domain/entities/resultado_secao.dart';
import 'package:corelojaapp/app/configuracao_geral/features/carregar_secao/domain/repositories/carregar_secao_repository.dart';
import 'package:corelojaapp/app/configuracao_geral/features/carregar_secao/domain/status/carregar_secao_usecase_status.dart';
import 'package:corelojaapp/app/configuracao_geral/features/carregar_secao/domain/usecases/carregar_secao_usecase.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class CarregarSecaoRepositoryMock extends Mock
    implements CarregarSecaoRepository {}

main() {
  final repository = CarregarSecaoRepositoryMock();
  final carregarSecao = CarregarSecaoUsecaseImpl(repository: repository);

  test('Deve retornar um CarregarSecaoStatus', () async {
    final testeFire = BehaviorSubject<List<ResultadoSecao>>();
    testeFire.add([
      ResultadoSecao(cor: {"r": 58}, nome: "novidades"),
      ResultadoSecao(cor: {"r": 58}, nome: "promoção"),
    ]);
    when(repository.carregarSecao()).thenAnswer((_) {
      return Future.value(CarregarSecaoStatus.success..successSet = testeFire);
    });

    final result = await carregarSecao();
    expect(result, isA<CarregarSecaoStatus>());
    testeFire.close();
  });

  test(
      'Deve retornar um CarregarSecaoStatus.success com a Stream de ResultadoSecao',
      () async {
    final testeFire = BehaviorSubject<List<ResultadoSecao>>();
    testeFire.add([
      ResultadoSecao(cor: {"r": 58}, nome: "novidades"),
      ResultadoSecao(cor: {"r": 58}, nome: "promoção"),
    ]);
    when(repository.carregarSecao()).thenAnswer((_) {
      return Future.value(CarregarSecaoStatus.success..successSet = testeFire);
    });

    final result = await carregarSecao();
    expect(result.successGet, isA<Stream<List<ResultadoSecao>>>());
    testeFire.close();
  });

  test('Deve retornar um CarregarSecaoStatus.error Stream vazia', () async {
    final testeFire = BehaviorSubject<ResultadoSecao>();
    testeFire.add(ResultadoSecao());
    when(repository.carregarSecao()).thenAnswer((_) {
      return Future.value(CarregarSecaoStatus.success..successSet = testeFire);
    });

    final result = await carregarSecao();
    expect(result.errorGet, isA<ErroInesperado>());
    testeFire.close();
  });

  test('Deve retornar um CarregarSecaoStatus.error com um AppError', () async {
    when(repository.carregarSecao()).thenThrow(Exception());

    final result = await carregarSecao();
    expect(result.errorGet, isA<ErroInesperado>());
  });
}
