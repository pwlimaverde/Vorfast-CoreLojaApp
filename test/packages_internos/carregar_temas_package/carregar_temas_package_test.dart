import 'package:carregar_temas_package/carregar_temas_package.dart';
import 'package:corelojaapp/app/shared/utilitario/tempo_execucao.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:rxdart/rxdart.dart';

class FairebaseThemeDatasourceMock extends Mock
    implements Datasource<Stream<ResultadoTheme>, NoParams> {}

void main() {
  final datasource = FairebaseThemeDatasourceMock();
  final tempo = TempoExecucao();

  test('Deve retornar um sucesso com true', () async {
    tempo.iniciar();
    final testeFire = BehaviorSubject<ResultadoTheme>();
    testeFire.add(
      ResultadoTheme(
        accent: {"r": 58},
        primary: {"r": 150},
        user: "paulo",
      ),
    );
    when(datasource).calls(#call).thenAnswer((_) => Future.value(testeFire));
    final result = await CarregarTemasPresenter(
            datasource: datasource, mostrarTempoExecucao: true)
        .carregarTemas();
    print("teste result - ${await result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ).first}");
    tempo.terminar();
    expect(result, isA<SucessoRetorno<Stream<ResultadoTheme>>>());
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ),
        isA<Stream<ResultadoTheme>>());
    testeFire.close();
  });

  test('Deve ErrorCarregarTemas com Erro ao carregar os dados tema Cod.02-1',
      () async {
    tempo.iniciar();
    when(datasource).calls(#call).thenThrow(Exception());
    final result = await CarregarTemasPresenter(
            datasource: datasource, mostrarTempoExecucao: true)
        .carregarTemas();
    print("teste result - ${await result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    tempo.terminar();
    expect(result, isA<ErroRetorno<Stream<ResultadoTheme>>>());
  });
}
