import 'package:flutter/material.dart';

class FieldCoreWidget extends StatelessWidget {
  final Function validator;
  final Function onChanged;
  final int maxLength;
  final String label;
  final String hint;
  final TextInputType keyBoard;
  final bool obscureText;
  final TextEditingController controller;
  final String prefix;

  const FieldCoreWidget({
    Key key,
    this.validator,
    this.onChanged,
    this.maxLength,
    this.label,
    this.hint,
    this.keyBoard,
    this.obscureText,
    this.controller,
    this.prefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        prefix: prefix != null ? Text("$prefix") : Text(""),
      ),
      controller: controller,
      keyboardType: keyBoard,
      validator: validator,
      obscureText: obscureText ?? false,
      maxLength: maxLength ?? null,
      onChanged: onChanged,
    );
  }
}
