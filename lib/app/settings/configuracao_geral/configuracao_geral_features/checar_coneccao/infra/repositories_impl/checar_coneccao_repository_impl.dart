import 'package:meta/meta.dart';

import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../../../../erros/erros.dart';
import '../../domain/repositories/checar_coneccao_repository.dart';
import '../datasources/checar_coneccao_datasource.dart';

class ChecarConeccaoRepositoryImpl implements ChecarConeccaoRepository {
  final ChecarConeccaoDatasource datasource;

  ChecarConeccaoRepositoryImpl({required this.datasource});

  @override
  Future<RetornoSucessoOuErro<bool>> checarConeccao() async {
    try {
      bool estaConectado = await datasource.isOnline;
      if (estaConectado) {
        return SucessoRetorno(result: true);
      }
      return SucessoRetorno(result: false);
    } catch (e) {
      return ErrorRetorno(erro: ErrorConeccao(mensagem: e.toString()));
    }
  }
}
