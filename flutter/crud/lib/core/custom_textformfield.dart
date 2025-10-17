import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.validacao,
    required this.label,
    required this.controller,
  });

  final TextEditingController controller;
  final String validacao;
  final Text label;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => value!.isEmpty ? validacao : null,
      controller: controller,
      decoration: InputDecoration(
        label: label,
        border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
      ),
    );
  }
}
