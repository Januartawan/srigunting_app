import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/text_field/text_field.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'bloc/profile_update_username_bloc.dart';
class ProfileUpdateUsernameScreen extends StatefulWidget {
  const ProfileUpdateUsernameScreen({super.key});
  @override
  State<ProfileUpdateUsernameScreen> createState() =>
      _ProfileUpdateUsernameScreenState();
}
class _ProfileUpdateUsernameScreenState extends AUIManagement<
    ProfileUpdateUsernameBloc,
    ProfileUpdateUsernameState,
    ProfileUpdateUsernameScreen> {
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();
  @override
  Widget buildState(BuildContext context, ProfileUpdateUsernameState state) {
    switch (state) {
      case ProfileUpdateUsernameExecuteSuccess():
        showToastSuccess(context, message: "Update Username Success");
        Future.microtask(() {
          if (!mounted) return;
          Navigator.of(this.context).pop(true);
        });
        break;
      case ProfileUpdateUsernameExecuteError():
        showToastError(context, message: state.error);
        break;
      default:
    }
    return SScaffold(
      title: 'Update Username',
      onBackAction: () {
        Navigator.pop(context, true);
      },
      body: ListView(
        padding: const EdgeInsets.only(
          bottom: 24,
        ),
        children: [
          STextField(
            controller: usernameC,
            label: "Username Baru",
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 12),
          STextField(
            controller: passwordC,
            label: "Password",
            obscureText: true,
          ),
          const SizedBox(height: 24),
          SButton(
            loading: state is ProfileUpdateUsernameExecuteLoading,
            textStyle: lightText.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: const Icon(
              Icons.save_outlined,
              size: 14,
              color: AppColors.textBrandOn,
            ),
            label: "Simpan Username Baru",
            buttonStyle: primaryStyleButton,
            onPressed: () {
              stateManagement.pushEvent(
                ProfileUpdateUsernameExecuteEvent(
                  username: usernameC.text,
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
  ProfileUpdateUsernameState get initialData => ProfileUpdateUsernameInitial();
}