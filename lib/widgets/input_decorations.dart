import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration formInputDecoration(
      {required String hintText, required String labelText, required Icon prefixIcon}) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black,
        )),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.black);
  }
}
