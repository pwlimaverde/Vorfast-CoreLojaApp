import 'package:meta/meta.dart';

import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';

abstract class RecuperarSenhaEmailRepository {
  Future<RetornoSucessoOuErro<bool>> recuperarSenhaEmail(
      {required String email});
}
