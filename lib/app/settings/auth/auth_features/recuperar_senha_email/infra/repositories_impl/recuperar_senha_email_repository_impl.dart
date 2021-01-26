import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import '../../domain/repositories/recuperar_senha_email_repository.dart';
import '../datasources/recuperar_senha_email_datasource.dart';

class RecuperarSenhaEmailRepositoryImpl
    implements RecuperarSenhaEmailRepository {
  final RecuperarSenhaEmailDatasource datasource;

  RecuperarSenhaEmailRepositoryImpl({@required this.datasource});

  @override
  Future<RetornoSucessoOuErro<bool>> recuperarSenhaEmail(
      {@required String email}) async {
    try {
      bool recuperarSenhaEmail =
          await datasource.recuperarSenhaEmailFirebase(email: email);
      if (recuperarSenhaEmail) {
        return SucessoRetorno<bool>(resultado: true);
      }
      return SucessoRetorno<bool>(resultado: false);
    } catch (e) {
      return ErroRetorno(
        erro: ErroInesperado(
            mensagem: "${e.toString()} - Erro ao RecuperarSenhaEmail Cod.02-1"),
      );
    }
  }
}
