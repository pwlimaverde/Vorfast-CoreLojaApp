import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../../../../auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';
import '../../infra/datasources/signin_datasource.dart';

class FarebaseNovoEmailDatasource implements SignInDatasource {
  final auth.FirebaseAuth authInstance;
  final FirebaseFirestore firestore;

  FarebaseNovoEmailDatasource({
    required this.authInstance,
    required this.firestore,
  });

  @override
  Future<bool> call({
    String email,
    required String pass,
    required ResultadoUsuario user,
  }) async {
    try {
      if (user.email == null) {
        return false;
      }
      final userCredencial = await authInstance.createUserWithEmailAndPassword(
        email: user.email,
        password: pass,
      );
      if (userCredencial.user != null && userCredencial.user.uid.length > 0) {
        bool usuarioSalvo = await _saveUserData(
          userFire: userCredencial.user,
          userData: user,
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
