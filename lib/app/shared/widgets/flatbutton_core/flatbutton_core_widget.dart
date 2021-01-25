import 'package:flutter/material.dart';

class FlatbuttonCoreWidget extends StatelessWidget {
  final double padding;
  final Function onPressed;
  final String title;
  final double fontSize;

  const FlatbuttonCoreWidget({
    required Key key,
    required this.padding,
    required this.onPressed,
    required this.title,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.0,
      child: FlatButton(
        padding: padding != null ? EdgeInsets.all(padding) : EdgeInsets.zero,
        onPressed: onPressed(),
        child: Text(
          title,
          textAlign: TextAlign.right,
          style: TextStyle(
              color: Theme.of(context).accentColor, fontSize: fontSize),
        ),
      ),
    );
  }
}
