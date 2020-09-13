import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Importes Internos
import '../splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 400.0,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
