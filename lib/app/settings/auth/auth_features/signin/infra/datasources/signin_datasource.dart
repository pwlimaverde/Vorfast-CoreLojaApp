import '../../../../../auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';

abstract class SignInDatasource {
  Future<bool> call({
    String email,
    String pass,
    ResultadoUsuario user,
  });
}
