import 'package:corelojaapp/app/settings/configuracao_geral/configuracao_geral_presenter/configuracao_geral_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:meta/meta.dart';

class RepoImpl extends Repositorio<bool, NoParams> {
  final RetornoSucessoOuErro<bool> result;

  RepoImpl(this.result);

  @override
  Future<RetornoSucessoOuErro<bool>> call(
      {@required NoParams parametros}) async {
    return result;
  }
}

main() {
  test('Deve Retornar um SucessoRetorno true', () async {
    final repositorio = RepoImpl(SucessoRetorno(resultado: true));
    final checarConeccao = ChecarConeccaoUsecase(repository: repositorio);
    final result = await checarConeccao(parametros: NoParams());
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.erro)}");
    expect(result, isA<RetornoSucessoOuErro>());
  });

  test('Deve Retornar um ErroRetorno Cod.01-1', () async {
    final repositorio = null;
    final checarConeccao = ChecarConeccaoUsecase(repository: repositorio);
    final result = await checarConeccao(parametros: NoParams());
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.erro)}");
    expect(result, isA<RetornoSucessoOuErro>());
  });

  test('Deve Retornar um ErroRetorno false Cod.01-2', () async {
    final repositorio = RepoImpl(SucessoRetorno(resultado: false));
    final checarConeccao = ChecarConeccaoUsecase(repository: repositorio);
    final result = await checarConeccao(parametros: NoParams());
    print(
        "teste result => ${result.fold(sucesso: (value) => value.resultado, erro: (value) => value.erro)}");
    expect(result, isA<RetornoSucessoOuErro>());
  });
}
