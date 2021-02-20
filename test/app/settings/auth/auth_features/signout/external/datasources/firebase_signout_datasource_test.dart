import 'package:corelojaapp/app/settings/auth/auth_features/signout/external/datasources_impl/firebase_signout_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class FirebaseUserMock extends Mock implements FirebaseAuth {}

main() {
  FirebaseAuthMock _auth = FirebaseAuthMock();
  final datasource = FarebaseSignOutDatasource(auth: _auth);
  group("Teste SignOut", () {
    test("deve retornar true", () async {
      when(_auth.signOut())
          .thenAnswer((realInvocation) => Future.delayed(Duration(seconds: 1)));
      final result = await datasource.signOutFirebase();
      print(
        "teste result tipo => $result",
      );
      expect(result, true);
    });

    test("deve retornar false", () async {
      when(_auth.signOut()).thenThrow(Exception());
      final result = await datasource.signOutFirebase();
      print(
        "teste result tipo => $result",
      );
      expect(result, false);
    });
  });
}
