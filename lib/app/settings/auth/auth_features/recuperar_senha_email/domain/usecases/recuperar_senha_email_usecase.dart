import 'package:meta/meta.dart';
import '../repositories/recuperar_senha_email_repository.dart';
import '../status/recuperar_senha_email_usecase_status.dart';
import '../../../../../../shared/utilitario/erros.dart';

abstract class RecuperarSenhaEmailUsecase {
  Future<RecuperarSenhaEmailStatus> call({@required String email});
}

class RecuperarSenhaEmailUsecaseImpl implements RecuperarSenhaEmailUsecase {
  final RecuperarSenhaEmailRepository repository;

  RecuperarSenhaEmailUsecaseImpl({@required this.repository});

  @override
  Future<RecuperarSenhaEmailStatus> call({@required String email}) async {
    try {
      RecuperarSenhaEmailStatus check =
          await repository.recuperarSenhaEmail(email: email);
      if (check == RecuperarSenhaEmailStatus.success) {
        if (check.successGet) {
          return check;
        }
        return RecuperarSenhaEmailStatus.error
          ..errorSet =
              ErroInesperado(mensagem: "Erro ao RecuperarSenhaEmail Cod.01-1");
      }
      return RecuperarSenhaEmailStatus.error
        ..errorSet =
            ErroInesperado(mensagem: "Erro ao RecuperarSenhaEmail Cod.01-2");
    } catch (e) {
      return RecuperarSenhaEmailStatus.error
        ..errorSet = ErroInesperado(
            mensagem: "${e.toString()} - Erro ao RecuperarSenhaEmail Cod.01-3");
    }
  }
}
