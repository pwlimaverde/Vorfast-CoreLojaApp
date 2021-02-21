import 'package:auth_google_package/auth_google_package.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:corelojaapp/app/settings/datasources/auth_google_package/carregar_usuario/model/firebase_resultado_usuario_model.dart';
import 'package:corelojaapp/app/settings/datasources/auth_google_package/signin/firebase_novo_email_datasource.dart';
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
  final instance = MockFirestoreInstance();
  final userMock = ResultadoUsuario(
    administrador: true,
    nome: "paulo",
    email: "pwlimaverde@gmail.com",
    id: "1y7DVXSyb2h3fdCNPDyhqfGAKFi1",
    endereco: null,
  );
  final datasource = FarebaseNovoEmailDatasource(
    authInstance: _auth,
    firestore: instance,
  );

  test("deve retornar um true  - usuario criado sucesso", () async {
    // when(instance
    //         .collection("user")
    //         .doc("1y7DVXSyb2h3fdCNPDyhqfGAKFi1")
    //         .set(any))
    //     .thenAnswer((_) => Future.delayed(Duration(seconds: 1)));
    when(
      _auth.createUserWithEmailAndPassword(
        email: "pwlimaverde@gmail.com",
        password: "pass",
      ),
    ).thenAnswer((_) async {
      return _credential;
    });

    final result = await datasource(
        parametros: ParametrosSignIn(
      user: userMock,
      pass: "pass",
    ));

    print("teste result - $result");
    expect(result, equals(true));
  });

  test("deve retornar um false - senha null", () async {
    final result =
        await datasource(parametros: ParametrosSignIn(user: userMock));

    print("teste result - $result");
    expect(result, equals(false));
  });

  test("deve retornar um false - user null", () async {
    final result = await datasource(parametros: ParametrosSignIn(pass: "pass"));

    print("teste result - $result");
    expect(result, equals(false));
  });

  test("deve retornar um false  - Exeption", () async {
    when(
      _auth.createUserWithEmailAndPassword(
        email: "pwlimaverde@gmail.com",
        password: "pass",
      ),
    ).thenThrow(Exception());

    final result = await datasource(
        parametros: ParametrosSignIn(
      user: userMock,
      pass: "pass",
    ));

    print("teste result - $result");
    expect(result, equals(false));
  });
}
