import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
class STextField extends StatefulWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? label;
  final bool obscureText;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final String? Function(String?)? validator;
  final bool enabled;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final int maxLines;
  final FocusNode? focusNode;
  const STextField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.label = '',
    this.obscureText = false,
    this.onTap,
    this.keyboardType,
    this.hintText,
    this.inputFormatters,
    this.readOnly = false,
    this.validator,
    this.enabled = true,
    this.onChanged,
    this.controller,
    this.maxLines = 1,
    this.focusNode,
  });
  @override
  State<STextField> createState() => _STextFieldState();
}
class _STextFieldState extends State<STextField> {
  bool _obscureText = false;
  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }
  @override
  void didUpdateWidget(STextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _obscureText = widget.obscureText;
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      inputFormatters: widget.inputFormatters,
      obscureText: _obscureText,
      onTap: widget.onTap,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      validator: widget.validator,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      controller: widget.controller,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon ??
            (widget.obscureText
                ? GestureDetector(
                    onTap: () {
                      _obscureText = !_obscureText;
                      setState(() {});
                    },
                    child: Icon(
                      size: 18,
                      _obscureText
                          ? Icons.visibility
                          : Icons.visibility_off_outlined,
                      color: AppColors.iconBasePrimary,
                    ),
                  )
                : null),
        hintText: widget.hintText,
        label: (widget.label != null && widget.label!.isNotEmpty)
            ? Text(
                widget.label!,
                style: darkText.copyWith(
                    fontSize: 14, fontWeight: FontWeight.w400),
              )
            : null,
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
      style: const TextStyle(fontSize: 14),
    );
  }
}