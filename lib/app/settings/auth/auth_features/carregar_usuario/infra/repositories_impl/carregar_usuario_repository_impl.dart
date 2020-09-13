import 'package:meta/meta.dart';
import '../../domain/entities/resultado_usuario.dart';
import '../../domain/repositories/carregar_usuario_repository.dart';
import '../../domain/status/carregar_usuario_usecase_status.dart';
import '../../../../../../shared/utilitario/erros.dart';
import '../datasources/carregar_usuario_datasource.dart';

class CarregarUsuarioRepositoryImpl implements CarregarUsuarioRepository {
  final CarregarUsuarioDatasource datasource;

  CarregarUsuarioRepositoryImpl({@required this.datasource});

  @override
  Future<CarregarUsuarioStatus> carregarUsuario() async {
    try {
      Stream<ResultadoUsuario> usuarioData = await datasource.carregarUsuario();
      if (await usuarioData.isEmpty || usuarioData == null) {
        return CarregarUsuarioStatus.error
          ..errorSet = ErroInesperado(
              mensagem: "Erro ao carregar os dados do Usuario - Cod.02-1");
      }
      return CarregarUsuarioStatus.success..successSet = usuarioData;
    } catch (e) {
      return CarregarUsuarioStatus.error
        ..errorSet = ErroInesperado(
          mensagem:
              "${e.toString()} - Erro ao carregar os dados do Usuario - Cod.02-2",
        );
    }
  }
}
