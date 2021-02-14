import 'package:auth_google_package/auth_google_package.dart';
import 'package:auth_google_package/src/carregar_usuario/presenter/carregar_usuario_presenter.dart';
import 'package:auth_google_package/src/carregar_usuario/usecases/entities/resultado_usuario.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:rxdart/rxdart.dart';

class FairebaseUsuarioDatasourceMock extends Mock
    implements Datasource<Stream<ResultadoUsuario>, NoParams> {}

class FairebaseRecuperarSenhaEmailDatasourceMock extends Mock
    implements Datasource<bool, ParametrosRecuperarSenhaEmail> {}

class FairebaseSignOutDatasourceMock extends Mock
    implements Datasource<bool, NoParams> {}

class FairebaseSignInDatasourceMock extends Mock
    implements Datasource<bool, ParametrosSignIn> {}

void main() {
  Datasource<Stream<ResultadoUsuario>, NoParams> fairebaseUsuarioDatasource;
  Datasource<bool, ParametrosRecuperarSenhaEmail>
      fairebaseRecuperarSenhaEmailDatasource;
  Datasource<bool, NoParams> fairebaseSignOutDatasource;
  Datasource<bool, ParametrosSignIn> fairebaseSignInDatasource;

  setUp(() {
    fairebaseUsuarioDatasource = FairebaseUsuarioDatasourceMock();
    fairebaseRecuperarSenhaEmailDatasource =
        FairebaseRecuperarSenhaEmailDatasourceMock();
    fairebaseSignOutDatasource = FairebaseSignOutDatasourceMock();
    fairebaseSignInDatasource = FairebaseSignInDatasourceMock();
  });

  group("carregar_usuario", () {
    test('Deve retornar um sucesso com Stream<ResultadoUsuario>', () async {
      final testeFire = BehaviorSubject<ResultadoUsuario>();
      testeFire.add(
        ResultadoUsuario(
          id: "1",
          nome: "Paulo Weslley",
          email: "Paulo Weslley",
          endereco: "Paulo Weslley",
          administrador: true,
        ),
      );
      when(fairebaseUsuarioDatasource)
          .calls(#call)
          .thenAnswer((_) => Future.value(testeFire));
      final result = await CarregarUsuarioPresenter(
              datasource: fairebaseUsuarioDatasource,
              mostrarTempoExecucao: true)
          .carregarUsuario();
      print("teste result - ${await result.fold(
            sucesso: (value) => value.resultado,
            erro: (value) => value.erro,
          ).first}");
      expect(result, isA<SucessoRetorno<Stream<ResultadoUsuario>>>());
      expect(
          result.fold(
            sucesso: (value) => value.resultado,
            erro: (value) => value.erro,
          ),
          isA<Stream<ResultadoUsuario>>());
      testeFire.close();
    });

    test(
        'Deve ErroCarregarUsuario com Erro ao carregar os dados do Usuario Cod.02-1',
        () async {
      when(fairebaseUsuarioDatasource).calls(#call).thenThrow(Exception());
      final result = await CarregarUsuarioPresenter(
              datasource: fairebaseUsuarioDatasource,
              mostrarTempoExecucao: true)
          .carregarUsuario();
      print("teste result - ${await result.fold(
        sucesso: (value) => value.resultado,
        erro: (value) => value.erro,
      )}");
      expect(result, isA<ErroRetorno<Stream<ResultadoUsuario>>>());
    });
  });

  group("recuperar_senha_email", () {
    test('Deve retornar um sucesso com true', () async {
      when(fairebaseRecuperarSenhaEmailDatasource)
          .calls(#call)
          .thenAnswer((_) => Future.value(true));
      final result = await RecuperarSenhaEmailPresenter(
        datasource: fairebaseRecuperarSenhaEmailDatasource,
        mostrarTempoExecucao: true,
      ).recuperarSenhaEmail(
          parametros: ParametrosRecuperarSenhaEmail(email: "any"));
      print("teste result - ${await result.fold(
        sucesso: (value) => value.resultado,
        erro: (value) => value.erro,
      )}");
      expect(result, isA<SucessoRetorno<bool>>());
      expect(
          result.fold(
            sucesso: (value) => value.resultado,
            erro: (value) => value.erro,
          ),
          true);
    });

    test(
        'Deve retornar um ErrorCarregarEmpresa com Erro ao carregar os dados da empresa Cod.01-1',
        () async {
      when(fairebaseRecuperarSenhaEmailDatasource)
          .calls(#call)
          .thenAnswer((_) => Future.value(false));
      final result = await RecuperarSenhaEmailPresenter(
        datasource: fairebaseRecuperarSenhaEmailDatasource,
        mostrarTempoExecucao: true,
      ).recuperarSenhaEmail(
          parametros: ParametrosRecuperarSenhaEmail(email: "any"));
      print("teste result - ${await result.fold(
        sucesso: (value) => value.resultado,
        erro: (value) => value.erro,
      )}");
      expect(result, isA<ErroRetorno<bool>>());
    });

    test(
        'Deve retornar ErroRecuperarSenhaEmail com Erro ao recuperar a senha pelo e-mail Cod.02-1',
        () async {
      when(fairebaseRecuperarSenhaEmailDatasource)
          .calls(#call)
          .thenThrow(Exception());
      final result = await RecuperarSenhaEmailPresenter(
        datasource: fairebaseRecuperarSenhaEmailDatasource,
        mostrarTempoExecucao: true,
      ).recuperarSenhaEmail(
          parametros: ParametrosRecuperarSenhaEmail(email: "any"));
      print("teste result - ${await result.fold(
        sucesso: (value) => value.resultado,
        erro: (value) => value.erro,
      )}");
      expect(result, isA<ErroRetorno<bool>>());
    });
  });

  group("signout", () {
    test('Deve retornar um sucesso com true', () async {
      when(fairebaseSignOutDatasource)
          .calls(#call)
          .thenAnswer((_) => Future.value(true));
      final result = await SignOutPresenter(
        datasource: fairebaseSignOutDatasource,
        mostrarTempoExecucao: true,
      ).signOut();
      print("teste result - ${await result.fold(
        sucesso: (value) => value.resultado,
        erro: (value) => value.erro,
      )}");
      expect(result, isA<SucessoRetorno<bool>>());
      expect(
          result.fold(
            sucesso: (value) => value.resultado,
            erro: (value) => value.erro,
          ),
          true);
    });

    test(
        'Deve retornar um ErrorCarregarEmpresa com Erro ao fazer o signout Cod.01-1',
        () async {
      when(fairebaseSignOutDatasource)
          .calls(#call)
          .thenAnswer((_) => Future.value(false));
      final result = await SignOutPresenter(
        datasource: fairebaseSignOutDatasource,
        mostrarTempoExecucao: true,
      ).signOut();
      print("teste result - ${await result.fold(
        sucesso: (value) => value.resultado,
        erro: (value) => value.erro,
      )}");
      expect(result, isA<ErroRetorno<bool>>());
    });

    test(
        'Deve retornar ErrorCarregarEmpresa com Erro ao fazer o signout Cod.02-1',
        () async {
      when(fairebaseSignOutDatasource).calls(#call).thenThrow(Exception());
      final result = await SignOutPresenter(
        datasource: fairebaseSignOutDatasource,
        mostrarTempoExecucao: true,
      ).signOut();
      print("teste result - ${await result.fold(
        sucesso: (value) => value.resultado,
        erro: (value) => value.erro,
      )}");
      expect(result, isA<ErroRetorno<bool>>());
    });
  });

  group("signin", () {
    test('Deve retornar um sucesso com true', () async {
      when(fairebaseSignInDatasource)
          .calls(#call)
          .thenAnswer((_) => Future.value(true));
      final result = await SignInPresenter(
        datasource: fairebaseSignInDatasource,
        mostrarTempoExecucao: true,
      ).signIn(parametros: ParametrosSignIn(email: "any"));
      print("teste result - ${await result.fold(
        sucesso: (value) => value.resultado,
        erro: (value) => value.erro,
      )}");
      expect(result, isA<SucessoRetorno<bool>>());
      expect(
          result.fold(
            sucesso: (value) => value.resultado,
            erro: (value) => value.erro,
          ),
          true);
    });

    test('Deve retornar um ErroSignIn com Erro ao fazer o SignIn Cod.01-1',
        () async {
      when(fairebaseSignInDatasource)
          .calls(#call)
          .thenAnswer((_) => Future.value(false));
      final result = await SignInPresenter(
        datasource: fairebaseSignInDatasource,
        mostrarTempoExecucao: true,
      ).signIn(parametros: ParametrosSignIn(email: "any"));
      print("teste result - ${await result.fold(
        sucesso: (value) => value.resultado,
        erro: (value) => value.erro,
      )}");
      expect(result, isA<ErroRetorno<bool>>());
    });

    test('Deve retornar ErroSignIn com Erro ao fazer o SignIn Cod.02-1',
        () async {
      when(fairebaseSignInDatasource).calls(#call).thenThrow(Exception());
      final result = await SignInPresenter(
        datasource: fairebaseSignInDatasource,
        mostrarTempoExecucao: true,
      ).signIn(parametros: ParametrosSignIn(email: "any"));
      print("teste result - ${await result.fold(
        sucesso: (value) => value.resultado,
        erro: (value) => value.erro,
      )}");
      expect(result, isA<ErroRetorno<bool>>());
    });
  });
}
