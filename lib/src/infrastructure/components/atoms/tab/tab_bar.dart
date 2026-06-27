import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
class AppTabBar extends StatelessWidget {
  final String text;
  final bool active;
  const AppTabBar({super.key, required this.text, this.active = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: active ? AppColors.bgBasePrimary : Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: active ? FontWeight.w700 : FontWeight.w400,
              color: active
                  ? AppColors.bgBrandPrimary
                  : AppColors.textBaseSecondary,
            ),
          )
        ],
      ),
    );
  }
}