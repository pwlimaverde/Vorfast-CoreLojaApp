import 'package:auth_google_package/auth_google_package.dart';
import 'package:corelojaapp/app/settings/datasources/auth_google_package/signin/firebase_signin_email_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class FirebaseAuthMock extends Mock implements auth.FirebaseAuth {}

class FirebaseUserMock extends Mock implements auth.User {
  @override
  String get uid => '1y7DVXSyb2h3fdCNPDyhqfGAKFi1';
}

class FirebaseAuthResultMock extends Mock implements auth.UserCredential {
  @override
  auth.User get user => FirebaseUserMock();
}

Future<void> main() async {
  FirebaseAuthMock _auth = FirebaseAuthMock();
  FirebaseAuthResultMock _credential = FirebaseAuthResultMock();

  final datasource = FarebaseSignInEmailDatasource(
    authInstance: _auth,
  );

  test("deve retornar um true  - usuario logado sucesso", () async {
    when(
      _auth.signInWithEmailAndPassword(
        email: "pwlimaverde@gmail.com",
        password: "pass",
      ),
    ).thenAnswer((_) async {
      return _credential;
    });

    final result = await datasource(
        parametros: ParametrosSignIn(
      email: "pwlimaverde@gmail.com",
      pass: "pass",
    ));

    print("teste result - $result");
    expect(result, equals(true));
  });

  test("deve retornar um false - senha null", () async {
    final result = await datasource(
        parametros: ParametrosSignIn(email: "pwlimaverde@gmail.com"));

    print("teste result - $result");
    expect(result, equals(false));
  });

  test("deve retornar um false - email null", () async {
    final result = await datasource(parametros: ParametrosSignIn(pass: "pass"));

    print("teste result - $result");
    expect(result, equals(false));
  });

  test("deve retornar um false  - Exeption", () async {
    when(
      _auth.signInWithEmailAndPassword(
        email: "pwlimaverde@gmail.com",
        password: "pass",
      ),
    ).thenThrow(Exception());

    final result = await datasource(
        parametros: ParametrosSignIn(
      email: "pwlimaverde@gmail.com",
      pass: "pass",
    ));

    print("teste result - $result");
    expect(result, equals(false));
  });
}
