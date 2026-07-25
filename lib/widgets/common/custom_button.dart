import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool filled;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.filled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor:
        filled ? AppColors.textPrimary : Colors.transparent,

        foregroundColor:
        filled ? Colors.white : AppColors.textPrimary,

        side: filled
            ? BorderSide.none
            : BorderSide(
          color: AppColors.border,
        ),

        padding: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 18,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}