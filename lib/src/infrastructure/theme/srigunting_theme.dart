import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';

class SriguntingTheme {
  final BuildContext context;

  SriguntingTheme(this.context);

  ThemeData get sriguntingThemeDefault {
    return ThemeData(
      primaryColor: AppColors.bgBasePrimary,
      fontFamily: "DM Sans",
      scaffoldBackgroundColor: AppColors.bgBasePrimary,
    );
  }
}
