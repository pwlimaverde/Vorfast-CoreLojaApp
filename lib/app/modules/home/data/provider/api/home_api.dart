import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../settings/configuracao_geral/configuracao_geral_features/carregar_theme/external/model/firebase_resultado_theme_model.dart';
import '../../../../../settings/core/core_presenter/core_presenter.dart';
import '../../model/anuncio_model.dart';
//Importes Internos
import '../../model/secao_model.dart';

class HomeApiClient {
  final FirebaseFirestore firestore;
  final StorageReference storageReference;
  HomeApiClient({
    required this.firestore,
    required this.storageReference,
  });

  Stream<List<SecaoModel>> getAllSecao() {
    return firestore
        .collection("secao")
        .orderBy("prioridade")
        .snapshots()
        .map((query) {
      return query.docs.map((doc) {
        return SecaoModel.fromDocument(doc, _getAnuncios(doc.reference));
      }).toList();
    });
  }

  Stream<List<AnuncioModel>> _getAnuncios(DocumentReference doc) {
    return doc.collection("anuncios").snapshots().map((query) {
      return query.docs.map((doc) {
        return AnuncioModel.fromDocument(doc);
      }).toList();
    });
  }

  Future<void> saveCor({
    required Map<String, int> cor,
    required String key,
    required auth.User user,
  }) async {
    try {
      await firestore.collection("settingstheme").doc("theme").update({
        "$key": cor,
        'user': user.uid,
      });
    } catch (e) {}
  }

  Future<void> saveHeader({
    required String doc,
    required String nome,
    required int prioridade,
    required Map corHeader,
    required auth.User user,
  }) async {
    try {
      await firestore.collection("secao").doc(doc).update({
        "cor": corHeader,
        "user": user.uid,
        "nome": nome,
        "prioridade": prioridade,
      });
    } catch (e) {}
  }

  Future<FirebaseResultadoThemeModel> getThemeConfig() {
    return firestore
        .collection("settingstheme")
        .doc("theme")
        .get()
        .then((event) {
      return FirebaseResultadoThemeModel.fromDocument(event);
    });
  }

  Future<void> saveImgGalery({
    required FirebaseResultadoSecaoModel secao,
  }) async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    final File img = File(pickedFile.path);

    var uploadTask =
        storageReference.child("header").child(secao.nome).putFile(img);
    var storageSnapshot = await uploadTask.onComplete;
    var url = await storageSnapshot.ref.getDownloadURL();
    await secao.reference.update({"img": "$url"});
  }

  Future<void> saveImgLink({
    required FirebaseResultadoSecaoModel secao,
    required String link,
  }) async {
    await secao.reference.update({"img": "$link"});
  }
}
