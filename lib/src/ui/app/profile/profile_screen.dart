import 'package:flutter/material.dart';
import 'package:srigunting_app/src/domain/free_visit.dart';
import 'package:srigunting_app/src/domain/guide.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/shimmer/shimmer_list.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
import 'package:srigunting_app/src/ui/app/profile/bloc/profile_bloc.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState
    extends AUIManagement<ProfileBloc, ProfileState, ProfileScreen> {
  Guide? guide;
  FreeVisit? freeVisit;
  @override
  void onStart() {
    stateManagement.pushEvent(ProfileInitialEvent());
    super.onStart();
  }
  @override
  Widget buildState(BuildContext context, ProfileState state) {
    switch (state) {
      case ProfileInitialLoaded():
        guide = state.dataGuide;
        freeVisit = state.dataFreeVisit;
      case ProfileInitialError():
        showToastError(context, message: state.error);
      case ProfileLogoutSuccess():
        pushReplacementNamed(Routing.INITIAL_PAGE);
        Navigator.of(context, rootNavigator: true).pop();
        break;
      default:
    }
    return SScaffold(
      bodyPadding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      headerBody: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
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
                const SizedBox(
                  width: 6,
                ),
                Text(
                  'Data Diri',
                  style: lightText.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.bgBrandPrimary,
                    AppColors.bgBrandPrimary.withAlpha(204),
                  ],
                ),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: AppColors.bgBasePrimary.withAlpha(51),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.bgBrandPrimary.withAlpha(76),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: state is ProfileInitialLoading
                    ? const SShimmerList(
                        width: 35,
                        height: 35,
                      )
                    : Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.bgBasePrimary.withAlpha(25),
                        ),
                        child: Center(
                          child: Text(
                            _getInitial(guide?.name ?? ''),
                            style: lightText.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: AppColors.bgBasePrimary,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 14),
            state is ProfileInitialLoading
                ? const SShimmerList()
                : Text(
                    guide?.name ?? '',
                    style: lightText.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            state is ProfileInitialLoading
                ? const SizedBox(height: 14)
                : Container(),
            state is ProfileInitialLoading
                ? const SShimmerList(
                    width: 100,
                  )
                : Text(
                    guide?.guideCode ?? '',
                    style: lightText.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  )
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Pengaturan',
                style: darkText.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBaseSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          ProfileMenu(
            icon: const Icon(Icons.person_outline_outlined),
            title: 'Data Diri',
            onTap: () {
              pushNamed(Routing.PROFILE_SHOW);
            },
          ),
          const Divider(
            height: 1,
            color: AppColors.borderBasePrimary,
          ),
          ProfileMenu(
            icon: const Icon(Icons.key_outlined),
            title: 'Ganti Password',
            onTap: () {
              pushNamed(Routing.RESET_PASSWORD);
            },
          ),
          const Divider(
            height: 1,
            color: AppColors.borderBasePrimary,
          ),
          const SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  backgroundColor: AppColors.bgBasePrimary,
                  insetPadding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: AppColors.bgDangerTeritary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.logout_rounded,
                            color: AppColors.bgDangerPrimary,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Keluar Akun',
                          textAlign: TextAlign.center,
                          style: darkText.copyWith(
                            color: AppColors.textBasePrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Apakah Anda yakin ingin keluar dari akun ini?',
                          textAlign: TextAlign.center,
                          style: darkText.copyWith(
                            color: AppColors.textBaseSecondary,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: SButton(
                            loading: state is ProfileLogoutLoading,
                            label: 'Keluar',
                            textStyle: lightText.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            buttonStyle: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              backgroundColor: AppColors.bgDangerPrimary,
                            ),
                            onPressed: () {
                              stateManagement
                                  .pushEvent(ProfileLogoutExecute());
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: SButton(
                            label: 'Batal',
                            textStyle: darkText.copyWith(
                              color: AppColors.textBasePrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            buttonStyle: secondaryStyleButton,
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 70,
              color: Colors.transparent,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Logout',
                    style: darkText.copyWith(
                      color: AppColors.textDangerPrimary,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    Icons.logout_outlined,
                    color: AppColors.textDangerPrimary,
                    size: 16,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  @override
  ProfileState get initialData => ProfileInitial();
  String _getInitial(String name) {
    if (name.isEmpty) return '';
    return name.trim().split(' ').first[0].toUpperCase();
  }
}
class ProfileMenu extends StatelessWidget {
  final Widget? icon;
  final String title;
  final void Function()? onTap;
  const ProfileMenu({super.key, this.icon, required this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(color: AppColors.bgBasePrimary),
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
        child: Row(
          children: [
            if (icon != null) ...[
              icon ?? Container(),
              const SizedBox(
                width: 6,
              ),
            ],
            Text(
              title,
              style: darkText.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textBasePrimary,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}