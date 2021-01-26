import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:corelojaapp/app/settings/auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';
import 'package:corelojaapp/app/settings/auth/auth_features/signin/external/datasources_impl/firebase_novo_email_datasource.dart';
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

main() async {
  final instance = MockFirestoreInstance();
  final userMock = ResultadoUsuario(
    administrador: true,
    nome: "paulo",
    email: "pwlimaverde@gmail.com",
    id: "1y7DVXSyb2h3fdCNPDyhqfGAKFi1",
    endereco: null,
  );

  // await instance.collection('user').doc("1y7DVXSyb2h3fdCNPDyhqfGAKFi1").set({
  //   'administrador': true,
  //   'email': "pwlimaverde@gmail.com",
  //   'id': "1y7DVXSyb2h3fdCNPDyhqfGAKFi1",
  //   'nome': "Paulo Weslley"
  // });

  FirebaseAuthMock _auth = FirebaseAuthMock();
  FirebaseAuthResultMock _credential = FirebaseAuthResultMock();

  FarebaseNovoEmailDatasource datasourse = FarebaseNovoEmailDatasource(
    authInstance: _auth,
    firestore: instance,
  );
  group("Teste SignIn", () {
    test("deve retornar true - usuario criado com sucesso", () async {
      when(_auth.createUserWithEmailAndPassword(
              email: "pwlimaverde@gmail.com", password: "pass"))
          .thenAnswer((_) async {
        return _credential;
      });

      final result = await datasourse(pass: "pass", user: userMock);
      print(
        "teste result valor => $result",
      );
      expect(result, true);
    });

    test("deve retornar false - erro ao salvar usuario", () async {
      when(_auth.createUserWithEmailAndPassword(
              email: "pwlimaverde@gmail.com", password: "pass"))
          .thenAnswer((_) async {
        return _credential;
      });

      final result = await datasourse(pass: "pass", user: ResultadoUsuario());
      print(
        "teste result valor => $result",
      );
      expect(result, false);
    });

    test("deve retornar false - erro ao salvar usuario throw", () async {
      when(_auth.createUserWithEmailAndPassword(
              email: "pwlimaverde@gmail.com", password: "pass"))
          .thenThrow(Exception());

      final result = await datasourse(pass: "pass", user: ResultadoUsuario());
      print(
        "teste result valor => $result",
      );
      expect(result, false);
    });
  });
}
