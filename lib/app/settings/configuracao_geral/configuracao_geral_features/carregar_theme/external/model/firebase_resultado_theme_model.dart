import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/resultado_theme.dart';

class FirebaseResultadoThemeModel extends ResultadoTheme {
  final DocumentReference reference;
  final String user;
  final Map primary;
  final Map accent;

  FirebaseResultadoThemeModel({
    required this.reference,
    required this.user,
    required this.primary,
    required this.accent,
  }) : super(accent: accent, primary: primary, user: user);

  factory FirebaseResultadoThemeModel.fromDocument(DocumentSnapshot doc) {
    return FirebaseResultadoThemeModel(
      reference: doc.reference,
      user: doc.data()['user'],
      primary: doc.data()['primary'],
      accent: doc.data()['accent'],
    );
  }

  @override
  String toString() {
    return "User - $user - Primary - $primary Accent - $accent";
  }
}
