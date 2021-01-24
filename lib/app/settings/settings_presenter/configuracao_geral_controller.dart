import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

//Importes Internos
import '../../shared/utilitario/resultado_sucesso_ou_error.dart';
import '../../shared/utilitario/usecase.dart';
import '../auth/auth_presenter/auth_presenter.dart';
import '../configuracao_geral/configuracao_geral_presenter/configuracao_geral_presenter.dart';
import '../core/core_presenter/core_presenter.dart';
import '../institucional/institucional_presenter/institucional_presenter.dart';
import 'drawer/ui/drawer_core_widget.dart';

class ConfiguracaoGeralController extends GetxController {
  final Connectivity onconnect;
  final CarregarThemeUsecase carregarTheme;
  final ChecarConeccaoUsecase checarConeccao;
  final CarregarSecaoUsecase carregarSecao;
  final CarregarEmpresaUsecase carregarEmpresa;
  final CarregarUsuarioUsecase carregarUsuario;
  final SignOutUsecase signOutUsecase;
  final SignInUsecase signInGoogleUsecase;
  final SignInUsecase signInEmailUsecase;
  final SignInUsecase novoEmailUsecase;
  final RecuperarSenhaEmailUsecase recuperarSenhaEmailLoginUsecase;
  ConfiguracaoGeralController({
    required this.carregarTheme,
    required this.checarConeccao,
    required this.onconnect,
    required this.carregarSecao,
    required this.carregarEmpresa,
    required this.carregarUsuario,
    required this.signOutUsecase,
    required this.signInGoogleUsecase,
    required this.signInEmailUsecase,
    required this.novoEmailUsecase,
    required this.recuperarSenhaEmailLoginUsecase,
  }) : assert(carregarTheme != null &&
            checarConeccao != null &&
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
    return await signOutUsecase().then((value) {
      if (value is SucessoRetorno<bool>) {
        this.usuarioFirebaseValue.cleanUser();
      }
      return value;
    });
  }

  Future<RetornoSucessoOuErro> recuperarSenha({required String email}) async {
    return await recuperarSenhaEmailLoginUsecase(email: email);
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
    required String email,
    required String pass,
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
    required FirebaseResultadoUsuarioModel user,
    required String pass,
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
    RetornoSucessoOuErro usuarioLogado = await carregarUsuario(NoParams());
    if (usuarioLogado is SucessoRetorno) {
      this.usuarioFirebase = usuarioLogado.resultado;
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
    RetornoSucessoOuErro result = await carregarEmpresa(NoParams());
    if (result is SucessoRetorno) {
      this.empresaFirebase = result.resultado;
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
    RetornoSucessoOuErro<bool> testeConexao = await checarConeccao(NoParams());
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
    RetornoSucessoOuErro result = await carregarTheme(NoParams());
    if (result is SucessoRetorno) {
      this.fireTheme = result.resultado;
    }
  }

  //Aplicação do tema carregado
  void _apiThemeApp({FirebaseResultadoThemeModel model}) {
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
