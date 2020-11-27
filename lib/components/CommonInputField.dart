import 'package:flutter/material.dart';
import 'package:indglobalyomess/utils/Constant.dart';

class CommonInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon prefixIcon;
  final String labelText;
  final TextInputType type;
  final bool obscureText;

  CommonInputField({
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.labelText,
    this.type,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      controller: controller,
      obscureText: obscureText == null ? false : true,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: kPrimaryAuthOrangeColor),
        contentPadding: EdgeInsets.all(12),
        hintText: hintText,
        hintStyle:
            TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).focusColor.withOpacity(0.2))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).focusColor.withOpacity(0.5))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).focusColor.withOpacity(0.2))),
      ),
    );
  }
}
