import 'dart:async';

import 'package:auth_google_package/auth_google_package.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corelojaapp/app/settings/datasources/auth_google_package/carregar_usuario/model/firebase_resultado_usuario_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class FarebaseNovoEmailDatasource
    implements Datasource<bool, ParametrosSignIn> {
  final auth.FirebaseAuth authInstance;
  final FirebaseFirestore firestore;

  FarebaseNovoEmailDatasource({
    @required this.authInstance,
    @required this.firestore,
  });

  @override
  Future<bool> call({ParametrosSignIn parametros}) async {
    try {
      if (parametros.user.email == null || parametros.pass == null) {
        return false;
      }
      final userCredencial = await authInstance.createUserWithEmailAndPassword(
        email: parametros.user.email,
        password: parametros.pass,
      );
      if (userCredencial.user != null && userCredencial.user.uid.length > 0) {
        final usuarioSalvo = await _saveUserData(
          userFire: userCredencial.user,
          userData: parametros.user,
        );
        if (usuarioSalvo) {
          return true;
        } else {
          userCredencial.user.delete();
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> _saveUserData(
      {auth.User userFire, ResultadoUsuario userData}) async {
    try {
      Future<bool> userSalvo = firestore
          .collection("user")
          .doc(userFire.uid)
          .set({
            'nome': userData.nome,
            'id': userFire.uid,
            'email': userData.email,
            'administrador': userData.administrador,
          })
          .then((_) => true)
          .catchError((e) => false);
      return userSalvo;
    } catch (e) {
      return false;
    }
  }
}
