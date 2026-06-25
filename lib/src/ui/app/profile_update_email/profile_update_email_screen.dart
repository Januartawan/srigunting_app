import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/text_field/text_field.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'bloc/profile_update_email_bloc.dart';

class ProfileUpdateEmailScreen extends StatefulWidget {
  const ProfileUpdateEmailScreen({super.key});

  @override
  State<ProfileUpdateEmailScreen> createState() =>
      _ProfileUpdateEmailScreenState();
}

class _ProfileUpdateEmailScreenState extends AUIManagement<
    ProfileUpdateEmailBloc, ProfileUpdateEmailState, ProfileUpdateEmailScreen> {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  @override
  Widget buildState(BuildContext context, ProfileUpdateEmailState state) {
    switch (state) {
      case ProfileUpdateEmailExecuteSuccess():
        showToastSuccess(context, message: "Update Email Success");
        Future.microtask(() {
          Navigator.pop(context, true);
        });
        break;
      case ProfileUpdateEmailExecuteError():
        showToastError(context, message: state.error);
        break;
      default:
    }

    return SScaffold(
      title: 'Update Email',
      onBackAction: () {
        Navigator.pop(context, true);
      },
      body: ListView(
        padding: const EdgeInsets.only(
          bottom: 24,
        ),
        children: [
          STextField(
            controller: emailC,
            label: "Email Baru",
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          STextField(
            controller: passwordC,
            label: "Password",
            obscureText: true,
          ),
          const SizedBox(height: 24),
          SButton(
            loading: state is ProfileUpdateEmailExecuteLoading,
            textStyle: lightText.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: const Icon(
              Icons.save_outlined,
              size: 14,
              color: AppColors.textBrandOn,
            ),
            label: "Simpan Email Baru",
            buttonStyle: primaryStyleButton,
            onPressed: () {
              stateManagement.pushEvent(
                ProfileUpdateEmailExecuteEvent(
                  email: emailC.text,
                  password: passwordC.text,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  ProfileUpdateEmailState get initialData => ProfileUpdateEmailInitial();
}
