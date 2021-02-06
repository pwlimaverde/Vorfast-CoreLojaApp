import 'package:corelojaapp/app/shared/utilitario/erros.dart';
import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class ChecarConeccaoRepository extends Repositorio<bool, NoParams> {
  final Datasource<bool, NoParams> datasource;

  ChecarConeccaoRepository({@required this.datasource});

  @override
  Future<RetornoSucessoOuErro<bool>> call({NoParams parametros}) async {
    final resultado = await retornoDatasource(
      datasource: datasource,
      erro: ErrorConeccao(
          mensagem: 'Erro ao recuperar informação de conexão Cod.02-1'),
      parametros: NoParams(),
    );
    return resultado;
  }
}
