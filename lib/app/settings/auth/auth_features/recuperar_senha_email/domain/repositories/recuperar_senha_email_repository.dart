import 'package:meta/meta.dart';
import '../status/recuperar_senha_email_usecase_status.dart';

abstract class RecuperarSenhaEmailRepository {
  Future<RecuperarSenhaEmailStatus> recuperarSenhaEmail(
      {@required String email});
}
