import 'package:meta/meta.dart';

import '../../../../../../shared/utilitario/erros.dart';
import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../../../../../shared/utilitario/usecase.dart';
import '../entities/resultado_usuario.dart';
import '../repositories/carregar_usuario_repository.dart';

class CarregarUsuarioUsecase
    implements UseCase<Stream<ResultadoUsuario>, NoParams> {
  final CarregarUsuarioRepository repository;

  CarregarUsuarioUsecase({@required this.repository});

  @override
  Future<RetornoSucessoOuErro<Stream<ResultadoUsuario>>> call(
      NoParams parametros) async {
    try {
      RetornoSucessoOuErro<Stream<ResultadoUsuario>> result =
          await repository.carregarUsuario();
      if (result is SucessoResultado<Stream<ResultadoUsuario>>) {
        return result;
      } else {
        return ErrorResultado(
          error: ErroInesperado(
            mensagem: "Erro ao carregar os dados do Usuario Cod.01-1",
          ),
        );
      }
    } catch (e) {
      return ErrorResultado(
        error: ErroInesperado(
          mensagem:
              "${e.toString()} - Erro ao carregar os dados do Usuario Cod.01-2",
        ),
      );
    }
  }
}