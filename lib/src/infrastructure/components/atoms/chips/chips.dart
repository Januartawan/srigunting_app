import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';

class SChips extends StatelessWidget {
  final String? label;
  final Color color;
  final double? fontSize;
  final FontWeight? fontWeight;

  const SChips({
    super.key,
    this.label,
    required this.color,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1, color: color)),
      child: Text(
        label ?? '',
        style: darkText.copyWith(
          color: color,
          fontSize: fontSize ?? 12,
          fontWeight: fontWeight ?? FontWeight.w400,
        ),
      ),
    );
  }
}

enum ChipType { info, warning, danger, success }

class SChips2 extends StatelessWidget {
  final ChipType? type;
  final String? label;

  const SChips2({super.key, this.type, this.label});

  Color _getTextColor() {
    switch (type) {
      case ChipType.info:
        return AppColors.bgInfoPrimary;
      case ChipType.warning:
        return AppColors.bgWarningPrimary;
      case ChipType.danger:
        return AppColors.bgDangerPrimary;
      case ChipType.success:
        return AppColors.bgSuccessPrimary;
      default:
        return Colors.grey;
    }
  }

  Color _getBgColor() {
    switch (type) {
      case ChipType.info:
        return AppColors.bgInfoSecondary;
      case ChipType.warning:
        return AppColors.bgWarningSecondary;
      case ChipType.danger:
        return AppColors.bgDangerSecondary;
      case ChipType.success:
        return AppColors.bgSuccessSecondary;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: _getBgColor(),
      ),
      child: Text(
        label ?? '',
        style: darkText.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: _getTextColor(),
        ),
      ),
    );
  }
}
