import 'package:blog_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthFieldWidget extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  const AuthFieldWidget({
    super.key,
    required this.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "$text is missing!";
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.borderColor,
        hintText: text,

        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
