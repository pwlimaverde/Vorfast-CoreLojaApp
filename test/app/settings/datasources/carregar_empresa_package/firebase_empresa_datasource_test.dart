import 'package:carregar_empresa_package/carregar_empresa_package.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:corelojaapp/app/settings/datasources/carregar_empresa_package/firebase_empresa_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

void main() async {
  final instance = MockFirestoreInstance();
  await instance.collection("empresa").doc("dados").update({
    'nome': "VorFast",
    'logo260x200': "logo",
    'licenca': true,
  });
  final carregarTemasPresenter = CarregarEmpresaPresenter(
    mostrarTempoExecucao: true,
    datasource: FirebaseEmpresaDatasourse(firestore: instance),
  );

  test('Deve retornar um sucesso com Stream<ResultadoEmpresa>', () async {
    final result = await carregarTemasPresenter.carregarEmpresa();
    if (result is SucessoRetorno<Stream<ResultadoEmpresa>>) {
      print("teste result - ${await result.fold(
            sucesso: (value) => value.resultado,
            erro: (value) => value.erro,
          ).first}");
    } else {
      print("teste result - ${await result.fold(
        sucesso: (value) => value.resultado,
        erro: (value) => value.erro,
      )}");
    }
    expect(result, isA<SucessoRetorno<Stream<ResultadoEmpresa>>>());
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ),
        isA<Stream<ResultadoEmpresa>>());
  });

  test('Deve ErrorCarregarTemas com Erro ao carregar os dados tema Cod.02-1',
      () async {
    await instance.collection("empresa").doc("dados").update({
      'licenca': false,
    });
    final result = await carregarTemasPresenter.carregarEmpresa();
    if (result is SucessoRetorno<Stream<ResultadoEmpresa>>) {
      print("teste result - ${await result.fold(
            sucesso: (value) => value.resultado,
            erro: (value) => value.erro,
          ).first}");
    } else {
      print("teste result - ${await result.fold(
        sucesso: (value) => value.resultado,
        erro: (value) => value.erro,
      )}");
    }
    expect(result, isA<ErroRetorno<Stream<ResultadoEmpresa>>>());
  });
}
