import 'package:flutter/material.dart';
import 'package:light_quiz/core/utils/app_colors.dart';
import 'package:light_quiz/core/utils/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Widget? preIcon;
  final TextEditingController controller;
  final void Function(String?)? onSaved;

  const CustomTextField({
    super.key,
    required this.hint,
    this.preIcon,
    required this.controller,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.primaryColor,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "${hint.split(' ')[2]} ${hint.split(' ')[3]} is required";
        }
        return null;
      },
      onSaved: onSaved,
      style: TextStyles.semiBold16,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyles.bold13.copyWith(color: AppColors.greyColor),
        prefixIcon: preIcon,
        filled: true,
        fillColor: Theme.of(context).textTheme.bodyMedium!.color,
        border: customBorder(context),
        enabledBorder: customBorder(context),
        focusedBorder: customBorder(context),
      ),
    );
  }

  OutlineInputBorder customBorder(context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(
        width: 1.3,
        color: Theme.of(context).textTheme.bodyMedium!.color!,
      ),
    );
  }
}
