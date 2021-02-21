import 'package:auth_google_package/auth_google_package.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../carregar_usuario/model/firebase_resultado_usuario_model.dart';

class FarebaseSignInGoogleDatasource
    implements Datasource<bool, ParametrosSignIn> {
  final GoogleSignIn googleSignIn;
  final auth.FirebaseAuth authInstance;
  final FirebaseFirestore firestore;

  FarebaseSignInGoogleDatasource({
    @required this.authInstance,
    @required this.googleSignIn,
    @required this.firestore,
  });

  @override
  Future<bool> call({ParametrosSignIn parametros}) async {
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
      if (!doc.exists) {
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
      throw Exception(e);
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
