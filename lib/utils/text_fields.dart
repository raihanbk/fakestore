import 'package:flutter/material.dart';

Widget textFormField({
  String? labelText,
  TextEditingController? controller,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      isDense: true,
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
