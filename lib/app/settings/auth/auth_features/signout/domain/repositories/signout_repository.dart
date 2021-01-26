import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

abstract class SignOutRepository {
  Future<RetornoSucessoOuErro> signOut();
}
