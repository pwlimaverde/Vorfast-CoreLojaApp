import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';
import '../../domain/entities/resultado_empresa.dart';

class RxFirebaseResultadoEmpresaModel {
  final nome = "".obs;
  final logo260x200 = "".obs;
  final licenca = false.obs;
}

class FirebaseResultadoEmpresaModel extends ResultadoEmpresa {
  DocumentReference reference;
  FirebaseResultadoEmpresaModel({
    this.reference,
    nome,
    logo260x200,
    licenca,
  });

  final rx = RxFirebaseResultadoEmpresaModel();

  get nome => rx.nome.value;
  set nome(value) => rx.nome.value = value;

  get logo260x200 => rx.logo260x200.value;
  set logo260x200(value) => rx.logo260x200.value = value;

  get licenca => rx.licenca.value;
  set licenca(value) => rx.licenca.value = value;

  FirebaseResultadoEmpresaModel.fromDocument({@required DocumentSnapshot doc}) {
    this.reference = doc.reference;
    this.nome = doc['nome'];
    this.logo260x200 = doc['logo260x200'];
    this.licenca = doc['licenca'];
  }
}
