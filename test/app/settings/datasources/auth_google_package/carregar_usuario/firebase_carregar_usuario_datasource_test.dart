import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:corelojaapp/app/settings/datasources/auth_google_package/carregar_usuario/firebase_carregar_usuario_datasource.dart';
import 'package:corelojaapp/app/settings/datasources/auth_google_package/carregar_usuario/model/firebase_resultado_usuario_model.dart';
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
  final datasource = FirebaseCarregarUsuarioDatasource(
    authInstance: _auth,
    firestore: instance,
  );

  test("deve retornar um Stream<FirebaseResultadoUsuarioModel>", () async {
    when(_auth.currentUser).thenAnswer((_) => _user);
    when(_user.uid).thenAnswer((_) => "1y7DVXSyb2h3fdCNPDyhqfGAKFi1");

    final result = await datasource();

    print("teste result - ${await result.first}");
    expect(result, isA<Stream<FirebaseResultadoUsuarioModel>>());
  });

  test(
      "deve retornar um Exception por: Cadastro do usuario não localizado - Cod.03-1",
      () async {
    when(_auth.currentUser).thenAnswer((_) => _user);
    when(_user.uid).thenAnswer((_) => "1y7DVXSyb2h3fdCNPDyhqfGAKFi2");

    expect(
      () async => await datasource(),
      throwsA(isA<ErrorCarregarUsuario>()),
    );
  });

  test("deve retornar um Exception por: Sem usuario Logado - Cod.03-2",
      () async {
    when(_auth.currentUser).thenAnswer((_) => _user);
    when(_user.uid).thenAnswer((_) => "");

    expect(
      () async => await datasource(),
      throwsA(isA<ErrorCarregarUsuario>()),
    );
  });

  test("deve retornar um ErroInesperado Cod.03-3", () async {
    when(_auth.currentUser).thenAnswer((_) => _user);
    when(_user.uid).thenThrow(Exception());

    expect(
      () async => await datasource(),
      throwsA(isA<ErrorCarregarUsuario>()),
    );
  });
}
