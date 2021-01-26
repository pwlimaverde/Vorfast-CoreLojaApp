import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../../../../../auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';

abstract class SignInRepository {
  Future<RetornoSucessoOuErro> signIn({
    String email,
    String pass,
    ResultadoUsuario user,
  });
}
