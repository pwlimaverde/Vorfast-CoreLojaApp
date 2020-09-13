import '../status/carregar_usuario_usecase_status.dart';

abstract class CarregarUsuarioRepository {
  Future<CarregarUsuarioStatus> carregarUsuario();
}
