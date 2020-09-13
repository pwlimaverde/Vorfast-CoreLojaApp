import 'package:meta/meta.dart';
import '../entities/resultado_usuario.dart';
import '../repositories/carregar_usuario_repository.dart';
import '../status/carregar_usuario_usecase_status.dart';
import '../../../../../../shared/utilitario/erros.dart';

abstract class CarregarUsuarioUsecase {
  Future<CarregarUsuarioStatus> call();
}

class CarregarUsuarioUsecaseImpl implements CarregarUsuarioUsecase {
  final CarregarUsuarioRepository repository;

  CarregarUsuarioUsecaseImpl({@required this.repository});

  @override
  Future<CarregarUsuarioStatus> call() async {
    try {
      CarregarUsuarioStatus result = await repository.carregarUsuario();
      if (result == CarregarUsuarioStatus.success) {
        Stream<ResultadoUsuario> usuarioDados = result.successGet;
        ResultadoUsuario resultadoDados =
            await usuarioDados.map((event) => event).first;
        if (resultadoDados.nome.length > 0) {
          return result;
        }
        return CarregarUsuarioStatus.error
          ..errorSet = ErroInesperado(
              mensagem: "Erro ao carregar os dados do Usuario Cod.01-1");
      }
      return CarregarUsuarioStatus.error
        ..errorSet = ErroInesperado(
            mensagem: "Erro ao carregar os dados do Usuario Cod.01-2");
    } catch (e) {
      return CarregarUsuarioStatus.error
        ..errorSet = ErroInesperado(
          mensagem:
              "${e.toString()} - Erro ao carregar os dados do Usuario Cod.01-3",
        );
    }
  }
}
