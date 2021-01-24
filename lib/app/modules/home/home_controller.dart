import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../settings/auth/auth_presenter/auth_presenter.dart';
import '../../settings/core/core_presenter/core_presenter.dart';
import '../../settings/settings_presenter/configuracao_geral_controller.dart';
import '../../shared/utilitario/app_status.dart';
import '../../shared/widgets/widgets_core.dart' as widgetCore;
//Importes Internos
import 'data/repository/home_repository.dart';
import 'ui/componentes/anuncios_build/anuncios_build_widget.dart';
import 'ui/componentes/card_edit_cor/card_edit_cor_widget.dart';
import 'ui/componentes/container_edit_cor/container_edit_cor_widget.dart';
import 'ui/componentes/preview_edit_cor/preview_edit_cor_widget.dart';

class HomeController extends GetxController {
  // final AuthController authController;
  final HomeRepository repo;
  final ConfiguracaoGeralController configuracaoGeralController;

  HomeController({
    required this.repo,
    required this.configuracaoGeralController,
  }) : assert(
          repo != null && configuracaoGeralController != null,
        );

  @override
  void onInit() {
    super.onInit();
    _carregarConfiguracoesTheme();
  }

  final coresPrimaryFormKey = GlobalKey<FormState>();
  final coresAccentFormKey = GlobalKey<FormState>();
  final coresHeaderFormKey = GlobalKey<FormState>();

  final primaryRController = TextEditingController();
  final primaryGController = TextEditingController();
  final primaryBController = TextEditingController();

  final accentRController = TextEditingController();
  final accentGController = TextEditingController();
  final accentBController = TextEditingController();

  final headerRController = TextEditingController();
  final headerGController = TextEditingController();
  final headerBController = TextEditingController();
  final headerAController = TextEditingController();
  final headerLinkController = TextEditingController();
  final headerNomeController = TextEditingController();
  final headerPrioridadeController = TextEditingController();

  //Controles Gerais
  FirebaseResultadoUsuarioModel get user =>
      configuracaoGeralController.usuarioFirebaseValue;

  //Controles Internos
  //Troca de cores Primary
  final _primaryREditValido = 256.obs;
  int get primaryREditValido => this._primaryREditValido.value;
  set primaryREditValido(value) => this._primaryREditValido.value = value;

  final _primaryGEditValido = 256.obs;
  int get primaryGEditValido => this._primaryGEditValido.value;
  set primaryGEditValido(value) => this._primaryGEditValido.value = value;

  final _primaryBEditValido = 256.obs;
  int get primaryBEditValido => this._primaryBEditValido.value;
  set primaryBEditValido(value) => this._primaryBEditValido.value = value;

  bool get isPrimary {
    return primaryREditValido != 256 &&
        primaryGEditValido != 256 &&
        primaryBEditValido != 256;
  }

  Color get corPrymary {
    return Color.fromRGBO(
      primaryREditValido,
      primaryGEditValido,
      primaryBEditValido,
      1.0,
    );
  }

  //Troca de cores Accent
  final _accentREditValido = 256.obs;
  int get accentREditValido => this._accentREditValido.value;
  set accentREditValido(value) => this._accentREditValido.value = value;

  final _accentGEditValido = 256.obs;
  int get accentGEditValido => this._accentGEditValido.value;
  set accentGEditValido(value) => this._accentGEditValido.value = value;

  final _accentBEditValido = 256.obs;
  int get accentBEditValido => this._accentBEditValido.value;
  set accentBEditValido(value) => this._accentBEditValido.value = value;

  bool get isAccent {
    return accentREditValido != 256 &&
        accentGEditValido != 256 &&
        accentBEditValido != 256;
  }

  Color get corAccent {
    return Color.fromRGBO(
      accentREditValido,
      accentGEditValido,
      accentBEditValido,
      1.0,
    );
  }

  //Troca dados Header
  final _headerREditValido = 256.obs;
  int get headerREditValido => this._headerREditValido.value;
  set headerREditValido(value) => this._headerREditValido.value = value;

  final _headerGEditValido = 256.obs;
  int get headerGEditValido => this._headerGEditValido.value;
  set headerGEditValido(value) => this._headerGEditValido.value = value;

  final _headerBEditValido = 256.obs;
  int get headerBEditValido => this._headerBEditValido.value;
  set headerBEditValido(value) => this._headerBEditValido.value = value;

  final _headerAEditValido = 256.obs;
  int get headerAEditValido => this._headerAEditValido.value;
  set headerAEditValido(value) => this._headerAEditValido.value = value;

  final _headerNomeEditValido = "".obs;
  String get headerNomeEditValido => this._headerNomeEditValido.value;
  set headerNomeEditValido(value) => this._headerNomeEditValido.value = value;

  final _headerPrioridadeEditValido = 0.obs;
  int get headerPrioridadeEditValido => this._headerPrioridadeEditValido.value;
  set headerPrioridadeEditValido(value) =>
      this._headerPrioridadeEditValido.value = value;

  bool get isHeader {
    return headerREditValido != 256 &&
        headerGEditValido != 256 &&
        headerBEditValido != 256 &&
        headerAEditValido != 256 &&
        headerNomeEditValido != "" &&
        headerPrioridadeEditValido != 0 &&
        headerPrioridadeController.text != "";
  }

  Color get corHeader {
    return Color.fromARGB(
      headerAEditValido,
      headerREditValido,
      headerGEditValido,
      headerBEditValido,
    );
  }

  //Controlles Page
  final _statusGeralAtual = AppStatus.none.obs;
  AppStatus get statusGeralAtual => this._statusGeralAtual.value;
  set statusGeralAtual(value) => this._statusGeralAtual.value = value;

  List<FirebaseResultadoSecaoModel> get todasSecoes =>
      configuracaoGeralController.todasSecoes;

  final _isEditeMode = false.obs;
  bool get isEditeMode => this._isEditeMode.value;
  set isEditeMode(value) => this._isEditeMode.value = value;

  List<Widget> get listSlv {
    List<Widget> slv = List<Widget>();
    slv.insert(
        0,
        widgetCore.SlvAppbarWidget(
          backgroundColor: Colors.transparent,
          editButton: widgetCore.EditbuttonCoreWidget(
            isEditeMode: isEditeMode,
            onPressedEdit: () {
              isEditeMode = !isEditeMode;
            },
            onPressedcheck: () {
              isEditeMode = !isEditeMode;
            },
          ),
          title: "VorFast",
          isAdmin: user.administrador,
        ));
    slv.add(widgetCore.SlvAdapterWidget(
      adapter: SizedBox(
        height: 20,
      ),
    ));
    for (FirebaseResultadoSecaoModel secao in todasSecoes) {
      slv.add(widgetCore.SlvHeaderWidget(
        secao: secao,
        color: Color.fromARGB(
          secao.cor["a"],
          secao.cor["r"],
          secao.cor["g"],
          secao.cor["b"],
        ),
      ));
      slv.add(widgetCore.SlvAdapterWidget(
        adapter: SizedBox(
          height: 3,
        ),
      ));
      slv.add(AnunciosBuildWidget(
        secao: secao,
      ));
      slv.add(widgetCore.SlvAdapterWidget(
        adapter: SizedBox(
          height: 3,
        ),
      ));
    }
    return slv;
  }

  List<Widget> get listSlvEdit {
    List<Widget> slv = List<Widget>();
    slv.insert(
        0,
        widgetCore.SlvAppbarWidget(
          backgroundColor: Colors.transparent,
          editButton: widgetCore.EditbuttonCoreWidget(
            isEditeMode: isEditeMode,
            onPressedEdit: () {
              isEditeMode = !isEditeMode;
            },
            onPressedcheck: () {
              saveCor();
              isEditeMode = !isEditeMode;
            },
          ),
          title: "VorFast Edit",
          isAdmin: user.administrador,
        ));
    slv.add(CardEditCorWidget(
      keyForm: coresPrimaryFormKey,
      title: "Edição das Cores Primarias",
      validador: validatorCor,
      onChangedR: (value) => primaryREditValido = value,
      onChangedG: (value) => primaryGEditValido = value,
      onChangedB: (value) => primaryBEditValido = value,
      controllerR: primaryRController,
      controllerG: primaryGController,
      controllerB: primaryBController,
      previewCor: PreviewEditCorWidget(
        cor: isPrimary ? corPrymary : Get.theme.primaryColor,
        title: isPrimary ? "Cor nova" : "Cor atual",
      ),
    ));
    slv.add(CardEditCorWidget(
      keyForm: coresAccentFormKey,
      title: "Edição das Cores Secundarias",
      validador: validatorCor,
      onChangedR: (value) => accentREditValido = value,
      onChangedG: (value) => accentGEditValido = value,
      onChangedB: (value) => accentBEditValido = value,
      controllerR: accentRController,
      controllerG: accentGController,
      controllerB: accentBController,
      previewCor: PreviewEditCorWidget(
        cor: isAccent ? corAccent : Get.theme.accentColor,
        title: isAccent ? "Cor nova" : "Cor atual",
      ),
    ));
    for (FirebaseResultadoSecaoModel secao in todasSecoes) {
      slv.add(widgetCore.SlvHeaderWidget(
        onTap: () {
          headerRController.text = secao.cor["r"].toString();
          headerGController.text = secao.cor["g"].toString();
          headerBController.text = secao.cor["b"].toString();
          headerAController.text = secao.cor["a"].toString();
          headerLinkController.text = secao.img.toString();
          headerNomeController.text = secao.nome.toString();
          headerPrioridadeController.text = secao.prioridade.toString();
          headerREditValido = secao.cor["r"];
          headerGEditValido = secao.cor["g"];
          headerBEditValido = secao.cor["b"];
          headerAEditValido = secao.cor["a"];
          headerNomeEditValido = secao.nome;
          headerPrioridadeEditValido = secao.prioridade;
          Get.bottomSheet(Obx(() {
            return Container(
              height: 280,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: widgetCore.FieldCoreWidget(
                            controller: headerNomeController,
                            label: "Nome da Seção",
                            hint: "Insira o nome da seção.",
                            onChanged: (value) => headerNomeEditValido = value,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: widgetCore.FieldCoreWidget(
                            controller: headerPrioridadeController,
                            keyBoard: TextInputType.number,
                            label: "Posição",
                            onChanged: (value) =>
                                headerPrioridadeEditValido = int.parse(value),
                          ),
                        ),
                      ),
                      widgetCore.EditbuttonCoreWidget(
                        isEditeMode: isEditeMode,
                        onPressedEdit: () {},
                        onPressedcheck: () {
                          saveHeader(doc: secao.reference.id);
                        },
                      ),
                    ],
                  ),
                  ContainerEditCorWidget(
                    keyForm: coresHeaderFormKey,
                    title: "Edição das Cores Header ${secao.nome}",
                    validador: validatorCor,
                    onChangedR: (value) => headerREditValido = value,
                    onChangedG: (value) => headerGEditValido = value,
                    onChangedB: (value) => headerBEditValido = value,
                    onChangedA: (value) => headerAEditValido = value,
                    controllerR: headerRController,
                    controllerG: headerGController,
                    controllerB: headerBController,
                    controllerA: headerAController,
                    previewCor: PreviewEditCorWidget(
                      cor: isHeader
                          ? corHeader
                          : Color.fromARGB(secao.cor["a"], secao.cor["r"],
                              secao.cor["g"], secao.cor["b"]),
                      title: isHeader ? "Cor nova" : "Cor atual",
                    ),
                  ),
                  widgetCore.FlatbuttonCoreWidget(
                    padding: 4.0,
                    fontSize: 13,
                    title: "Upload de Imagem da Galeria",
                    onPressed: () {
                      repo.saveImgGalery(secao: secao);
                    },
                  ),
                  widgetCore.FlatbuttonCoreWidget(
                    padding: 4.0,
                    fontSize: 13,
                    title: "Upload de Imagem via Link",
                    onPressed: () {
                      Get.defaultDialog(
                        onConfirm: () {
                          repo.saveImgLink(
                              secao: secao, link: headerLinkController.text);
                          Get.back();
                        },
                        onCancel: () {},
                        content: Container(
                          height: 100,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: widgetCore.FieldCoreWidget(
                                  controller: headerLinkController,
                                  label: "Link da imagem",
                                  hint: "Insira o Link da Imagem.",
                                ),
                              ),
                              Text("Upload de Imagem via Link"),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }));
        },
        secao: secao,
        color: Color.fromARGB(
          secao.cor["a"],
          secao.cor["r"],
          secao.cor["g"],
          secao.cor["b"],
        ),
      ));

      slv.add(AnunciosBuildWidget(
        secao: secao,
      ));
    }
    return slv;
  }

  //Funcoes Internas

  void _carregarConfiguracoesTheme() {
    primaryRController.text =
        configuracaoGeralController.fireThemeValue.primary["r"].toString();
    primaryGController.text =
        configuracaoGeralController.fireThemeValue.primary["g"].toString();
    primaryBController.text =
        configuracaoGeralController.fireThemeValue.primary["b"].toString();
    primaryREditValido =
        configuracaoGeralController.fireThemeValue.primary["r"];
    primaryGEditValido =
        configuracaoGeralController.fireThemeValue.primary["g"];
    primaryBEditValido =
        configuracaoGeralController.fireThemeValue.primary["b"];

    accentRController.text =
        configuracaoGeralController.fireThemeValue.accent["r"].toString();
    accentGController.text =
        configuracaoGeralController.fireThemeValue.accent["g"].toString();
    accentBController.text =
        configuracaoGeralController.fireThemeValue.accent["b"].toString();
    accentREditValido = configuracaoGeralController.fireThemeValue.accent["r"];
    accentGEditValido = configuracaoGeralController.fireThemeValue.accent["g"];
    accentBEditValido = configuracaoGeralController.fireThemeValue.accent["b"];
  }

  String validatorCor(text) {
    if (text.isEmpty || int.parse(text) > 255) {
      return "Valor inválido";
    } else {
      return null;
    }
  }

  Future<void> saveCor() async {
    if (isPrimary) {
      await repo.saveCor(
        key: "primary",
        cor: {
          "r": primaryREditValido,
          "g": primaryGEditValido,
          "b": primaryBEditValido,
        },
        user: user.currentUser,
      );
    }
    if (isAccent) {
      await repo.saveCor(
        key: "accent",
        cor: {
          "r": accentREditValido,
          "g": accentGEditValido,
          "b": accentBEditValido,
        },
        user: user.currentUser,
      );
    }
  }

  Future<void> saveHeader({required String doc}) async {
    if (isHeader) {
      Get.back();
      await repo.saveHeader(
        doc: doc,
        nome: headerNomeController.text,
        prioridade: int.parse(headerPrioridadeController.text),
        corHeader: {
          "r": headerREditValido,
          "g": headerGEditValido,
          "b": headerBEditValido,
          "a": headerAEditValido,
        },
        user: user.currentUser,
      );
      _apagarDadosHeader();
    }
  }

  void _apagarDadosHeader() {
    headerRController.clear();
    headerGController.clear();
    headerBController.clear();
    headerAController.clear();
    headerLinkController.clear();
    headerNomeController.clear();
    headerPrioridadeController.clear();

    headerREditValido = 256;
    headerGEditValido = 256;
    headerBEditValido = 256;
    headerAEditValido = 256;
    headerNomeEditValido = "";
    headerPrioridadeEditValido = 0;
  }
}
