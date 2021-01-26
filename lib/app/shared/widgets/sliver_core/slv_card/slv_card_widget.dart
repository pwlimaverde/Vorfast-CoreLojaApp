import 'package:flutter/material.dart';

class SlvCardWidget extends StatelessWidget {
  final Widget body;

  const SlvCardWidget({Key key, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: (MediaQuery.of(context).size.height),
        child: Card(
          margin: EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: body,
          ),
        ),
      ),
    );
  }
}
