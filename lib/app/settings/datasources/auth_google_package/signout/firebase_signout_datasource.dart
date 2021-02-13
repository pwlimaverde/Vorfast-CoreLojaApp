import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class FarebaseSignOutDatasource implements Datasource<bool, NoParams> {
  final FirebaseAuth auth;

  FarebaseSignOutDatasource({
    @required this.auth,
  });

  @override
  Future<bool> call({NoParams parametros}) async {
    try {
      return await auth.signOut().then((_) => true);
    } catch (e) {
      return false;
    }
  }
}
