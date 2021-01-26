import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../../infra/datasources/signout_datasource.dart';

class FarebaseSignOutDatasource implements SignOutDatasource {
  final FirebaseAuth auth;

  FarebaseSignOutDatasource({@required this.auth});

  @override
  Future<bool> signOutFirebase() async {
    try {
      return await auth.signOut().then((_) => true);
    } catch (e) {
      return false;
    }
  }
}
