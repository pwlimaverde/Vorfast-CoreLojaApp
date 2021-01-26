import 'package:meta/meta.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import '../../domain/repositories/signout_repository.dart';
import '../datasources/signout_datasource.dart';

class SignOutRepositoryImpl implements SignOutRepository {
  final SignOutDatasource datasource;

  SignOutRepositoryImpl({@required this.datasource});

  @override
  Future<RetornoSucessoOuErro> signOut() async {
    try {
      bool checkSignOut = await datasource.signOutFirebase();
      if (checkSignOut) {
        return SucessoRetorno<bool>(resultado: true);
      }
      return SucessoRetorno<bool>(resultado: false);
    } catch (e) {
      return ErroRetorno(
        erro: ErroInesperado(
          mensagem: "${e.toString()} - Erro ao fazer o SignOut Cod.02-1",
        ),
      );
    }
  }
}
