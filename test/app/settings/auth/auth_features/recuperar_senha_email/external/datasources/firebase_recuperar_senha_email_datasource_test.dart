import 'package:corelojaapp/app/settings/auth/auth_features/recuperar_senha_email/external/datasources_impl/firebase_recuperar_senha_email_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseAuthMock extends Mock implements auth.FirebaseAuth {}

class FirebaseUserMock extends Mock implements auth.FirebaseAuth {}

class FirebaseAuthResultMock extends Mock implements auth.UserCredential {}

main() {
  FirebaseAuthMock _auth = FirebaseAuthMock();
  BehaviorSubject<FirebaseUserMock> _user = BehaviorSubject<FirebaseUserMock>();
  final datasource = FarebaseRecuperarSenhaEmailDatasource(authInstance: _auth);
  group("Teste recuperar senha", () {
    test("deve retornar true", () async {
      when(_auth.sendPasswordResetEmail(email: "emailteste"))
          .thenAnswer((_) => Future.delayed(Duration(seconds: 1)));
      final result =
          await datasource.recuperarSenhaEmailFirebase(email: "emailteste");
      print(
        "teste result tipo => $result",
      );
      expect(result, true);
    });

    test("deve retornar false", () async {
      when(_auth.sendPasswordResetEmail(email: null))
          .thenAnswer((realInvocation) => Future.delayed(Duration(seconds: 1)));
      final result = await datasource.recuperarSenhaEmailFirebase(email: null);
      print(
        "teste result tipo => $result",
      );
      expect(result, false);
    });

    test("deve retornar false", () async {
      when(_auth.sendPasswordResetEmail(email: "emailteste"))
          .thenThrow(Exception());
      final result =
          await datasource.recuperarSenhaEmailFirebase(email: "emailteste");
      print(
        "teste result tipo => $result",
      );
      expect(result, false);
    });
  });

  _user.close();
}
