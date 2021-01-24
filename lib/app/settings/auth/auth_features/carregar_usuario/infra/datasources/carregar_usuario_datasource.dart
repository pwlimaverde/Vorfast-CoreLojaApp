import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../domain/entities/resultado_usuario.dart';

abstract class CarregarUsuarioDatasource {
  Future<RetornoSucessoOuErro<Stream<ResultadoUsuario>>> carregarUsuario();
}
