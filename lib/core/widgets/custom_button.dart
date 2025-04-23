import 'package:flutter/material.dart';
import 'package:light_quiz/core/utils/app_colors.dart';
import 'package:light_quiz/core/utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color color;
  final Widget? icon;
  final bool isLoading;
  final void Function()? onPressed;
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.color = AppColors.primaryColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon,
      label:
          isLoading
              ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: CircularProgressIndicator(color: Colors.white),
              )
              : Text(
                title,
                textAlign: TextAlign.end,
                style: TextStyles.semiBold16.copyWith(color: Colors.white),
              ),
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(color),
        fixedSize: const WidgetStatePropertyAll(Size.fromHeight(49)),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
      ),
    );
  }
}
