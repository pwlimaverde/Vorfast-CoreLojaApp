import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import '../../../../../auth/auth_features/carregar_usuario/external/model/firebase_resultado_usuario_model.dart';
import '../../../../../auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';
import '../../infra/datasources/signin_datasource.dart';

class FarebaseSignInGoogleDatasource implements SignInDatasource {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth auth;
  final Firestore firestore;

  FarebaseSignInGoogleDatasource({
    @required this.auth,
    @required this.googleSignIn,
    @required this.firestore,
  });

  @override
  Future<bool> call({
    String email,
    String pass,
    ResultadoUsuario user,
  }) async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await auth.signInWithCredential(credential)).user;

    DocumentReference docRef = firestore.collection("user").document(user.uid);
    DocumentSnapshot doc = await docRef.get();
    final exists = doc.exists;
    if (!exists) {
      FirebaseResultadoUsuarioModel userData = FirebaseResultadoUsuarioModel();
      userData.nome = user.displayName;
      userData.email = user.email;
      await _saveUserData(userFire: user, userData: userData);
    }
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _saveUserData(
      {FirebaseUser userFire, FirebaseResultadoUsuarioModel userData}) async {
    await firestore.collection("user").document(userFire.uid).setData({
      'nome': userData.nome,
      'id': userFire.uid,
      'email': userData.email,
      'administrador': userData.administrador,
    });
  }
}
