import 'package:carregar_temas_package/carregar_temas_package.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:rxdart/rxdart.dart';

class FairebaseTemaDatasourceMock extends Mock
    implements Datasource<Stream<ResultadoTheme>, NoParams> {}

void main() {
  final datasource = FairebaseTemaDatasourceMock();

  test('Deve retornar um sucesso com true', () async {
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
    expect(result, isA<SucessoRetorno<Stream<ResultadoTheme>>>());
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ),
        isA<Stream<ResultadoTheme>>());
    testeFire.close();
  });

  test('Deve ErroCarregarTemas com Erro ao carregar os dados tema Cod.02-1',
      () async {
    when(datasource).calls(#call).thenThrow(Exception());
    final result = await CarregarTemasPresenter(
            datasource: datasource, mostrarTempoExecucao: true)
        .carregarTemas();
    print("teste result - ${await result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<ErroRetorno<Stream<ResultadoTheme>>>());
  });
}
