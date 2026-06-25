import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/image/image_svg.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';

class SBrandBgScaffold extends StatelessWidget {
  final Widget body;

  const SBrandBgScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.bgBrandTeritaryInvert,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -110,
            top: -90,
            child: SImageSvgAsset(
              fileName: 'bali_bird_park_mark.svg',
              height: 400,
              colorFilter: ColorFilter.mode(
                AppColors.bgBrandPrimary.withOpacity(0.2),
                BlendMode.srcIn,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            child: SafeArea(bottom: false, child: body),
          )
        ],
      ),
    );
  }
}
