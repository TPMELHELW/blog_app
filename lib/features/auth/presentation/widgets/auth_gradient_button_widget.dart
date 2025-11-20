import 'package:blog_app/core/common/cubit/button_cubit/button_cubit.dart';
import 'package:blog_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AuthGradientButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonCubit, bool>(
      builder: (BuildContext context, bool isLoading) {
        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.gradient1, AppColors.gradient2],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadius.circular(7),
          ),
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(395, 55),
              backgroundColor: AppColors.transparentColor,
              shadowColor: AppColors.transparentColor,
            ),
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Text(
                    buttonText,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
