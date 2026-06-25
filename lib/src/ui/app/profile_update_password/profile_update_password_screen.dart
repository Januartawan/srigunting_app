import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/image/image_svg.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/text_field/text_field.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
import 'package:srigunting_app/src/ui/app/profile_update_password/bloc/profile_update_password_bloc.dart';

class ProfileUpdatePasswordScreen extends StatefulWidget {
  const ProfileUpdatePasswordScreen({super.key});

  @override
  State<ProfileUpdatePasswordScreen> createState() =>
      _ProfileUpdatePasswordState();
}

class _ProfileUpdatePasswordState extends AUIManagement<
    ProfileUpdatePasswordBloc,
    ProfileUpdatePasswordState,
    ProfileUpdatePasswordScreen> {
  final _oldPasswordC = TextEditingController();
  final _newPasswordC = TextEditingController();
  final _confirmPasswordC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildState(BuildContext context, ProfileUpdatePasswordState state) {
    switch (state) {
      case ProfileUpdatePasswordExecuteSuccess():
        Future.microtask(() {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Dialog(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.bgBasePrimary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SImageSvgAsset(
                          fileName: 'icon_check.svg',
                          height: 56,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Password Reset Successful',
                          style: darkText.copyWith(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Your password has been updated! You can now sign in with your new password',
                          style: darkText.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textBaseSecondary,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SButton(
                          suffixIcon: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 14,
                            color: AppColors.textBrandOn,
                          ),
                          label: 'Sign In',
                          textStyle: lightText.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          buttonStyle: primaryStyleButton,
                          onPressed: () {
                            Navigator.of(context).pop(); // Close dialog first
                            pushReplacementNamed(Routing.LOGIN);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
        break;
      case ProfileUpdatePasswordExecuteError():
        showToastError(context, message: state.error);
        break;
      default:
    }

    return SScaffold(
        title: 'Ganti Password',
        onBackAction: () {
          Navigator.pop(context, true);
        },
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              STextField(
                obscureText: true,
                controller: _oldPasswordC,
                label: "Password Lama",
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong lengkapi form';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              STextField(
                obscureText: true,
                controller: _newPasswordC,
                label: "Password Paru",
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong lengkapi form';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              STextField(
                obscureText: true,
                controller: _confirmPasswordC,
                label: "Konfirmasi Password Baru",
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong lengkapi form';
                  }
                  if (value != _newPasswordC.text) {
                    return 'Password tidak cocok';
                  }
                  return null;
                },
              ),
              const Spacer(),
              SButton(
                loading: state is ProfileUpdatePasswordLoading,
                textStyle: lightText.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: const Icon(
                  Icons.save_outlined,
                  size: 14,
                  color: AppColors.textBrandOn,
                ),
                label: "Save",
                buttonStyle: primaryStyleButton,
                onPressed: () {
                  // Check if passwords match
                  if (_newPasswordC.text != _confirmPasswordC.text) {
                    showToastError(context, message: 'Password tidak sama');
                    return;
                  }
                  if (_formKey.currentState?.validate() ?? false) {
                    stateManagement.pushEvent(
                      ProfileUpdatePasswordExecute(
                        newPassword: _newPasswordC.text,
                        oldPassword: _oldPasswordC.text,
                      ),
                    );
                  } else {
                    showToastError(context,
                        message: 'Tolong lengkapi form yang kosong');
                  }
                },
              ),
            ],
          ),
        ));
  }

  @override
  // TODO: implement initialData
  ProfileUpdatePasswordState get initialData => ProfileUpdatePasswordInitial();
}
