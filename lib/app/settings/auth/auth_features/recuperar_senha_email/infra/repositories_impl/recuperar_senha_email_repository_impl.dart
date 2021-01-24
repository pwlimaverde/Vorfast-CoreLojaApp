import 'package:meta/meta.dart';
import '../../../../../../shared/utilitario/erros.dart';
import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../domain/repositories/recuperar_senha_email_repository.dart';
import '../datasources/recuperar_senha_email_datasource.dart';

class RecuperarSenhaEmailRepositoryImpl
    implements RecuperarSenhaEmailRepository {
  final RecuperarSenhaEmailDatasource datasource;

  RecuperarSenhaEmailRepositoryImpl({@required this.datasource});

  @override
  Future<RetornoSucessoOuErro> recuperarSenhaEmail(
      {@required String email}) async {
    try {
      bool recuperarSenhaEmail =
          await datasource.recuperarSenhaEmailFirebase(email: email);
      if (recuperarSenhaEmail) {
        return SucessoResultado<bool>(result: true);
      }
      return SucessoResultado<bool>(result: false);
    } catch (e) {
      return ErrorResultado(
        error: ErroInesperado(
            mensagem: "${e.toString()} - Erro ao RecuperarSenhaEmail Cod.02-1"),
      );
    }
  }
}
