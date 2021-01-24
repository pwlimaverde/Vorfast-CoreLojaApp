import 'package:flutter/material.dart';

class SlvAdapterWidget extends StatelessWidget {
  final Widget adapter;

  const SlvAdapterWidget({Key key, this.adapter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: adapter,
    );
  }
}
