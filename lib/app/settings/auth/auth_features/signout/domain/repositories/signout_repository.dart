import '../status/signout_usecase_status.dart';

abstract class SignOutRepository {
  Future<SignOutStatus> signOut();
}
