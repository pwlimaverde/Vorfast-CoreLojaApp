import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../settings/settings_presenter/configuracao_geral_controller.dart';
//Importes Internos
import 'data/provider/api/home_api.dart';
import 'data/repository/home_repository.dart';
import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() {
      return HomeController(
        repo: HomeRepository(
          apiClient: HomeApiClient(
            firestore: FirebaseFirestore.instance,
            storageReference: FirebaseStorage().ref(),
          ),
        ),
        configuracaoGeralController: Get.find<ConfiguracaoGeralController>(),
      );
    });
  }
}
