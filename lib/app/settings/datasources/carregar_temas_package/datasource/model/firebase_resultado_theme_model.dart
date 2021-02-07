import 'package:carregar_temas_package/carregar_temas_package.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseResultadoThemeModel extends ResultadoTheme {
  final DocumentReference reference;
  String user;
  Map primary;
  Map accent;

  FirebaseResultadoThemeModel({
    this.reference,
    this.user,
    this.primary,
    this.accent,
  });

  factory FirebaseResultadoThemeModel.fromDocument(DocumentSnapshot doc) {
    if (doc == null) return null;

    return FirebaseResultadoThemeModel(
      reference: doc.reference,
      user: doc.data()['user'],
      primary: doc.data()['primary'],
      accent: doc.data()['accent'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['primary'] = this.primary;
    data['accent'] = this.accent;
    return data;
  }

  factory FirebaseResultadoThemeModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return FirebaseResultadoThemeModel(
      user: json['user'],
      primary: json['primary'],
      accent: json['accent'],
    );
  }

  @override
  String toString() {
    return "User - $user - Primary - $primary Accent - $accent";
  }
}
