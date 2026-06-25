import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/text_field/text_field.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return SScaffold(
      title: 'Forgot Password',
      subtitle: 'Reset your password and get back to earning points!',
      onBackAction: () {
        Navigator.pop(context);
      },
      body: Column(
        children: [
          STextField(
            label: 'Phone',
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          Spacer(),
          SButton(
            // loading: true,
            textStyle:
                lightText.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
            suffixIcon: Icon(
              Icons.arrow_forward_rounded,
              size: 14,
              color: AppColors.textBrandOn,
            ),
            label: "Reset Password",
            buttonStyle: primaryStyleButton,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
