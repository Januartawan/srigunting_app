import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';

class SButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String label;
  final ButtonStyle buttonStyle;
  final TextStyle? textStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool loading;

  const SButton({
    super.key,
    this.onPressed,
    required this.label,
    required this.buttonStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.loading = false,
  });

  @override
  State<SButton> createState() => _SButtonState();
}

class _SButtonState extends State<SButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: widget.onPressed,
        style: widget.buttonStyle,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.loading
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CupertinoActivityIndicator(
                        color: AppColors.bgBasePrimary,
                      ),
                    )
                  : Row(
                      children: [
                        if (widget.prefixIcon != null) ...[
                          widget.prefixIcon!,
                          SizedBox(
                            width: 8,
                          ),
                        ],
                        Text(
                          widget.label,
                          style: widget.textStyle,
                        ),
                        if (widget.suffixIcon != null) ...[
                          SizedBox(
                            width: 8,
                          ),
                          widget.suffixIcon!,
                        ],
                      ],
                    )
            ],
          ),
        ));
  }
}
