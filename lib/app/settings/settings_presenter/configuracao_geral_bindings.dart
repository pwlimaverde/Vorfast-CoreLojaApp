import 'package:auth_google_package/auth_google_package.dart';
import 'package:carregar_empresa_package/carregar_empresa_package.dart';
import 'package:carregar_secoes_package/carregar_secoes_package.dart';
import 'package:carregar_temas_package/carregar_temas_package.dart';
import 'package:checar_coneccao_plugin/checar_coneccao_plugin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

//Importes Internos
import '../datasources/auth_google_package/carregar_usuario/firebase_carregar_usuario_datasource.dart';
import '../datasources/auth_google_package/recuperar_senha_email/firebase_recuperar_senha_email_datasource.dart';
import '../datasources/auth_google_package/signin/firebase_novo_email_datasource.dart';
import '../datasources/auth_google_package/signin/firebase_signin_email_datasource.dart';
import '../datasources/auth_google_package/signin/firebase_signin_google_datasource.dart';
import '../datasources/auth_google_package/signout/firebase_signout_datasource.dart';
import '../datasources/carregar_empresa_package/firebase_empresa_datasource.dart';
import '../datasources/carregar_secoes_package/firebase_secao_datasource.dart';
import '../datasources/carregar_temas_package/datasource/firebase_tema_datasource.dart';
import 'configuracao_geral_controller.dart';

class ConfiguracaoGeralBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ConfiguracaoGeralController>(
      ConfiguracaoGeralController(
        //usecases
        carregarThemePresenter: CarregarTemasPresenter(
          mostrarTempoExecucao: true,
          datasource: FairebaseTemaDatasource(
            firestore: FirebaseFirestore.instance,
          ),
        ),
        //usecases
        checarConeccaoPresenter: ChecarConeccaoPresenter(
          mostrarTempoExecucao: true,
        ),
        //package Connectivity
        onconnect: Connectivity(),
        //usecases
        carregarSecao: CarregarSecoesPresenter(
          mostrarTempoExecucao: true,
          datasource: FirebaseSecaoDatasourse(
            firestore: FirebaseFirestore.instance,
          ),
        ),
        //usecases
        carregarUsuarioPresenter: CarregarUsuarioPresenter(
          datasource: FirebaseCarregarUsuarioDatasource(
            authInstance: FirebaseAuth.instance,
            firestore: FirebaseFirestore.instance,
          ),
          mostrarTempoExecucao: true,
        ),
        //usecases
        signOutPresenter: SignOutPresenter(
            datasource: FarebaseSignOutDatasource(
              auth: FirebaseAuth.instance,
            ),
            mostrarTempoExecucao: true),
        //usecases
        signInGooglePresenter: SignInPresenter(
          datasource: FarebaseSignInGoogleDatasource(
            authInstance: FirebaseAuth.instance,
            firestore: FirebaseFirestore.instance,
            googleSignIn: GoogleSignIn(),
          ),
          mostrarTempoExecucao: true,
        ),
        //usecases
        signInEmailPresenter: SignInPresenter(
          datasource: FarebaseSignInEmailDatasource(
            authInstance: FirebaseAuth.instance,
          ),
          mostrarTempoExecucao: true,
        ),
        //usecases
        recuperarSenhaEmailPresenter: RecuperarSenhaEmailPresenter(
          datasource: FarebaseRecuperarSenhaEmailDatasource(
            authInstance: FirebaseAuth.instance,
          ),
          mostrarTempoExecucao: true,
        ),
        //usecases
        novoEmailPresenter: SignInPresenter(
          datasource: FarebaseNovoEmailDatasource(
            authInstance: FirebaseAuth.instance,
            firestore: FirebaseFirestore.instance,
          ),
          mostrarTempoExecucao: true,
        ),
        //usecases
        carregarEmpresaPresenter: CarregarEmpresaPresenter(
            mostrarTempoExecucao: true,
            datasource: FirebaseEmpresaDatasource(
              firestore: FirebaseFirestore.instance,
            )),
      ),
    );
  }
}
