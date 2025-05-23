import 'package:flutter/material.dart';
import 'package:light_quiz/core/utils/app_text_styles.dart';

AppBar customAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Colors.transparent,
    title: Text(title, style: TextStyles.bold23),
    centerTitle: true,
    leadingWidth: 80,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        size: 16,
        Icons.arrow_back_ios_new_rounded,
        color: Theme.of(context).textTheme.bodySmall!.color,
      ),
    ),
  );
}
