import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corelojaapp/app/modules/home/data/model/anuncio_model.dart';
import 'package:get/get.dart';

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
    this.reference,
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
    this.reference = doc.reference;
    this.nome = doc.data()['nome'];
    this.img = doc.data()['img'];
    this.prioridade = doc.data()['prioridade'];
    this.scrow = doc.data()['scrow'];
    this.cor = doc.data()['cor'];
    this.anuncios = anuncios;
  }

  @override
  String toString() {
    return " Dados - $nome, $cor, user - $anunciosValue";
  }
}
