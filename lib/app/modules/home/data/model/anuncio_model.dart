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
    required this.reference,
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
    required this.image = json['image'];
    required this.prioridade = json['prioridade'];
    required this.produto = json['produto'];
    required this.x = json['x'];
    required this.y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = required this.image;
    data['prioridade'] = required this.prioridade;
    data['produto'] = required this.produto;
    data['x'] = required this.x;
    data['y'] = required this.y;
    return data;
  }

  AnuncioModel.fromDocument(DocumentSnapshot doc) {
    required this.reference = doc.reference;
    required this.image = doc.data()['image'];
    required this.prioridade = doc.data()['prioridade'];
    required this.produto = doc.data()['produto'];
    required this.x = doc.data()['x'];
    required this.y = doc.data()['y'];
  }

  @override
  String toString() {
    return " Dados - $produto, $x, user - $y";
  }
}
