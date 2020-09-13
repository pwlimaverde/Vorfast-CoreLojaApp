import 'package:meta/meta.dart';
import '../repositories/signout_repository.dart';
import '../status/signout_usecase_status.dart';
import '../../../../../../shared/utilitario/erros.dart';

abstract class SignOutUsecase {
  Future<SignOutStatus> call();
}

class SignOutUsecaseImpl implements SignOutUsecase {
  final SignOutRepository repository;

  SignOutUsecaseImpl({@required this.repository});

  @override
  Future<SignOutStatus> call() async {
    try {
      SignOutStatus check = await repository.signOut();
      if (check == SignOutStatus.success) {
        if (check.successGet) {
          return check;
        }
        return SignOutStatus.error
          ..errorSet =
              ErroInesperado(mensagem: "Erro ao fazer o SignOut Cod.01-1");
      }
      return SignOutStatus.error
        ..errorSet =
            ErroInesperado(mensagem: "Erro ao fazer o SignOut Cod.01-2");
    } catch (e) {
      return SignOutStatus.error
        ..errorSet = ErroInesperado(
            mensagem: "${e.toString()} - Erro ao fazer o SignOut Cod.01-3");
    }
  }
}
