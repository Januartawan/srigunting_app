import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';

class SDateInputField extends StatefulWidget {
  final String? label;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const SDateInputField(
      {super.key, this.label, this.onChanged, this.validator, this.controller});

  @override
  _DateInputFieldState createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<SDateInputField> {
  late TextEditingController _dateController = TextEditingController();

  void _formatControllerText() {
    if (_dateController.text.isNotEmpty) {
      try {
        final parsed = DateTime.tryParse(_dateController.text);
        if (parsed != null) {
          final formatted = DateFormat('yyyy-MM-dd').format(parsed);
          if (_dateController.text != formatted) {
            _dateController.text = formatted;
          }
        }
      } catch (_) {}
    }
  }

  @override
  void initState() {
    super.initState();
    // Use the provided controller or create a new one
    _dateController = widget.controller ?? TextEditingController();
    _formatControllerText();
    _dateController.addListener(_formatControllerText);
  }

  @override
  void dispose() {
    _dateController.removeListener(_formatControllerText);
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.bgBrandPrimary, // header background color
              onPrimary: AppColors.textBrandOn, // header text color
              onSurface: AppColors.textBasePrimary, // body text color
            ),
            dialogBackgroundColor: AppColors.bgBasePrimary,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      onChanged: widget.onChanged,
      controller: _dateController,
      readOnly: true,
      decoration: InputDecoration(
        label: Text(
          widget.label ?? "",
          style: darkText.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        hintText: "yyyy-MM-dd",
        suffixIcon: Icon(Icons.calendar_today),
        labelStyle: TextStyle(color: AppColors.textBasePrimary),
        focusColor: AppColors.borderBasePrimary,
        fillColor: AppColors.borderBasePrimary,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.borderBasePrimary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.borderBasePrimary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.borderBasePrimary,
          ),
        ),
      ),
      onTap: () => _selectDate(context),
    );
  }
}
