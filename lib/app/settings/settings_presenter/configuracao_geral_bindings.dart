import 'package:auth_google_package/auth_google_package.dart';
import 'package:carregar_empresa_package/carregar_empresa_package.dart';
import 'package:checar_coneccao_plugin/checar_coneccao_plugin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:corelojaapp/app/settings/datasources/auth_google_package/carregar_usuario/firebase_carregar_usuario_datasource.dart';
import 'package:corelojaapp/app/settings/datasources/auth_google_package/recuperar_senha_email/firebase_recuperar_senha_email_datasource.dart';
import 'package:corelojaapp/app/settings/datasources/auth_google_package/signout/firebase_signout_datasource.dart';
import 'package:corelojaapp/app/settings/datasources/carregar_empresa_package/firebase_empresa_datasource.dart';
import 'package:corelojaapp/app/settings/datasources/carregar_temas_package/datasource/firebase_theme_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

//Importes Internos
import '../auth/auth_features/signin/domain/usecases/signin_usecase.dart';
import '../auth/auth_features/signin/external/datasources_impl/firebase_novo_email_datasource.dart';
import '../auth/auth_features/signin/external/datasources_impl/firebase_signin_email_datasource.dart';
import '../auth/auth_features/signin/external/datasources_impl/firebase_signin_google_datasource.dart';
import '../auth/auth_features/signin/infra/repositories_impl/signin_repository_impl.dart';
import '../auth/auth_presenter/auth_presenter.dart';
import '../core/core_features/carregar_secao/domain/usecases/carregar_secao_usecase.dart';
import '../core/core_features/carregar_secao/external/datasources_impl/firebase_secao_datasource.dart';
import '../core/core_features/carregar_secao/infra/repositories_impl/carregar_secao_repository_impl.dart';
import 'package:carregar_temas_package/carregar_temas_package.dart';
import 'configuracao_geral_controller.dart';

class ConfiguracaoGeralBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ConfiguracaoGeralController>(
      ConfiguracaoGeralController(
        //usecases
        carregarThemePresenter: CarregarTemasPresenter(
          mostrarTempoExecucao: true,
          datasource: FairebaseThemeDatasource(
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
        carregarSecao: CarregarSecaoUsecaseImpl(
          //infra
          repository: CarregarSecaoRepositoryImpl(
            //external
            datasource: FirebaseSecaoDatasourse(
              //package firebase
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ),
        //usecases
        carregarUsuarioPresenter: CarregarUsuarioPresenter(
          datasource: FirebaseCarregarUsuarioDatasourse(
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
        signInGoogleUsecase: SignInUsecaseImpl(
          //infra
          repository: SignInRepositoryImpl(
            //external
            datasource: FarebaseSignInGoogleDatasource(
              //package firebasel
              authInstance: FirebaseAuth.instance,
              firestore: FirebaseFirestore.instance,
              googleSignIn: GoogleSignIn(),
            ),
          ),
        ),
        //usecases
        signInEmailUsecase: SignInUsecaseImpl(
          //infra
          repository: SignInRepositoryImpl(
            //external
            datasource: FarebaseSignInEmailDatasource(
              //package firebasel
              authInstance: FirebaseAuth.instance,
            ),
          ),
        ),
        //usecases
        recuperarSenhaEmailPresenter: RecuperarSenhaEmailPresenter(
          datasource: FarebaseRecuperarSenhaEmailDatasource(
            authInstance: FirebaseAuth.instance,
          ),
          mostrarTempoExecucao: true,
        ),
        //usecases
        novoEmailUsecase: SignInUsecaseImpl(
          //infra
          repository: SignInRepositoryImpl(
            //external
            datasource: FarebaseNovoEmailDatasource(
              //package firebasel
              authInstance: FirebaseAuth.instance,
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ),
        //usecases
        carregarEmpresaPresenter: CarregarEmpresaPresenter(
            mostrarTempoExecucao: true,
            datasource: FirebaseEmpresaDatasourse(
              firestore: FirebaseFirestore.instance,
            )),
      ),
    );
  }
}
