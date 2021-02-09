import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Importes Internos
import '../splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Text("Bem Vindo a Loja...",
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.white,
            )),
      ),
    );
  }
}
