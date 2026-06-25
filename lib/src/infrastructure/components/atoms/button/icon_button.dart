import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';

class SIconButton extends StatefulWidget {
  final bool? disabled;
  final IconData icon;
  final Function()? onPressed;

  const SIconButton(
      {super.key, this.disabled = false, required this.icon, this.onPressed});

  @override
  State<SIconButton> createState() => _SIconButtonState();
}

class _SIconButtonState extends State<SIconButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: widget.disabled == true
                ? AppColors.borderBasePrimary
                : AppColors.borderBaseSecondary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4)),
      child: IconButton(
        onPressed: widget.disabled == true ? null : widget.onPressed,
        icon: Icon(
          widget.icon,
          color: widget.disabled == true
              ? AppColors.borderBasePrimary
              : AppColors.borderBaseSecondary,
        ),
      ),
    );
  }
}
