import 'package:meta/meta.dart';
import '../../../../../../shared/utilitario/erros.dart';
import '../../domain/status/recuperar_senha_email_usecase_status.dart';
import '../../domain/repositories/recuperar_senha_email_repository.dart';
import '../datasources/recuperar_senha_email_datasource.dart';

class RecuperarSenhaEmailRepositoryImpl
    implements RecuperarSenhaEmailRepository {
  final RecuperarSenhaEmailDatasource datasource;

  RecuperarSenhaEmailRepositoryImpl({@required this.datasource});

  @override
  Future<RecuperarSenhaEmailStatus> recuperarSenhaEmail(
      {@required String email}) async {
    try {
      bool estaRecuperarSenhaEmail =
          await datasource.recuperarSenhaEmailFirebase(email: email);
      if (estaRecuperarSenhaEmail) {
        return RecuperarSenhaEmailStatus.success..successSet = true;
      }
      return RecuperarSenhaEmailStatus.success..successSet = false;
    } catch (e) {
      return RecuperarSenhaEmailStatus.error
        ..errorSet = ErroInesperado(
            mensagem: "${e.toString()} - Erro ao RecuperarSenhaEmail Cod.02-1");
    }
  }
}
