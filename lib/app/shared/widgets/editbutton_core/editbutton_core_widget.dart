import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditbuttonCoreWidget extends StatelessWidget {
  final bool isEditeMode;
  final Function onPressedcheck;
  final Function onPressedEdit;

  const EditbuttonCoreWidget({
    Key key,
    this.isEditeMode = false,
    this.onPressedEdit,
    this.onPressedcheck,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return isEditeMode
        ? IconButton(
            icon: Icon(FontAwesomeIcons.check),
            onPressed: onPressedcheck,
          )
        : IconButton(
            icon: Icon(FontAwesomeIcons.pencilAlt),
            onPressed: onPressedEdit,
          );
  }
}
