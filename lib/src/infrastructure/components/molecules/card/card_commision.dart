import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/image/image_svg.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';

enum CardCommisionType { claimed, redeem }

class CardCommision extends StatelessWidget {
  final String? date;
  final String? amount;
  final String? label;
  final CardCommisionType? type;
  final Function()? onTap;

  const CardCommision(
      {super.key, this.date, this.amount, this.label, this.type, this.onTap});

  String? get _defaultLabel {
    if (type == CardCommisionType.claimed) return 'Komisi Di-klaim';
    if (type == CardCommisionType.redeem) return 'Komisi Dicairkan';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final title = label ?? _defaultLabel;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            if (type == CardCommisionType.claimed)
              const SImageSvgAsset(
                fileName: "icon_download.svg",
                height: 44,
              ),
            if (type == CardCommisionType.redeem)
              const SImageSvgAsset(
                fileName: "icon_upload.svg",
                height: 44,
              ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title,
                    style: darkText.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  date ?? '',
                  style: darkText.copyWith(
                      color: AppColors.textBaseSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            const Spacer(),
            if (type == CardCommisionType.redeem)
              Text(
                '- $amount',
                style: lightText.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDangerTeritary),
              ),
            if (type == CardCommisionType.claimed)
              Text(
                '+ $amount',
                style: lightText.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSuccessTeritary),
              )
          ],
        ),
      ),
    );
  }
}
