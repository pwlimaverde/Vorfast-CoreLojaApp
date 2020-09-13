import 'package:meta/meta.dart';
import '../status/checar_coneccao_usecase_status.dart';
import '../repositories/checar_coneccao_repository.dart';
import '../../../../../../shared/utilitario/erros.dart';

abstract class ChecarConeccaoUsecase {
  Future<ChecarConeccaoStatus> call();
}

class ChecarConeccaoUsecaseImpl implements ChecarConeccaoUsecase {
  final ChecarConeccaoRepository repository;

  ChecarConeccaoUsecaseImpl({@required this.repository});

  @override
  Future<ChecarConeccaoStatus> call() async {
    try {
      ChecarConeccaoStatus check = await repository.checarConeccao();
      if (check == ChecarConeccaoStatus.success) {
        if (check.successGet) {
          return check;
        }
        return ChecarConeccaoStatus.error
          ..errorSet = ErrorConeccao(mensagem: "Você está offline Cod.01-1");
      }
      return ChecarConeccaoStatus.error
        ..errorSet = ErrorConeccao(
            mensagem: "Erro ao recuperar informação de conexão Cod.01-2");
    } catch (e) {
      return ChecarConeccaoStatus.error
        ..errorSet = ErrorConeccao(
            mensagem:
                "${e.toString()} - Erro ao recuperar informação de conexão Cod.01-3");
    }
  }
}
