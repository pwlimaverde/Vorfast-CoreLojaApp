import 'package:flutter/material.dart';

import '../widgets_core.dart' as widgetCore;

class BodyCoreWidget extends StatelessWidget {
  final List<Widget> slv;
  final Widget drawer;

  const BodyCoreWidget({
    required Key key,
    required this.slv,
    required this.drawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      body: Stack(
        children: <Widget>[
          widgetCore.GradientebackCoreWidget(),
          CustomScrollView(
            slivers: slv,
          ),
        ],
      ),
    );
  }
}
