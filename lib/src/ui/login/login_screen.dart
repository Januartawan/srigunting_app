import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/text_field/text_field.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
import 'package:srigunting_app/src/ui/login/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState
    extends AUIManagement<LoginBloc, LoginState, LoginScreen> {
  final _phoneC = TextEditingController();
  final _passwordC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void onStart() {
    stateManagement.pushEvent(LoginInitialEvent());
    super.onStart();
  }

  @override
  Widget buildState(BuildContext context, LoginState state) {
    switch (state) {
      case LoginSuccess():
        pushNamedAndRemoveUntil(Routing.APP, (route) => false);
      // pushReplacementNamed(Routing.APP);
      // showToastSuccess(context, message: "Login Success");
      case LoginError():
        showToastError(context, message: state.error);
      case LoginInitial():
      // TODO: Handle this case.
      case LoginLoading():
      // TODO: Handle this case.
    }

    return SScaffold(
      headerBody: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: AppColors.textBrandOn,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  "Selamat datang semeton",
                  style: lightText.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 26),
              child: Text(
                "Masuk untuk mengakses akun",
                textAlign: TextAlign.start,
                style: lightText.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.textBrandOnSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          child: Column(
            children: [
              STextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone / username';
                  }
                  return null;
                },
                controller: _phoneC,
                label: "No WhatsApp / Username",
                // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                // keyboardType: TextInputType.numberWithOptions(),
              ),
              const SizedBox(
                height: 12,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     GestureDetector(
              //       onTap: () {
              //         pushNamed(Routing.FORGOT_PASSWORD);
              //       },
              //       child: const Text(
              //         'Forgot Password',
              //         style: TextStyle(
              //           fontSize: 14,
              //           color: AppColors.bgBrandPrimary,
              //           decoration: TextDecoration.underline,
              //           decorationColor: AppColors.bgBrandPrimary,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 6,
              // ),
              STextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                controller: _passwordC,
                label: "Password",
                obscureText: true,
              ),
              const Spacer(),
              SButton(
                loading: state is LoginLoading,
                textStyle: lightText.copyWith(
                    fontSize: 14, fontWeight: FontWeight.w400),
                suffixIcon: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 14,
                  color: AppColors.textBrandOn,
                ),
                label: "Masuk",
                buttonStyle: primaryStyleButton,
                onPressed: () {
                  // Navigator.popAndPushNamed(context, Routing.APP);
                  if (_formKey.currentState?.validate() ?? false) {
                    stateManagement.pushEvent(
                      LoginExecuteEvent(
                          username: _phoneC.text, password: _passwordC.text),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement initialData
  LoginState get initialData => LoginInitial();
}
