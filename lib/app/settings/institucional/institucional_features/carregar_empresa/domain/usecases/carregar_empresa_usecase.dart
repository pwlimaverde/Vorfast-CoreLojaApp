import 'package:meta/meta.dart';
import '../entities/resultado_empresa.dart';
import '../repositories/carregar_empresa_repository.dart';
import '../status/carregar_empresa_usecase_status.dart';
import '../../../../../../shared/utilitario/erros.dart';

abstract class CarregarEmpresaUsecase {
  Future<CarregarEmpresaStatus> call();
}

class CarregarEmpresaUsecaseImpl implements CarregarEmpresaUsecase {
  final CarregarEmpresaRepository repository;

  CarregarEmpresaUsecaseImpl({@required this.repository});

  @override
  Future<CarregarEmpresaStatus> call() async {
    try {
      CarregarEmpresaStatus result = await repository.carregarEmpresa();
      if (result == CarregarEmpresaStatus.success) {
        Stream<ResultadoEmpresa> empresaDados = result.successGet;
        ResultadoEmpresa resultadoDados =
            await empresaDados.map((event) => event).first;
        if (resultadoDados.nome.length > 0) {
          return result;
        }
        return CarregarEmpresaStatus.error
          ..errorSet = ErroInesperado(
              mensagem: "Erro ao carregar os dados da Empresa Cod.01-1");
      }
      return CarregarEmpresaStatus.error
        ..errorSet = ErroInesperado(
            mensagem: "Erro ao carregar os dados da Empresa Cod.01-2");
    } catch (e) {
      return CarregarEmpresaStatus.error
        ..errorSet = ErroInesperado(
          mensagem:
              "${e.toString()} - Erro ao carregar os dados da Empresa Cod.01-3",
        );
    }
  }
}
