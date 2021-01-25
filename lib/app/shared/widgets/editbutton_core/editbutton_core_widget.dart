import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditbuttonCoreWidget extends StatelessWidget {
  final bool isEditeMode;
  final Function onPressedcheck;
  final Function onPressedEdit;

  const EditbuttonCoreWidget({
    required Key key,
    required this.isEditeMode,
    required this.onPressedEdit,
    required this.onPressedcheck,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return isEditeMode
        ? IconButton(
            icon: Icon(FontAwesomeIcons.check),
            onPressed: onPressedcheck(),
          )
        : IconButton(
            icon: Icon(FontAwesomeIcons.pencilAlt),
            onPressed: onPressedEdit(),
          );
  }
}
