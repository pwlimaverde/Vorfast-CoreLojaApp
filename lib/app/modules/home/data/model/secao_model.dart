import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'anuncio_model.dart';

class RxSecaoModel {
  final nome = "".obs;
  final img = "".obs;
  final prioridade = 0.obs;
  final scrow = false.obs;
  final cor = {}.obs;
  final anuncios = List<AnuncioModel>().obs;
}

class SecaoModel {
  DocumentReference reference;

  SecaoModel({
    nome,
    img,
    prioridade,
    scrow,
    cor,
    anuncios,
    required this.reference,
  });

  final rx = RxSecaoModel();

  get nome => rx.nome.value;
  set nome(value) => rx.nome.value = value;

  get img => rx.img.value;
  set img(value) => rx.img.value = value;

  get prioridade => rx.prioridade.value;
  set prioridade(value) => rx.prioridade.value = value;

  get scrow => rx.scrow.value;
  set scrow(value) => rx.scrow.value = value;

  get cor => rx.cor;
  set cor(value) => rx.cor.value = value;

  get anuncios => rx.anuncios;
  List<AnuncioModel> get anunciosValue => rx.anuncios;
  set anuncios(value) => rx.anuncios.bindStream(value);

  SecaoModel.fromDocument(
    DocumentSnapshot doc,
    Stream<List<AnuncioModel>> anuncios,
  ) {
    required this.reference = doc.reference;
    required this.nome = doc.data()['nome'];
    required this.img = doc.data()['img'];
    required this.prioridade = doc.data()['prioridade'];
    required this.scrow = doc.data()['scrow'];
    required this.cor = doc.data()['cor'];
    required this.anuncios = anuncios;
  }

  @override
  String toString() {
    return " Dados - $nome, $cor, user - $anunciosValue";
  }
}
