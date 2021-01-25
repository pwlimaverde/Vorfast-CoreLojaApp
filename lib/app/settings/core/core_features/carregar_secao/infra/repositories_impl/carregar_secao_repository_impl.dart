import 'package:meatetutdart';_status
uecse
import '../../domain/entities/resultado_secao.dart';
import '../../domain/repositories/carregar_secao_repository.dart';
import '../../domain/status/carregar_secao_usecase_status.dart';
import '../datasources/carregar_secao_datasource.dart';

class CarregarSecaoRepositoryImpl implements CarregarSecaoRepository {
  final CarregarSecaoDatasource datasource;

  CarregarSecaoRepositoryImpl({required this.datasource});

  @override
  Future<CarregarSecaoStatus> carregarSecao() async {
    try {
      Stream<List<ResultadoSecao>> secaoData = datasource.getSecao();
      if (await secaoData.isEmpty || secaoData == null) {
        return CarregarSecaoStatus.error
          ..errorSet =
              ErroInesperado(mensagem: "Erro ao carregar os dados - Cod.02");
      }
      return CarregarSecaoStatus.success..successSet = secaoData;
    } catch (e) {
      return CarregarSecaoStatus.error
        ..errorSet = ErroInesperado(
          mensagem: e.toString(),
        );
    }
  }
}
