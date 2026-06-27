import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/image/image_svg.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/brand_background.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
class RedeemPointDetailSecondScreen extends StatefulWidget {
  const RedeemPointDetailSecondScreen({super.key});
  @override
  State<RedeemPointDetailSecondScreen> createState() =>
      _RedeemPointDetailSecondScreenState();
}
class _RedeemPointDetailSecondScreenState
    extends State<RedeemPointDetailSecondScreen> {
  @override
  Widget build(BuildContext context) {
    return SBrandBgScaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              'Detail',
              textAlign: TextAlign.center,
              style:
                  lightText.copyWith(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 48,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.bgBasePrimary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                const SImageSvgAsset(
                  fileName: 'icon_check.svg',
                  height: 56,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Selamat!\nanda berhasil menukarkan point',
                  style: darkText.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 12,
                ),
                Center(
                  child: Text(
                    'Silahkan tunjukan bukti ini ke office Srigunting untuk mengambil reward',
                    style: darkText.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textBaseSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  'Waktu Pengambilan',
                  style: darkText.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textBaseSecondary),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Senin - Minggu, Pukul 09.00 - 17.30',
                  style: darkText.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBasePrimary,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
          const Spacer(),
          SButton(
            label: 'Kembali',
            buttonStyle: secondaryStyleButton,
            textStyle:
                darkText.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
            prefixIcon: const Icon(
              Icons.arrow_back_rounded,
              size: 14,
              color: AppColors.iconBasePrimary,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}