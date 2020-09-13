import '../../domain/entities/resultado_usuario.dart';

abstract class CarregarUsuarioDatasource {
  Future<Stream<ResultadoUsuario>> carregarUsuario();
}
