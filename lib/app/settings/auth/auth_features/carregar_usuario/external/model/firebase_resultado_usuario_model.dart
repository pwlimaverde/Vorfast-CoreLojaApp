import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';
import '../../domain/entities/resultado_usuario.dart';

class RxFirebaseResultadoUsuarioModel {
  final id = "".obs;
  final nome = "".obs;
  final nick = "".obs;
  final email = "".obs;
  final endereco = "".obs;
  final administrador = false.obs;
}

class FirebaseResultadoUsuarioModel extends ResultadoUsuario {
  DocumentReference reference;
  FirebaseUser currentUser;
  FirebaseResultadoUsuarioModel({
    this.reference,
    this.currentUser,
    id,
    nome,
    nick,
    email,
    endereco,
    administrador,
  });

  final rx = RxFirebaseResultadoUsuarioModel();

  get id => rx.id.value;
  set id(value) => rx.id.value = value;

  get nome => rx.nome.value;
  set nome(value) => rx.nome.value = value;

  get nick => rx.nick.value;
  set nick(value) => rx.nick.value = value;

  get email => rx.email.value;
  set email(value) => rx.email.value = value;

  get endereco => rx.endereco.value;
  set endereco(value) => rx.endereco.value = value;

  get administrador => rx.administrador.value;
  set administrador(value) => rx.administrador.value = value;

  FirebaseResultadoUsuarioModel.fromDocument(
      {@required DocumentSnapshot doc, @required FirebaseUser user}) {
    this.reference = doc.reference;
    this.currentUser = user;
    this.id = doc['id'];
    this.nome = doc['nome'];
    this.nick = doc['nome'].toString().split(" ")[0] +
        " " +
        "${doc['nome'].toString().split(" ").length >= 2 ? doc['nome'].toString().split(" ")[1] : ""}";
    this.email = doc['email'];
    this.endereco = doc['endereco'];
    this.administrador = doc['administrador'];
  }

  void cleanUser() {
    this.reference = null;
    this.currentUser = null;
    id = "";
    nome = "";
    nick = "";
    email = "";
    endereco = "";
    administrador = false;
  }

  @override
  String toString() {
    return " Dados - id $id, nome $nome";
  }
}
