import 'package:carregar_empresa_package/carregar_empresa_package.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseEmpresaDatasourceMock extends Mock
    implements Datasource<Stream<ResultadoEmpresa>, NoParams> {}

void main() {
  final datasource = FirebaseEmpresaDatasourceMock();

  test('Deve retornar um sucesso com true', () async {
    final testeFire = BehaviorSubject<ResultadoEmpresa>();
    testeFire.add(
      ResultadoEmpresa(
        nome: "VorFast",
        logo260x200: "logo",
        licenca: true,
      ),
    );
    when(datasource).calls(#call).thenAnswer((_) => Future.value(testeFire));
    final result = await CarregarEmpresaPresenter(
            datasource: datasource, mostrarTempoExecucao: true)
        .carregarEmpresa();
    print("teste result - ${await result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ).first}");
    expect(result, isA<SucessoRetorno<Stream<ResultadoEmpresa>>>());
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ),
        isA<Stream<ResultadoEmpresa>>());
    testeFire.close();
  });

  test('Deve ErroCarregarTemas com Erro ao carregar os dados tema Cod.02-1',
      () async {
    when(datasource).calls(#call).thenThrow(Exception());
    final result = await CarregarEmpresaPresenter(
            datasource: datasource, mostrarTempoExecucao: true)
        .carregarEmpresa();
    print("teste result - ${await result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<ErroRetorno<Stream<ResultadoEmpresa>>>());
  });
}
