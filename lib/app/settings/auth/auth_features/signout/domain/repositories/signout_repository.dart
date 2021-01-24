import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';

abstract class SignOutRepository {
  Future<RetornoSucessoOuErro> signOut();
}
