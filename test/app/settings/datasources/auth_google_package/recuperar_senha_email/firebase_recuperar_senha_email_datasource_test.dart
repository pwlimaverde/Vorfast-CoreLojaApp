import 'package:auth_google_package/auth_google_package.dart';
import 'package:corelojaapp/app/settings/datasources/auth_google_package/recuperar_senha_email/firebase_recuperar_senha_email_datasource.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class FirebaseAuthMock extends Mock implements auth.FirebaseAuth {}

class FirebaseUserMock extends Mock implements auth.User {}

class FirebaseAuthResultMock extends Mock implements auth.UserCredential {}

Future<void> main() async {
  FirebaseAuthMock _auth = FirebaseAuthMock();
  final datasource = FarebaseRecuperarSenhaEmailDatasource(
    authInstance: _auth,
  );

  test("deve retornar um true", () async {
    when(_auth.sendPasswordResetEmail(email: "pwlimaverde@gmail.com"))
        .thenAnswer((_) => Future.delayed(Duration(seconds: 1)));

    final result = await datasource(
        parametros:
            ParametrosRecuperarSenhaEmail(email: "pwlimaverde@gmail.com"));

    print("teste result - $result");
    expect(result, equals(true));
  });

  test("deve retornar um false", () async {
    final result = await datasource(
        parametros: ParametrosRecuperarSenhaEmail(email: null));

    print("teste result - $result");
    expect(result, equals(false));
  });

  test("deve retornar um ErrorRecuperarSenhaEmail Cod.03-1", () async {
    when(_auth.sendPasswordResetEmail(email: "pwlimaverde@gmail.com"))
        .thenThrow(Exception());

    expect(
      () async => await datasource(
          parametros:
              ParametrosRecuperarSenhaEmail(email: "pwlimaverde@gmail.com")),
      throwsA(isA<ErrorRecuperarSenhaEmail>()),
    );
  });
}
