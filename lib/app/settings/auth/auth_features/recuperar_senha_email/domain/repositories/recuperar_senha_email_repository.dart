import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

abstract class RecuperarSenhaEmailRepository {
  Future<RetornoSucessoOuErro<bool>> recuperarSenhaEmail(
      {required String email});
}
