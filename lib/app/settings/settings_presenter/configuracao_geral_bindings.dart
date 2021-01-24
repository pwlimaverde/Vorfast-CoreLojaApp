import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

//Importes Internos
import '../auth/auth_features/carregar_usuario/domain/usecases/carregar_usuario_usecase.dart';
import '../auth/auth_features/carregar_usuario/external/datasources_impl/firebase_usuario_datasource.dart';
import '../auth/auth_features/carregar_usuario/infra/repositories_impl/carregar_usuario_repository_impl.dart';
import '../auth/auth_features/recuperar_senha_email/external/datasources_impl/firebase_recuperar_senha_email_datasource.dart';
import '../auth/auth_features/recuperar_senha_email/infra/repositories_impl/recuperar_senha_email_repository_impl.dart';
import '../auth/auth_features/signin/domain/usecases/signin_usecase.dart';
import '../auth/auth_features/signin/external/datasources_impl/firebase_novo_email_datasource.dart';
import '../auth/auth_features/signin/external/datasources_impl/firebase_signin_email_datasource.dart';
import '../auth/auth_features/signin/external/datasources_impl/firebase_signin_google_datasource.dart';
import '../auth/auth_features/signin/infra/repositories_impl/signin_repository_impl.dart';
import '../auth/auth_features/signout/domain/usecases/signout_usecase.dart';
import '../auth/auth_features/signout/external/datasources_impl/firebase_signout_datasource.dart';
import '../auth/auth_features/signout/infra/repositories_impl/signout_repository_impl.dart';
import '../auth/auth_presenter/auth_presenter.dart';
import '../configuracao_geral/configuracao_geral_features/carregar_theme/domain/usecases/carregar_theme_usecase.dart';
import '../configuracao_geral/configuracao_geral_features/carregar_theme/external/datasources_impl/firebase_theme_datasource.dart';
import '../configuracao_geral/configuracao_geral_features/carregar_theme/infra/repositories_impl/carregar_theme_repository_impl.dart';
import '../configuracao_geral/configuracao_geral_features/checar_coneccao/domain/usecases/checar_coneccao_usecase.dart';
import '../configuracao_geral/configuracao_geral_features/checar_coneccao/external/datasources_impl/connectivity_datasource.dart';
import '../configuracao_geral/configuracao_geral_features/checar_coneccao/infra/repositories_impl/checar_coneccao_repository_impl.dart';
import '../core/core_features/carregar_secao/domain/usecases/carregar_secao_usecase.dart';
import '../core/core_features/carregar_secao/external/datasources_impl/firebase_secao_datasource.dart';
import '../core/core_features/carregar_secao/infra/repositories_impl/carregar_secao_repository_impl.dart';
import '../institucional/institucional_features/carregar_empresa/external/datasources_impl/firebase_empresa_datasource.dart';
import '../institucional/institucional_features/carregar_empresa/infra/repositories_impl/carregar_empresa_repository_impl.dart';
import '../institucional/institucional_presenter/institucional_presenter.dart';
import 'configuracao_geral_controller.dart';

class ConfiguracaoGeralBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ConfiguracaoGeralController>(
      ConfiguracaoGeralController(
        //usecases
        carregarTheme: CarregarThemeUsecase(
          //infra
          repository: CarregarThemeRepositoryImpl(
            //external
            datasource: FairebaseThemeDatasource(
              //package firebase
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ),
        //usecases
        checarConeccao: ChecarConeccaoUsecase(
          //infra
          repository: ChecarConeccaoRepositoryImpl(
            //external
            datasource: ConnectivityDatasource(
              //package Connectivity
              connectivity: Connectivity(),
            ),
          ),
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
        carregarUsuario: CarregarUsuarioUsecase(
          //infra
          repository: CarregarUsuarioRepositoryImpl(
            //external
            datasource: FirebaseUsuarioDatasourse(
              //package firebase
              authInstance: FirebaseAuth.instance,
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ),
        //usecases
        signOutUsecase: SignOutUsecaseImpl(
          //infra
          repository: SignOutRepositoryImpl(
            //external
            datasource: FarebaseSignOutDatasource(
              //package firebase
              auth: FirebaseAuth.instance,
            ),
          ),
        ),
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
        recuperarSenhaEmailLoginUsecase: RecuperarSenhaEmailUsecaseImpl(
          //infra
          repository: RecuperarSenhaEmailRepositoryImpl(
            //external
            datasource: FarebaseRecuperarSenhaEmailDatasource(
              //package firebasel
              authInstance: FirebaseAuth.instance,
            ),
          ),
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
        carregarEmpresa: CarregarEmpresaUsecase(
          //infra
          repository: CarregarEmpresaRepositoryImpl(
            //external
            datasource: FirebaseEmpresaDatasourse(
              //package firebase
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ),
      ),
    );
  }
}
