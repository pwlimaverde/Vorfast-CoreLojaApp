import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../../infra/datasources/signout_datasource.dart';

class FarebaseSignOutDatasource implements SignOutDatasource {
  final FirebaseAuth auth;

  FarebaseSignOutDatasource({@required this.auth});

  @override
  Future<void> signOutFirebase() async {
    return await auth.signOut().catchError((error) {
      throw error;
    });
  }
}
