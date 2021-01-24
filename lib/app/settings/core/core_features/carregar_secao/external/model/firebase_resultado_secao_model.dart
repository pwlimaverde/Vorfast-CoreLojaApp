import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'firebase_resultado_anuncio_model.dart';
import '../../domain/entities/resultado_secao.dart';

class RxFirebaseResultadoSecaoModel {
  final nome = "".obs;
  final img = "".obs;
  final prioridade = 0.obs;
  final scrow = false.obs;
  final cor = {}.obs;
  final anuncios = List<FirebaseResultadoAnuncioModel>().obs;
}

class FirebaseResultadoSecaoModel extends ResultadoSecao {
  DocumentReference reference;

  FirebaseResultadoSecaoModel({
    this.reference,
    nome,
    img,
    prioridade,
    scrow,
    cor,
    anuncios,
  });

  final rx = RxFirebaseResultadoSecaoModel();

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
  List<FirebaseResultadoAnuncioModel> get anunciosValue => rx.anuncios;
  set anuncios(value) => rx.anuncios.bindStream(value);

  FirebaseResultadoSecaoModel.fromDocument(
    DocumentSnapshot doc,
    Stream<List<FirebaseResultadoAnuncioModel>> anuncios,
  ) {
    this.reference = doc.reference;
    this.nome = doc.data()['nome'];
    this.img = doc.data()['img'];
    this.prioridade = doc.data()['prioridade'];
    this.scrow = doc.data()['scrow'];
    this.cor = doc.data()['cor'];
    this.anuncios = anuncios;
  }
}
