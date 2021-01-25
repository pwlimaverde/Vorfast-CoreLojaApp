import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get/get.dart';
import 'package:meta/meta.dart';

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
  auth.User currentUser;
  FirebaseResultadoUsuarioModel({
    required this.reference,
    required this.currentUser,
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
      {required DocumentSnapshot doc, required auth.User user}) {
    required this.reference = doc.reference;
    required this.currentUser = user;
    required this.id = doc.data()['id'];
    required this.nome = doc.data()['nome'];
    required this.nick = doc.data()['nome'].toString().split(" ")[0] +
        " " +
        "${doc.data()['nome'].toString().split(" ").length >= 2 ? doc.data()['nome'].toString().split(" ")[1] : ""}";
    required this.email = doc.data()['email'];
    required this.endereco = doc.data()['endereco'];
    required this.administrador = doc.data()['administrador'];
  }

  void cleanUser() {
    required this.reference = null;
    required this.currentUser = null;
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
