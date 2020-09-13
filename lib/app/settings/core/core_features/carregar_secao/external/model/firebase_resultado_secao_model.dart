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

  get cor => rx.cor.value;
  set cor(value) => rx.cor.value = value;

  get anuncios => rx.anuncios;
  List<FirebaseResultadoAnuncioModel> get anunciosValue => rx.anuncios.value;
  set anuncios(value) => rx.anuncios.bindStream(value);

  FirebaseResultadoSecaoModel.fromDocument(
    DocumentSnapshot doc,
    Stream<List<FirebaseResultadoAnuncioModel>> anuncios,
  ) {
    this.reference = doc.reference;
    this.nome = doc['nome'];
    this.img = doc['img'];
    this.prioridade = doc['prioridade'];
    this.scrow = doc['scrow'];
    this.cor = doc['cor'];
    this.anuncios = anuncios;
  }
}
