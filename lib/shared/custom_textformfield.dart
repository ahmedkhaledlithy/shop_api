import 'package:dsc_shop/shared/colors.dart';
import 'package:dsc_shop/shared/style.dart';
import 'package:flutter/material.dart';


class CustomTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final FormFieldValidator<String>? validator;
  final Widget? suffix;
  final TextStyle? prefixStyle;
   final bool obscure;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final int? maxLength;
 const CustomTextForm({required this.controller,required this.label,
   required this.validator,this.suffix,this.prefixStyle,this.obscure=false,this.keyboardType,this.prefixIcon,this.maxLength});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      maxLength: maxLength,
      keyboardType: keyboardType,
      controller: controller,
      style: TextStyle(
        color: blackColor,
      ),
      obscureText: obscure,
      decoration: InputDecoration(

        labelText: label,
        labelStyle: labelStyle,
        prefixIcon: prefixIcon,
        prefixStyle: prefixStyle,
        suffixIcon: suffix,
        fillColor: whiteColor,
        focusedBorder: borderF,
        enabledBorder: borderE,
        border: borderE,
        filled: true,
      ),
      validator: validator,
    );
  }
}
