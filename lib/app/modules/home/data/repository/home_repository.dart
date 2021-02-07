import 'package:corelojaapp/app/settings/core/core_presenter/core_presenter.dart';
import 'package:corelojaapp/app/settings/datasources/carregar_temas_package/datasource/model/firebase_resultado_theme_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';
//Importes Internos
import '../provider/api/home_api.dart';
import '../model/secao_model.dart';

class HomeRepository {
  final HomeApiClient apiClient;

  HomeRepository({@required this.apiClient}) : assert(apiClient != null);

  Stream<List<SecaoModel>> getAllSecao() {
    return apiClient.getAllSecao();
  }

  Future<FirebaseResultadoThemeModel> getThemeConfig() {
    return apiClient.getThemeConfig();
  }

  Future<void> saveCor({
    @required Map<String, int> cor,
    @required String key,
    @required auth.User user,
  }) {
    return apiClient.saveCor(
      cor: cor,
      key: key,
      user: user,
    );
  }

  Future<void> saveHeader({
    @required String doc,
    @required String nome,
    @required int prioridade,
    @required Map corHeader,
    @required auth.User user,
  }) {
    return apiClient.saveHeader(
      nome: nome,
      prioridade: prioridade,
      corHeader: corHeader,
      doc: doc,
      user: user,
    );
  }

  Future<void> saveImgGalery({
    @required FirebaseResultadoSecaoModel secao,
  }) {
    return apiClient.saveImgGalery(
      secao: secao,
    );
  }

  Future<void> saveImgLink({
    @required FirebaseResultadoSecaoModel secao,
    @required String link,
  }) {
    return apiClient.saveImgLink(
      link: link,
      secao: secao,
    );
  }
}
