import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RxAnuncioModel {
  final image = "".obs;
  final prioridade = 0.obs;
  final produto = 0.obs;
  final x = 0.obs;
  final y = 0.obs;
}

class AnuncioModel {
  DocumentReference reference;

  AnuncioModel({
    image,
    prioridade,
    produto,
    x,
    y,
    this.reference,
  });

  final rx = RxAnuncioModel();

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

  AnuncioModel.fromJson(Map<String, dynamic> json) {
    this.image = json['image'];
    this.prioridade = json['prioridade'];
    this.produto = json['produto'];
    this.x = json['x'];
    this.y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['prioridade'] = this.prioridade;
    data['produto'] = this.produto;
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }

  AnuncioModel.fromDocument(DocumentSnapshot doc) {
    this.reference = doc.reference;
    this.image = doc['image'];
    this.prioridade = doc['prioridade'];
    this.produto = doc['produto'];
    this.x = doc['x'];
    this.y = doc['y'];
  }

  @override
  String toString() {
    return " Dados - $produto, $x, user - $y";
  }
}
