import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:corelojaapp/app/settings/auth/auth_features/carregar_usuario/external/datasources_impl/firebase_usuario_datasource.dart';
import 'package:corelojaapp/app/settings/auth/auth_presenter/auth_presenter.dart';
import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class FirebaseAuthMock extends Mock implements auth.FirebaseAuth {}

class FirebaseUserMock extends Mock implements auth.User {}

class FirebaseAuthResultMock extends Mock implements auth.UserCredential {}

Future<void> main() async {
  final instance = MockFirestoreInstance();
  await instance.collection('user').doc("1y7DVXSyb2h3fdCNPDyhqfGAKFi1").update({
    'administrador': true,
    'email': "pwlimaverde@gmail.com",
    'id': "1y7DVXSyb2h3fdCNPDyhqfGAKFi1",
    'nome': "Paulo Weslley"
  });
  FirebaseAuthMock _auth = FirebaseAuthMock();
  FirebaseUserMock _user = FirebaseUserMock();
  final datasourse = FirebaseUsuarioDatasourse(
    authInstance: _auth,
    firestore: instance,
  );

  test("deve retornar um Stream<FirebaseResultadoUsuarioModel>", () async {
    when(_auth.currentUser).thenAnswer((_) => _user);
    when(_user.uid).thenAnswer((_) => "1y7DVXSyb2h3fdCNPDyhqfGAKFi1");

    final result = await datasourse.carregarUsuario();

    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.erro)}",
    );

    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.erro,
        ),
        isA<Stream<FirebaseResultadoUsuarioModel>>());
  });

  test("deve retornar um ErroInesperado Cod.03-1", () async {
    when(_auth.currentUser).thenAnswer((_) => _user);
    when(_user.uid).thenAnswer((_) => "1y7DVXSyb2h3fdCNPDyhqfGAKFi2");

    final result = await datasourse.carregarUsuario();

    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );

    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.error,
        ),
        isA<ErroInesperado>());
  });

  test("deve retornar um ErroInesperado Cod.03-2", () async {
    when(_auth.currentUser).thenAnswer((_) => _user);
    when(_user.uid).thenAnswer((_) => "");

    final result = await datasourse.carregarUsuario();

    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );

    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.error,
        ),
        isA<ErroInesperado>());
  });

  test("deve retornar um ErroInesperado Cod.03-3", () async {
    when(_auth.currentUser).thenAnswer((_) => _user);
    when(_user.uid).thenThrow(Exception());

    final result = await datasourse.carregarUsuario();

    print(
      "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.error)}",
    );

    expect(
        result.fold(
          sucesso: (value) => value.resultado,
          erro: (value) => value.error,
        ),
        isA<ErroInesperado>());
  });
}
