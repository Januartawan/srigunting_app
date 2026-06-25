import 'package:flutter/material.dart';

import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';

class CardRedeemPointItem extends StatelessWidget {
  final String? name;
  final String? points;
  final String? stock;
  final String? imagePath;
  final Function()? onPressedRedeem;
  const CardRedeemPointItem(
      {Key? key,
      this.name,
      this.points,
      this.stock,
      this.imagePath,
      this.onPressedRedeem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.all(
          color: AppColors.borderBasePrimary,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imagePath != null && imagePath!.isNotEmpty
                    ? NetworkImage(imagePath!)
                    : AssetImage('assets/images/srigunting-bird.png')
                        as ImageProvider,
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name ?? '',
                style: darkText.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBasePrimary),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '$points Points',
                style: darkText.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textBaseSecondary),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '$stock in stock',
                style: darkText.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSuccessTeritary),
              )
            ],
          ),
          SButton(
            label: 'Tukar',
            buttonStyle: onPressedRedeem != null
                ? primaryStyleButton
                : disabledStyleButton,
            textStyle: onPressedRedeem != null
                ? lightText
                : darkText.copyWith(color: AppColors.textBaseSecondary),
            onPressed: onPressedRedeem,
          )
        ],
      ),
    );
  }
}
