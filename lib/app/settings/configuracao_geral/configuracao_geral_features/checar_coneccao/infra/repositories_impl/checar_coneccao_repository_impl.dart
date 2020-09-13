import 'package:meta/meta.dart';
import '../../domain/status/checar_coneccao_usecase_status.dart';
import '../datasources/checar_coneccao_datasource.dart';
import '../../domain/repositories/checar_coneccao_repository.dart';
import '../../../../../../shared/utilitario/erros.dart';

class ChecarConeccaoRepositoryImpl implements ChecarConeccaoRepository {
  final ChecarConeccaoDatasource datasource;

  ChecarConeccaoRepositoryImpl({@required this.datasource});

  @override
  Future<ChecarConeccaoStatus> checarConeccao() async {
    try {
      bool estaConectado = await datasource.isOnline;
      if (estaConectado) {
        return ChecarConeccaoStatus.success..successSet = true;
      }
      return ChecarConeccaoStatus.success..successSet = false;
    } catch (e) {
      return ChecarConeccaoStatus.error
        ..errorSet = ErrorConeccao(mensagem: e.toString());
    }
  }
}
