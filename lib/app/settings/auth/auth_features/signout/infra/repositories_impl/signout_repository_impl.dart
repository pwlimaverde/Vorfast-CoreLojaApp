import 'package:meta/meta.dart';

import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../../../../erros/erros.dart';
import '../../domain/repositories/signout_repository.dart';
import '../datasources/signout_datasource.dart';

class SignOutRepositoryImpl implements SignOutRepository {
  final SignOutDatasource datasource;

  SignOutRepositoryImpl({required this.datasource});

  @override
  Future<RetornoSucessoOuErro> signOut() async {
    try {
      bool checkSignOut = await datasource.signOutFirebase();
      if (checkSignOut) {
        return SucessoRetorno<bool>(result: true);
      }
      return SucessoRetorno<bool>(result: false);
    } catch (e) {
      return ErrorRetorno(
        erro: ErroInesperado(
          mensagem: "${e.toString()} - Erro ao fazer o SignOut Cod.02-1",
        ),
      );
    }
  }
}
