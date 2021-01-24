import 'package:meta/meta.dart';
import '../datasources/checar_coneccao_datasource.dart';
import '../../domain/repositories/checar_coneccao_repository.dart';
import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../../../../../shared/utilitario/erros.dart';

class ChecarConeccaoRepositoryImpl implements ChecarConeccaoRepository {
  final ChecarConeccaoDatasource datasource;

  ChecarConeccaoRepositoryImpl({@required this.datasource});

  @override
  Future<RetornoSucessoOuErro<bool>> checarConeccao() async {
    try {
      bool estaConectado = await datasource.isOnline;
      if (estaConectado) {
        return SucessoResultado(result: true);
      }
      return SucessoResultado(result: false);
    } catch (e) {
      return ErrorResultado(error: ErrorConeccao(mensagem: e.toString()));
    }
  }
}
