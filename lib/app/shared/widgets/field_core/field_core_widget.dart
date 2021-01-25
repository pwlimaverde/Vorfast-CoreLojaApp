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
    required Key key,
    required this.validator,
    required this.onChanged,
    required this.maxLength,
    required this.label,
    required this.hint,
    required this.keyBoard,
    required this.obscureText,
    required this.controller,
    required this.prefix,
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
      validator: validator(),
      obscureText: obscureText ?? false,
      maxLength: maxLength ?? null,
      onChanged: onChanged(),
    );
  }
}
