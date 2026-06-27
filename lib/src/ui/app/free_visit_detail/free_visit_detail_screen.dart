import 'package:flutter/material.dart';

import 'package:srigunting_app/src/domain/free_visit.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/image/image_svg.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/line/line.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/brand_background.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/ui/app/free_visit_detail/bloc/free_visit_detail_bloc.dart';

class FreeVisitDetailScreen extends StatefulWidget {
  final FreeVisit dataFreevisit;

  const FreeVisitDetailScreen({
    super.key,
    required this.dataFreevisit,
  });

  @override
  State<FreeVisitDetailScreen> createState() => _FreeVisitDetailScreenState();
}

class _FreeVisitDetailScreenState extends AUIManagement<FreeVisitDetailBloc,
    FreeVisitDetailState, FreeVisitDetailScreen> {
  FreeVisit? freeVisit;

  @override
  Widget buildState(BuildContext context, FreeVisitDetailState state) {
    switch (state) {
      case FreeVisitDetailLoaded():
        freeVisit = state.dataVisit;
        break;
      case FreeVisitDetailError():
        showToastError(context, message: state.error);
        break;
      default:
    }

    return SBrandBgScaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              'Free Visit Detail',
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
                  'Free Visit Available',
                  style: darkText.copyWith(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 12,
                ),
                Center(
                  child: Text(
                    'You have a free visit ticket available for Bali Bird Park ',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Adult',
                          style: darkText.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textBaseSecondary),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          widget.dataFreevisit.adult.toString(),
                          style: darkText.copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: AppColors.bgBrandPrimary),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Child',
                          style: darkText.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textBaseSecondary),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          widget.dataFreevisit.child.toString(),
                          style: darkText.copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: AppColors.bgBrandPrimary),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Date Visit ${widget.dataFreevisit.dateVisit ?? '-'}',
                  style: darkText.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textBaseSecondary,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                if (freeVisit?.note != null) ...[
                  const SDashedLine(
                    color: AppColors.borderBasePrimary,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Additional Information',
                        style: darkText.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.borderBasePrimary,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.info_outline,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Text(
                            freeVisit?.note ?? '',
                            style: darkText.copyWith(
                                color: AppColors.textBasePrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ],
            ),
          ),
          const Spacer(),
          SButton(
            label: 'Back',
            buttonStyle: secondaryStyleButton,
            textStyle:
                darkText.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
            prefixIcon: const Icon(
              Icons.arrow_back_rounded,
              size: 14,
              color: AppColors.iconBasePrimary,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );
  }

  @override
  FreeVisitDetailState get initialData => FreeVisitDetailInitial();
}
