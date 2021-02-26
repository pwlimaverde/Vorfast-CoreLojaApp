import 'package:carregar_secoes_package/carregar_secoes_package.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:corelojaapp/app/settings/datasources/carregar_secoes_package/firebase_secao_datasource.dart';
import 'package:corelojaapp/app/settings/datasources/carregar_secoes_package/model/firebase_resultado_secao_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

void main() async {
  final instance = MockFirestoreInstance();
  await _setSecoes(numero: 1, instance: instance);
  await _setSecoes(numero: 2, instance: instance);
  await _setSecoes(numero: 3, instance: instance);
  await _setSecoes(numero: 4, instance: instance);
  final carregarSecoesPresenter = CarregarSecoesPresenter(
    mostrarTempoExecucao: true,
    datasource: FirebaseSecaoDatasourse(firestore: instance),
  );

  test('Deve retornar um sucesso com Stream<FirebaseResultadoThemeModel>',
      () async {
    final result = await carregarSecoesPresenter.carregarSecoes();
    expect(result, isA<SucessoRetorno<Stream<List<ResultadoSecao>>>>());
    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ),
        isA<Stream<List<FirebaseResultadoSecaoModel>>>());
  });
}

Future<void> _setSecoes({int numero, MockFirestoreInstance instance}) async {
  await instance.collection('secao').doc("$numero").update({
    'nome': "promoção $numero",
    'img': "teste imagem $numero",
    'prioridade': numero,
    'scrow': true,
    'cor': {
      "r": 90,
      "g": 90,
      "b": 90,
      "a": 200,
    },
  });
  await instance
      .collection('secao')
      .doc("$numero")
      .collection("anuncios")
      .doc("a$numero")
      .update({
    'img': "teste imagem anuncio $numero",
    'prioridade': numero,
    'produto': numero,
    'x': numero,
    'y': numero,
  });

  await instance
      .collection('secao')
      .doc("$numero")
      .collection("anuncios")
      .doc("a${numero + 1}")
      .update({
    'img': "teste imagem anuncio ${numero + 1}",
    'prioridade': numero + 1,
    'produto': numero + 1,
    'x': numero + 1,
    'y': numero + 1,
  });

  await instance
      .collection('secao')
      .doc("$numero")
      .collection("anuncios")
      .doc("a${numero + 2}")
      .update({
    'img': "teste imagem anuncio ${numero + 2}",
    'prioridade': numero + 2,
    'produto': numero + 2,
    'x': numero + 2,
    'y': numero + 2,
  });
}
