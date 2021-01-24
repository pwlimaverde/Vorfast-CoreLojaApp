import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import '../../../../../auth/auth_features/carregar_usuario/external/model/firebase_resultado_usuario_model.dart';
import '../../../../../auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';
import '../../infra/datasources/signin_datasource.dart';

class FarebaseSignInGoogleDatasource implements SignInDatasource {
  final GoogleSignIn googleSignIn;
  final auth.FirebaseAuth authInstance;
  final FirebaseFirestore firestore;

  FarebaseSignInGoogleDatasource({
    @required this.authInstance,
    @required this.googleSignIn,
    @required this.firestore,
  });

  @override
  Future<bool> call({
    String email,
    String pass,
    ResultadoUsuario user,
  }) async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final auth.User user =
          (await authInstance.signInWithCredential(credential)).user;

      DocumentReference docRef = firestore.collection("user").doc(user.uid);
      DocumentSnapshot doc = await docRef.get();
      final exists = doc.exists;
      if (!exists) {
        FirebaseResultadoUsuarioModel userData =
            FirebaseResultadoUsuarioModel();
        userData.nome = user.displayName;
        userData.email = user.email;
        final userSalvo =
            await _saveUserData(userFire: user, userData: userData);
        if (userSalvo) {
          return true;
        } else {
          return false;
        }
      }
      if (user != null && user.uid.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> _saveUserData(
      {auth.User userFire, FirebaseResultadoUsuarioModel userData}) async {
    try {
      await firestore.collection("user").doc(userFire.uid).set({
        'nome': userData.nome,
        'id': userFire.uid,
        'email': userData.email,
        'administrador': userData.administrador,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
