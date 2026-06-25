import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';

class SSelectField<T> extends StatelessWidget {
  final String? label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? hint;
  final String? Function(T?)? validator;
  final bool enabled;

  const SSelectField({
    super.key,
    this.label,
    required this.value,
    required this.items,
    this.onChanged,
    this.hint,
    this.validator,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: AppColors.textBasePrimary, // header background color (hitam)
          onPrimary: AppColors.bgBasePrimary, // header text color (putih)
          onSurface: AppColors.textBasePrimary, // body text color (hitam)
          background: AppColors.bgBasePrimary, // background putih
        ),
        dialogBackgroundColor: AppColors.bgBasePrimary,
        canvasColor: AppColors.bgBasePrimary,
      ),
      child: DropdownButtonFormField<T>(
        value: value,
        items: items,
        onChanged: enabled ? onChanged : null,
        validator: validator,
        decoration: InputDecoration(
          label: label != null
              ? Text(
                  label!,
                  style: darkText.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w400),
                )
              : null,
          hintText: hint,
          labelStyle: const TextStyle(color: AppColors.textBasePrimary),
          focusColor: AppColors.borderBasePrimary,
          fillColor: AppColors.borderBasePrimary,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.borderBasePrimary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.borderBasePrimary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.borderBasePrimary,
            ),
          ),
        ),
        style: const TextStyle(fontSize: 14, color: AppColors.textBasePrimary),
        isExpanded: true,
        icon:
            const Icon(Icons.arrow_drop_down, color: AppColors.textBasePrimary),
      ),
    );
  }
}
