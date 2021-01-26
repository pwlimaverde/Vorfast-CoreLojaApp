import '../../domain/entities/resultado_anuncio.dart';

abstract class CarregarAnuncioDatasource {
  Stream<List<ResultadoAnuncio>> getAnuncio();
}
