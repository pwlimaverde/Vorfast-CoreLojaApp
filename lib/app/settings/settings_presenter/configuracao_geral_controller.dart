import 'package:auth_google_package/auth_google_package.dart';
import 'package:carregar_empresa_package/carregar_empresa_package.dart';
import 'package:carregar_temas_package/carregar_temas_package.dart';
import 'package:checar_coneccao_plugin/checar_coneccao_plugin.dart';
import 'package:corelojaapp/app/settings/datasources/auth_google_package/carregar_usuario/model/firebase_resultado_usuario_model.dart';
import 'package:corelojaapp/app/settings/datasources/carregar_empresa_package/model/firebase_resultado_empresa_model.dart';
import 'package:corelojaapp/app/settings/datasources/carregar_temas_package/datasource/model/firebase_resultado_theme_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:connectivity/connectivity.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
//Importes Internos
import '../auth/auth_presenter/auth_presenter.dart';
import '../core/core_presenter/core_presenter.dart';
import 'drawer/ui/drawer_core_widget.dart';

class ConfiguracaoGeralController extends GetxController {
  final Connectivity onconnect;
  final CarregarTemasPresenter carregarThemePresenter;
  final ChecarConeccaoPresenter checarConeccaoPresenter;
  final CarregarEmpresaPresenter carregarEmpresaPresenter;
  final CarregarUsuarioPresenter carregarUsuarioPresenter;
  final RecuperarSenhaEmailPresenter recuperarSenhaEmailPresenter;
  final SignOutPresenter signOutPresenter;
  final CarregarSecaoUsecase carregarSecao;
  final SignInUsecase signInGoogleUsecase;
  final SignInUsecase signInEmailUsecase;
  final SignInUsecase novoEmailUsecase;
  ConfiguracaoGeralController({
    @required this.carregarThemePresenter,
    @required this.checarConeccaoPresenter,
    @required this.onconnect,
    @required this.carregarSecao,
    @required this.carregarEmpresaPresenter,
    @required this.carregarUsuarioPresenter,
    @required this.signOutPresenter,
    @required this.signInGoogleUsecase,
    @required this.signInEmailUsecase,
    @required this.novoEmailUsecase,
    @required this.recuperarSenhaEmailPresenter,
  }) : assert(carregarThemePresenter != null &&
            checarConeccaoPresenter != null &&
            onconnect != null &&
            carregarSecao != null);

  @override
  void onInit() {
    super.onInit();
    _carregarSettingsTheme();
    _getAllSecao();
    _carregarEmpresa();
    _carregarUsuario();

    onconnect.onConnectivityChanged.listen((event) {
      _getCon();
    });

    this.fireTheme.listen((event) {
      _apiThemeApp(model: event);
    });
  }

  //Controller Auth
  final _usuarioFirebase = FirebaseResultadoUsuarioModel().obs;
  get usuarioFirebase => this._usuarioFirebase;
  FirebaseResultadoUsuarioModel get usuarioFirebaseValue =>
      this._usuarioFirebase.value;
  set usuarioFirebase(value) => this._usuarioFirebase.bindStream(value);

  Future<RetornoSucessoOuErro> singOut() async {
    final result = await signOutPresenter.signOut();
    if (result is SucessoRetorno<bool>) {
      this.usuarioFirebaseValue.cleanUser();
    }
    return result;
  }

  Future<RetornoSucessoOuErro> recuperarSenha({@required String email}) async {
    final result = await recuperarSenhaEmailPresenter.recuperarSenhaEmail(
        parametros: ParametrosRecuperarSenhaEmail(email: email));
    return result;
  }

  Future<RetornoSucessoOuErro> signInGoogleLogin() async {
    singOut();
    RetornoSucessoOuErro result =
        await signInGoogleUsecase().then((value) async {
      await _carregarUsuario();
      return value;
    });
    return result;
  }

  Future<RetornoSucessoOuErro> signInEmailLogin({
    @required String email,
    @required String pass,
  }) async {
    singOut();
    return await signInEmailUsecase(
      email: email,
      pass: pass,
    ).then((value) async {
      await _carregarUsuario();
      return value;
    });
  }

  Future<RetornoSucessoOuErro> novoEmailLogin({
    @required FirebaseResultadoUsuarioModel user,
    @required String pass,
  }) async {
    singOut();
    return novoEmailUsecase(
      user: user,
      pass: pass,
    ).then((value) async {
      await _carregarUsuario();
      return value;
    });
  }

  //Auth Funções Internas
  _carregarUsuario() async {
    final usuarioLogado = await carregarUsuarioPresenter.carregarUsuario();
    if (usuarioLogado is SucessoRetorno) {
      Stream<FirebaseResultadoUsuarioModel> usuario = usuarioLogado.fold(
          sucesso: (value) => value.resultado, erro: (erro) => erro.erro);
      this.usuarioFirebase = usuario;
    }
  }

  //Controller institucional
  final _empresaFirebase = FirebaseResultadoEmpresaModel().obs;
  get empresaFirebase => this._empresaFirebase;
  FirebaseResultadoEmpresaModel get empresaFirebaseValue =>
      this._empresaFirebase.value;
  set empresaFirebase(value) => this._empresaFirebase.bindStream(value);

  final _mostrarNomeEmpresa = false.obs;
  bool get mostrarNomeEmpresa => this._mostrarNomeEmpresa.value;
  set mostrarNomeEmpresa(value) => this._mostrarNomeEmpresa.value = value;

  //Institucional Funções Internas
  void _carregarEmpresa() async {
    final result = await carregarEmpresaPresenter.carregarEmpresa();
    if (result is SucessoRetorno) {
      Stream<FirebaseResultadoEmpresaModel> empresa = result.fold(
          sucesso: (value) => value.resultado, erro: (erro) => erro.erro);
      this.empresaFirebase = empresa;
    }
  }

  //Institucional Widget
  Widget getDrawerCoreWidget({int page}) {
    return DrawerCoreWidget(
      page: page,
    );
  }

  //Controller de Conexão
  final _estaConectado = false.obs;
  bool get estaConectado => this._estaConectado.value;
  set estaConectado(value) => this._estaConectado.value = value;

  void _getCon() async {
    RetornoSucessoOuErro<bool> testeConexao =
        await checarConeccaoPresenter.consultaConectividade();
    if (testeConexao is SucessoRetorno<bool>) {
      this.estaConectado = testeConexao.resultado;
    } else {
      this.estaConectado = false;
    }

    _mostrarConeccao();
  }

  //Conexão Funções Internas
  //Snackbar falha de conexão
  void _mostrarConeccao() {
    if (estaConectado == false) {
      Get.snackbar(
        'Desculpe',
        'Não foi possível estabelecer a conexão',
        icon: Icon(FontAwesomeIcons.meh),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  //Controller das Seções
  final _todasSecoes = List<FirebaseResultadoSecaoModel>().obs;
  List<FirebaseResultadoSecaoModel> get todasSecoes => this._todasSecoes;
  set todasSecoes(value) => this._todasSecoes.bindStream(value);

  //Seção Funções Internas
  //Carregamento de Seção
  Future<void> _getAllSecao() async {
    CarregarSecaoStatus result = await carregarSecao();
    if (result == CarregarSecaoStatus.success) {
      this.todasSecoes = result.successGet;
    }
  }

  //Controller Theme
  final _loadCompletoDoTema = false.obs;
  bool get loadCompletoDoTema => this._loadCompletoDoTema.value;
  set loadCompletoDoTema(value) => this._loadCompletoDoTema.value = value;

  final _fireTheme = FirebaseResultadoThemeModel().obs;
  get fireTheme => this._fireTheme;
  FirebaseResultadoThemeModel get fireThemeValue => this._fireTheme.value;
  set fireTheme(value) => this._fireTheme.bindStream(value);

  //Theme Funções Internas
  //Carregar Theme
  void _carregarSettingsTheme() async {
    final result = await carregarThemePresenter.carregarTemas();
    if (result is SucessoRetorno) {
      Stream<FirebaseResultadoThemeModel> tema = result.fold(
          sucesso: (value) => value.resultado, erro: (erro) => erro.erro);
      this.fireTheme = tema;
    }
  }

  //Aplicação do tema carregado
  void _apiThemeApp({FirebaseResultadoThemeModel model}) {
    final box = GetStorage();
    box.write("tema", model.toJson());
    Get.changeTheme(
      ThemeData(
        primaryColor: Color.fromRGBO(
          model.primary["r"],
          model.primary["g"],
          model.primary["b"],
          1.0,
        ),
        accentColor: Color.fromRGBO(
          model.accent["r"],
          model.accent["g"],
          model.accent["b"],
          1.0,
        ),
      ),
    );
    Future.delayed(Duration(milliseconds: 500))
        .then((_) => loadCompletoDoTema = true);
  }
}
