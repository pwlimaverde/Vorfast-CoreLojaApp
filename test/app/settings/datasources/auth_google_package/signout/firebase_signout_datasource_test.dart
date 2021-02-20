import 'package:corelojaapp/app/settings/datasources/auth_google_package/signout/firebase_signout_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class FirebaseAuthMock extends Mock implements auth.FirebaseAuth {}

class FirebaseUserMock extends Mock implements auth.User {}

class FirebaseAuthResultMock extends Mock implements auth.UserCredential {}

Future<void> main() async {
  FirebaseAuthMock _auth = FirebaseAuthMock();
  final datasource = FarebaseSignOutDatasource(
    auth: _auth,
  );

  test("deve retornar um true", () async {
    when(_auth.signOut())
        .thenAnswer((_) => Future.delayed(Duration(seconds: 1)));

    final result = await datasource();

    print("teste result - $result");
    expect(result, equals(true));
  });

  test("deve retornar um false", () async {
    when(_auth.signOut()).thenThrow(Exception());

    final result = await datasource();

    print("teste result - $result");
    expect(result, equals(false));
  });
}
