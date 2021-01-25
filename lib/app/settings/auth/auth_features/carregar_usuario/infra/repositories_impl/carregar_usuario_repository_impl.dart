import 'package:meta/meta.dart';

import '../../../../../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../../../../erros/erros.dart';
import '../../domain/entities/resultado_usuario.dart';
import '../../domain/repositories/carregar_usuario_repository.dart';
import '../datasources/carregar_usuario_datasource.dart';

class CarregarUsuarioRepositoryImpl implements CarregarUsuarioRepository {
  final CarregarUsuarioDatasource datasource;

  CarregarUsuarioRepositoryImpl({required this.datasource});

  @override
  Future<RetornoSucessoOuErro<Stream<ResultadoUsuario>>>
      carregarUsuario() async {
    try {
      RetornoSucessoOuErro<Stream<ResultadoUsuario>> usuarioData =
          await datasource.carregarUsuario();

      if (usuarioData is SucessoRetorno<Stream<ResultadoUsuario>>) {
        return usuarioData;
      } else {
        return ErroRetorno(
          erro: ErroInesperado(
            mensagem: "Erro ao carregar os dados do Usuario - Cod.02-1",
          ),
        );
      }
    } catch (e) {
      return ErroRetorno(
          erro: ErroInesperado(
        mensagem:
            "${e.toString()} - Erro ao carregar os dados do Usuario - Cod.02-2",
      ));
    }
  }
}
