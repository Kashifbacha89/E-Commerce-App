import 'package:e_commerce_app/utils/app_utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.validator,
      this.keyboard,
      this.onEditingComplete,
      this.suffixIcon,
      this.prefixIcon,
      this.obscureText})
      : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboard;
  final String Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function()? onEditingComplete;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        keyboardType: keyboard,
        controller: controller,
        obscureText: obscureText??false,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          suffixIconColor: Colors.black,
          hintStyle: appStyle(14, Colors.grey, FontWeight.w500),
          contentPadding: const EdgeInsets.all(10),
          border: InputBorder.none
        ),
      ),
    );
  }
}
