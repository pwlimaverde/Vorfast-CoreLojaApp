import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../domain/entities/resultado_anuncio.dart';

class RxFirebaseResultadoAnuncioModel {
  final image = "".obs;
  final prioridade = 0.obs;
  final produto = 0.obs;
  final x = 0.obs;
  final y = 0.obs;
}

class FirebaseResultadoAnuncioModel extends ResultadoAnuncio {
  DocumentReference reference;

  FirebaseResultadoAnuncioModel({
    required this.reference,
    image,
    prioridade,
    produto,
    x,
    y,
  });

  final rx = RxFirebaseResultadoAnuncioModel();

  get image => rx.image.value;
  set image(value) => rx.image.value = value;

  get prioridade => rx.prioridade.value;
  set prioridade(value) => rx.prioridade.value = value;

  get produto => rx.produto.value;
  set produto(value) => rx.produto.value = value;

  get x => rx.x.value;
  set x(value) => rx.x.value = value;

  get y => rx.y.value;
  set y(value) => rx.y.value = value;

  FirebaseResultadoAnuncioModel.fromDocument(DocumentSnapshot doc) {
    required this.reference = doc.reference;
    required this.image = doc.data()['image'];
    required this.prioridade = doc.data()['prioridade'];
    required this.produto = doc.data()['produto'];
    required this.x = doc.data()['x'];
    required this.y = doc.data()['y'];
  }

  @override
  String toString() {
    return "Produto - $produto - $x, $y";
  }
}
