import 'package:meta/meta.dart';

abstract class RecuperarSenhaEmailDatasource {
  Future<bool> recuperarSenhaEmailFirebase({required String email});
}
