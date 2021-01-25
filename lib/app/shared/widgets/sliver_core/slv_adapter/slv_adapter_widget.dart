import 'package:flutter/material.dart';

class SlvAdapterWidget extends StatelessWidget {
  final Widget adapter;

  const SlvAdapterWidget({required Key key, required this.adapter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: adapter,
    );
  }
}
