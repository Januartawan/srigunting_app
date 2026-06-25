import 'package:flutter/material.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';

class RewardAndPointScreen extends StatefulWidget {
  const RewardAndPointScreen({super.key});

  @override
  State<RewardAndPointScreen> createState() => _RewardAndPointScreenState();
}

class _RewardAndPointScreenState extends State<RewardAndPointScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        SScaffold(
          fullHeight: true,
          height: 200,
          headerBody: Padding(
            padding: const EdgeInsets.all(24.0),
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
                      'Reward & Point',
                      style: lightText.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                //WHITE CARD
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, Routing.REWARD_AND_POINT_DETAIL);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.bgBasePrimary,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/srigunting-bird.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  topLeft: Radius.circular(12),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'UNDIAN HADIAH - PERIODE OKTOBER',
                                    style: darkText.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: AppColors.textBaseSecondary,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        '7 Oct 2024',
                                        style: darkText.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textBaseSecondary),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        color: AppColors.textBaseSecondary,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        '11:00AM',
                                        style: darkText.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textBaseSecondary),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.bgBasePrimary,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 300,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/srigunting-bird.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                                topLeft: Radius.circular(12),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'UNDIAN HADIAH - PERIODE OKTOBER',
                                  style: darkText.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month_outlined,
                                      color: AppColors.textBaseSecondary,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      '7 Oct 2024',
                                      style: darkText.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textBaseSecondary),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: AppColors.textBaseSecondary,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      '11:00AM',
                                      style: darkText.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textBaseSecondary),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 120,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              width: 350,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.bgBasePrimary,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Point (accumulated)',
                            style: lightText.copyWith(
                                color: AppColors.textBaseSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '1,540',
                            style: lightText.copyWith(
                                color: AppColors.bgBrandPrimary,
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Available Point (can be redeem)',
                            style: lightText.copyWith(
                                color: AppColors.textBaseSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '960',
                            style: lightText.copyWith(
                                color: AppColors.textBasePrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SButton(
                    label: 'Redeem Point',
                    buttonStyle: secondaryStyleButton,
                    textStyle: darkText.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w400),
                    suffixIcon: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: AppColors.iconBasePrimary,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routing.REDEEM_POINT);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
