import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:srigunting_app/src/domain/guide.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/shimmer/shimmer_list.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/ui/app/profile_show/bloc/profile_show_bloc.dart';
import 'package:srigunting_app/src/ui/app/profile_update/profile_update_screen.dart';
class ProfileShowScreen extends StatefulWidget {
  const ProfileShowScreen({super.key});
  @override
  State<ProfileShowScreen> createState() => _ProfileShowScreenState();
}
class _ProfileShowScreenState extends AUIManagement<ProfileShowBloc,
    ProfileShowState, ProfileShowScreen> {
  Guide? guide;
  Guide? detailAccountData;
  @override
  void onStart() {
    stateManagement.pushEvent(ProfileShowInitialEvent());
    super.onStart();
  }
  void _goToUpdatePage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => ProfileUpdateScreen(guide: guide ?? Guide())),
    );
    if (!mounted) return;
    if (result == true) {
      stateManagement.pushEvent(ProfileShowInitialEvent());
    }
  }
  @override
  Widget buildState(BuildContext context, ProfileShowState state) {
    switch (state) {
      case ProfileShowLoaded():
        guide = state.dataGuide;
        detailAccountData = state.detailAccountData;
      case ProfileShowError():
        showToastError(context, message: state.error);
        break;
      default:
    }
    return SScaffold(
      title: 'Detail Data Diri',
      onBackAction: () {
        Navigator.pop(context);
      },
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...(() {
                  final fields = [
                    {
                      'title': 'Nomor KTP',
                      'value': guide?.nik?.toString() ?? ''
                    },
                    {
                      'title': 'Username',
                      'value': detailAccountData?.username ?? ''
                    },
                    {'title': 'Nama Lengkap', 'value': guide?.name ?? ''},
                    {'title': 'Email', 'value': guide?.email ?? ''},
                    {
                      'title': 'Nomor WhatsApp',
                      'value': guide?.phonenumber ?? ''
                    },
                    {
                      'title': 'Tanggal Lahir',
                      'value': guide?.birthDateFormatted ?? ''
                    },
                    {'title': 'Alamat', 'value': guide?.address ?? ''},
                    {'title': 'Agama', 'value': guide?.religion ?? ''},
                    {'title': 'Jenis Kelamin', 'value': guide?.gender ?? ''},
                  ];
                  if (state is ProfileShowLoading) {
                    return fields
                        .expand((item) => [
                              _infoListSingle(state, item['title']!, ''),
                              const SizedBox(height: 24),
                            ])
                        .toList();
                  } else {
                    return fields
                        .where((item) =>
                            (item['value'] as String).trim().isNotEmpty)
                        .expand((item) => [
                              _infoListSingle(
                                  state, item['title']!, item['value']!),
                              const SizedBox(height: 24),
                            ])
                        .toList();
                  }
                })(),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: Column(
                children: [
                  state is ProfileShowLoading
                      ? const SShimmerList()
                      : Text(
                          'Member ID: ${guide?.guideCode}',
                          style: darkText.copyWith(
                            color: AppColors.textBasePrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SButton(
              textStyle: lightText.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              suffixIcon: const Icon(
                Icons.arrow_forward_rounded,
                size: 14,
                color: AppColors.textBrandOn,
              ),
              label: "Edit Data Diri",
              buttonStyle: primaryStyleButton,
              onPressed: () {
                _goToUpdatePage();
              },
            ),
            const SizedBox(height: 14),
            SButton(
              textStyle: lightText.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              suffixIcon: const Icon(
                Icons.email_outlined,
                size: 14,
                color: AppColors.textBrandOn,
              ),
              label: "Update Email",
              buttonStyle: primaryStyleButton,
              onPressed: () async {
                final result =
                    await Navigator.pushNamed(context, '/profile/update-email');
                if (!mounted) return;
                if (result == true) {
                  stateManagement.pushEvent(ProfileShowInitialEvent());
                }
              },
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: SButton(
                textStyle: lightText.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: const Icon(
                  Icons.person_outline,
                  size: 14,
                  color: AppColors.textBrandOn,
                ),
                label: "Update Username",
                buttonStyle: primaryStyleButton,
                onPressed: () async {
                  final result = await Navigator.pushNamed(
                      context, '/profile/update-username');
                  if (!mounted) return;
                  if (result == true) {
                    stateManagement.pushEvent(ProfileShowInitialEvent());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _infoListSingle(
      ProfileShowState state, String title, String subtitle) {
    if (state is ProfileShowLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 120,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const SShimmerList(),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: darkText.copyWith(
            color: AppColors.textBaseSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          subtitle,
          style: darkText.copyWith(
            color: AppColors.textBasePrimary,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
  @override
  ProfileShowState get initialData => ProfileShowInitial();
}