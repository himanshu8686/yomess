import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indglobalyomess/utils/constant.dart';

class CommonInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon prefixIcon;
  final String labelText;
  final TextInputType type;
  final bool obscureText;
  final Function validator;
  final List<TextInputFormatter> inputFormatters;

  CommonInputField({
    this.validator,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.labelText,
    this.type,
    this.obscureText,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      validator: validator,
      keyboardType: type,
      controller: controller,
      obscureText: obscureText == null ? false : true,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
            color: Colors.black, fontSize: 16, fontFamily: 'Montserrat-Medium'),
        contentPadding: EdgeInsets.all(12),
        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.black26,
            fontSize: 16,
            fontFamily: 'Montserrat-Medium'),
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0XFF949494).withOpacity(0.46)),
            borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff949494).withOpacity(0.46)),
            borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff949494).withOpacity(0.46)),
            borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
