import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import '../datasources/checar_coneccao_datasource.dart';
import '../../domain/repositories/checar_coneccao_repository.dart';
import '../../../../../../shared/utilitario/erros.dart';

class ChecarConeccaoRepositoryImpl implements ChecarConeccaoRepository {
  final ChecarConeccaoDatasource datasource;

  ChecarConeccaoRepositoryImpl({@required this.datasource});

  @override
  Future<RetornoSucessoOuErro<bool>> checarConeccao() async {
    try {
      bool estaConectado = await datasource.isOnline;
      if (estaConectado) {
        return SucessoRetorno(resultado: true);
      }
      return SucessoRetorno(resultado: false);
    } catch (e) {
      return ErroRetorno(erro: ErrorConeccao(mensagem: e.toString()));
    }
  }
}
