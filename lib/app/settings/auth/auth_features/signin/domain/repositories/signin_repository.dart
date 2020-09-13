import '../../../../../auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';
import '../status/signin_usecase_status.dart';

abstract class SignInRepository {
  Future<SignInStatus> signIn({
    String email,
    String pass,
    ResultadoUsuario user,
  });
}
