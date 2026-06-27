import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';

var primaryStyleButton = TextButton.styleFrom(
  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
  backgroundColor: AppColors.bgBrandPrimary,
  textStyle: const TextStyle(
    color: AppColors.textBrandOn,
  ),
);

var secondaryStyleButton = TextButton.styleFrom(
  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
  backgroundColor: AppColors.bgBasePrimary,
  textStyle: const TextStyle(
    color: AppColors.textBrandOn,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50), // Fully rounded corners
    side: const BorderSide(
      color: AppColors.borderBaseSecondary, // Border color
      width: 1, // Border width
    ),
  ),
);

var disabledStyleButton = TextButton.styleFrom(
  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
  backgroundColor: AppColors.borderBasePrimary,
  textStyle: const TextStyle(
    color: AppColors.textBaseSecondary,
  ),
);
