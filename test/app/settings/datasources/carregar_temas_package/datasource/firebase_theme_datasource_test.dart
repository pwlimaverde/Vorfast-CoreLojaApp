import 'package:carregar_temas_package/carregar_temas_package.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:corelojaapp/app/settings/datasources/carregar_temas_package/datasource/firebase_theme_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

void main() async {
  final instance = MockFirestoreInstance();
  await instance.collection('settingstheme').doc("theme").update({
    'user': "Paulo",
    'primary': {
      "r": 58,
      "g": 58,
      "b": 58,
    },
    'accent': {
      "r": 90,
      "g": 90,
      "b": 90,
    },
  });
  final carregarTemasPresenter = CarregarTemasPresenter(
    mostrarTempoExecucao: true,
    datasource: FairebaseThemeDatasource(firestore: instance),
  );

  test('Deve retornar um sucesso com Stream<FirebaseResultadoThemeModel>',
      () async {
    final result = await carregarTemasPresenter.carregarTemas();
    if (result is SucessoRetorno<Stream<ResultadoTheme>>) {
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
    expect(result, isA<SucessoRetorno<Stream<ResultadoTheme>>>());
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ),
        isA<Stream<ResultadoTheme>>());
  });

  test('Deve ErrorCarregarTemas com Erro ao carregar os dados tema Cod.02-1',
      () async {
    await instance.collection('settingstheme').doc("theme").update({
      'user': "",
    });
    final result = await carregarTemasPresenter.carregarTemas();
    if (result is SucessoRetorno<Stream<ResultadoTheme>>) {
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
    expect(result, isA<ErroRetorno<Stream<ResultadoTheme>>>());
  });
}
