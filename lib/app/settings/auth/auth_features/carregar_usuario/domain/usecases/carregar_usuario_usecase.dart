import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
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
      if (result is SucessoRetorno<Stream<ResultadoUsuario>>) {
        return result;
      } else {
        return ErroRetorno(
          erro: ErroInesperado(
            mensagem: "Erro ao carregar os dados do Usuario Cod.01-1",
          ),
        );
      }
    } catch (e) {
      return ErroRetorno(
        erro: ErroInesperado(
          mensagem:
              "${e.toString()} - Erro ao carregar os dados do Usuario Cod.01-2",
        ),
      );
    }
  }
}
