import 'package:flutter/material.dart';
import 'package:light_quiz/core/utils/app_colors.dart';
import 'package:light_quiz/core/utils/app_text_styles.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String?)? onSaved;
  final String title;
  const PasswordField({
    super.key,
    required this.controller,
    this.onSaved,
    this.title = '',
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password is required";
        }
        return null;
      },
      onSaved: widget.onSaved,
      style: TextStyles.semiBold16,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: "Enter your password",
        hintStyle: TextStyles.bold13.copyWith(color: AppColors.greyColor),
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: IconButton(
            onPressed: () {
              _obscureText = !_obscureText;
              setState(() {});
            },
            icon: Icon(
              _obscureText ? Icons.remove_red_eye : Icons.visibility_off,
            ),
            color: AppColors.greyColor,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).textTheme.bodyMedium!.color,
        border: customBorder(),
        enabledBorder: customBorder(),
        focusedBorder: customBorder(),
      ),
    );
  }

  OutlineInputBorder customBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(
        width: 1.3,
        color: Theme.of(context).textTheme.bodyMedium!.color!,
      ),
    );
  }
}
