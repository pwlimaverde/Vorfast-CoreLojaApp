import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../entities/resultado_usuario.dart';

abstract class CarregarUsuarioRepository {
  Future<RetornoSucessoOuErro<Stream<ResultadoUsuario>>> carregarUsuario();
}
