import 'package:flutter/material.dart';

class PreviewEditCorWidget extends StatelessWidget {
  final Color cor;
  final String title;

  const PreviewEditCorWidget({
    Key key,
    @required this.cor,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          color: cor,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 13),
        )
      ],
    );
  }
}
