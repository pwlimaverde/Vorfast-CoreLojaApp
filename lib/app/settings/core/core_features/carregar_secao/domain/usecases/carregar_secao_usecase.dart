import '../entities/resultado_secao.dart';
import '../repositories/carregar_secao_repository.dart';
import '../status/carregar_secao_usecase_status.dart';

abstract class CarregarSecaoUsecase {
  Future<CarregarSecaoStatus> call();
}

class CarregarSecaoUsecaseImpl implements CarregarSecaoUsecase {
  final CarregarSecaoRepository repository;

  CarregarSecaoUsecaseImpl({required this.repository});

  @override
  Future<CarregarSecaoStatus> call() async {
    try {
      CarregarSecaoStatus result = await repository.carregarSecao();
      if (result == CarregarSecaoStatus.success) {
        Stream<List<ResultadoSecao>> secaoDados = result.successGet;
        if (await secaoDados.isEmpty || secaoDados == null) {
          return CarregarSecaoStatus.error
            ..errorSet = ErroInesperado(
                mensagem: "Erro ao carregar os dados das Seções - Cod.01-1");
        }
        return result;
      }
      return CarregarSecaoStatus.error
        ..errorSet = ErroInesperado(
            mensagem: "Erro ao carregar os dados das Seções - Cod.01-2");
    } catch (e) {
      return CarregarSecaoStatus.error
        ..errorSet = ErroInesperado(
          mensagem:
              "${e.toString()} - Erro ao carregar os dados das Seções - Cod.01-3",
        );
    }
  }
}
