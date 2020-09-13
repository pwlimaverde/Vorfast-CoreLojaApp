import 'package:meta/meta.dart';
import '../../../../../../shared/utilitario/erros.dart';
import '../../domain/status/signout_usecase_status.dart';
import '../../domain/repositories/signout_repository.dart';
import '../datasources/signout_datasource.dart';

class SignOutRepositoryImpl implements SignOutRepository {
  final SignOutDatasource datasource;

  SignOutRepositoryImpl({@required this.datasource});

  @override
  Future<SignOutStatus> signOut() async {
    try {
      await datasource.signOutFirebase();
      return SignOutStatus.success..successSet = true;
    } catch (e) {
      return SignOutStatus.error
        ..errorSet = ErroInesperado(
            mensagem: "${e.toString()} - Erro ao fazer o SignOut Cod.02-1");
    }
  }
}
