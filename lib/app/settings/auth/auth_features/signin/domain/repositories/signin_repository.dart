import '../../../../../auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';
import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';

abstract class SignInRepository {
  Future<RetornoSucessoOuErro> signIn({
    String email,
    String pass,
    ResultadoUsuario user,
  });
}
