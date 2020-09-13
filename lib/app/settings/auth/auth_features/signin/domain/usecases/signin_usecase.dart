import 'package:meta/meta.dart';
import '../../../../../auth/auth_features/carregar_usuario/domain/entities/resultado_usuario.dart';
import '../repositories/signin_repository.dart';
import '../status/signin_usecase_status.dart';
import '../../../../../../shared/utilitario/erros.dart';

abstract class SignInUsecase {
  Future<SignInStatus> call({
    String email,
    String pass,
    ResultadoUsuario user,
  });
}

class SignInUsecaseImpl implements SignInUsecase {
  final SignInRepository repository;

  SignInUsecaseImpl({@required this.repository});

  @override
  Future<SignInStatus> call({
    String email,
    String pass,
    ResultadoUsuario user,
  }) async {
    try {
      SignInStatus check = await repository.signIn(
        email: email,
        pass: pass,
        user: user,
      );
      if (check == SignInStatus.success) {
        if (check.successGet) {
          return check;
        }
        return SignInStatus.error
          ..errorSet =
              ErroInesperado(mensagem: "Erro ao fazer o SignIn Cod.01-1");
      }
      return SignInStatus.error
        ..errorSet =
            ErroInesperado(mensagem: "Erro ao fazer o SignIn Cod.01-2");
    } catch (e) {
      return SignInStatus.error
        ..errorSet = ErroInesperado(
            mensagem: "${e.toString()} - Erro ao fazer o SignIn Cod.01-3");
    }
  }
}
