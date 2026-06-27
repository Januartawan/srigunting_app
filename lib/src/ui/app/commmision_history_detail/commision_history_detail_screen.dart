import 'package:flutter/material.dart';
import 'package:srigunting_app/src/domain/transaction.dart';
import 'package:srigunting_app/src/domain/transaction_detail.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/image/image_svg.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/line/line.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/brand_background.dart';
import 'package:srigunting_app/src/infrastructure/constant/commision_status.dart';
import 'package:srigunting_app/src/infrastructure/constant/point_status.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/extention/idr.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/ui/app/commmision_history_detail/bloc/commision_history_detail_bloc.dart';

class CommisionHistoryDetailScreen extends StatefulWidget {
  final Transaction transaction;

  const CommisionHistoryDetailScreen({super.key, required this.transaction});

  @override
  State<CommisionHistoryDetailScreen> createState() =>
      _ClaimedDetailScreenState();
}

class _ClaimedDetailScreenState extends AUIManagement<
    CommisionHistoryDetailBloc,
    CommisionHistoryDetailState,
    CommisionHistoryDetailScreen> {
  @override
  CommisionHistoryDetailState get initialData =>
      CommisionHistoryDetailInitial();

  @override
  void onStart() {
    if (widget.transaction.point == null &&
        widget.transaction.trxCode != null) {
      stateManagement.pushEvent(CommisionHistoryDetailInitialEvent(
        transaction: widget.transaction,
        trxCode: widget.transaction.trxCode!,
      ));
    }
    super.onStart();
  }

  @override
  Widget buildState(BuildContext context, CommisionHistoryDetailState state) {
    if (widget.transaction.point == null) {
      return _buildCommisionPage();
    } else {
      return _buildPointPage();
    }
  }

  Widget _buildPointPage() {
    return SBrandBgScaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              '${widget.transaction.status == PointHistoryStatus.pointIn ? 'Claim' : 'Redeem'} Detail',
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
                  '${widget.transaction.status == PointHistoryStatus.pointIn ? 'Claim' : 'Redeem'} successful',
                  style: darkText.copyWith(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 12,
                ),
                Center(
                  child: Text(
                    widget.transaction.status == PointHistoryStatus.pointIn ? 'Point have been successfully added' : 'Your total point have been deducted for the redemption',
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
                  'Point ${widget.transaction.status == PointHistoryStatus.pointIn ? 'Earned' : 'Redeemed'} ',
                  style: darkText.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textBaseSecondary),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  widget.transaction.point ?? '',
                  style: darkText.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: AppColors.bgBrandPrimary),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Claimed on ${widget.transaction.trxDate}',
                  style: darkText.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textBaseSecondary,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                //------
                // if (widget.transaction.status ==
                //     CommissionHistoryStatus.claim) ...[
                //   const SDashedLine(
                //     color: AppColors.borderBasePrimary,
                //   ),
                //   const SizedBox(
                //     height: 32,
                //   ),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Fron the transaction',
                //         style: darkText.copyWith(
                //             fontSize: 14, fontWeight: FontWeight.w400),
                //       ),
                //     ],
                //   ),
                //   const SizedBox(
                //     height: 4,
                //   ),
                //   Container(
                //     padding: EdgeInsets.all(8),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(16),
                //       border: Border.all(
                //         color: AppColors.borderBasePrimary,
                //       ),
                //     ),
                //     child: Row(
                //       children: [
                //         const Padding(
                //           padding: const EdgeInsets.all(12),
                //           child: Icon(
                //             Icons.receipt_long_outlined,
                //           ),
                //         ),
                //         const SizedBox(
                //           width: 16,
                //         ),
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               widget.transaction.trxCode ?? '',
                //               style: darkText.copyWith(
                //                   color: AppColors.textBasePrimary,
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.w600),
                //             ),
                //             const SizedBox(
                //               height: 4,
                //             ),
                //             Text(
                //               widget.transaction.susuk.convertIDR(),
                //               style: darkText.copyWith(
                //                   color: AppColors.textBaseSecondary,
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w400),
                //             ),
                //             const SizedBox(
                //               height: 4,
                //             ),
                //             Text(
                //               widget.transaction.trxDate ?? '',
                //               style: darkText.copyWith(
                //                   color: AppColors.textBaseSecondary,
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w400),
                //             )
                //           ],
                //         )
                //       ],
                //     ),
                //   )
                // ],
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
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCommisionPage() {
    return StreamBuilder<CommisionHistoryDetailState>(
        stream:
            stateManagement.stateStream as Stream<CommisionHistoryDetailState>?,
        builder: (context, snapshot) {
          final state = snapshot.data ?? initialData;

          if (state is CommisionHistoryDetailLoading) {
            return const SBrandBgScaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          }

          if (state is CommisionHistoryDetailError) {
            return SBrandBgScaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.error}',
                      style:
                          darkText.copyWith(color: AppColors.bgDangerPrimary),
                    ),
                    const SizedBox(height: 16),
                    SButton(
                      label: 'Retry',
                      buttonStyle: secondaryStyleButton,
                      onPressed: () {
                        if (widget.transaction.trxCode != null) {
                          stateManagement
                              .pushEvent(CommisionHistoryDetailInitialEvent(
                            transaction: widget.transaction,
                            trxCode: widget.transaction.trxCode!,
                          ));
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          TransactionDetail? transactionDetail;
          if (state is CommisionHistoryDetailLoaded) {
            transactionDetail = state.transactionDetail;
          }

          // Check if transactionDetail is null and show loading or error
          if (transactionDetail == null) {
            return const SBrandBgScaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          }

          return SBrandBgScaffold(
            body: Column(
              children: [
                Center(
                  child: Text(
                    '${widget.transaction.status!.contains(CommissionHistoryStatus.claim) ? 'Claim' : 'Redeem'} Detail',
                    textAlign: TextAlign.center,
                    style: lightText.copyWith(
                        fontSize: 20, fontWeight: FontWeight.w400),
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
                        '${transactionDetail.status?.contains(CommissionHistoryStatus.claim) == true ? 'Claim' : 'Redeem'} successful',
                        style: darkText.copyWith(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Center(
                        child: Text(
                          transactionDetail.status?.contains(CommissionHistoryStatus.claim) == true ? 'Commission have been successfully added' : 'Your total commision have been deducted for the redemption',
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
                        'Commission ${transactionDetail.status?.contains(CommissionHistoryStatus.claim) == true ? 'Earned' : 'Redeemed'} ',
                        style: darkText.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textBaseSecondary),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        (transactionDetail.susuk ?? 0).convertIDR(),
                        style: darkText.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: AppColors.bgBrandPrimary),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Claimed on ${transactionDetail.trxDate}',
                        style: darkText.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textBaseSecondary,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      //------

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
                            'From the transaction',
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
                                Icons.receipt_long_outlined,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transactionDetail.trxCode ?? '',
                                  style: darkText.copyWith(
                                      color: AppColors.textBasePrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  transactionDetail.ticketNumber ?? '',
                                  style: darkText.copyWith(
                                      color: AppColors.textBasePrimary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  (transactionDetail.susuk ?? 0).convertIDR(),
                                  style: darkText.copyWith(
                                      color: AppColors.textBaseSecondary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  transactionDetail.nationality ?? '',
                                  style: darkText.copyWith(
                                      color: AppColors.textBaseSecondary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Adult Pax: ${transactionDetail.adultPax ?? 0}, Child Pax: ${transactionDetail.childPax ?? 0}',
                                  style: darkText.copyWith(
                                      color: AppColors.textBaseSecondary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  transactionDetail.trxDate ?? '',
                                  style: darkText.copyWith(
                                      color: AppColors.textBaseSecondary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SButton(
                  label: 'Back',
                  buttonStyle: secondaryStyleButton,
                  textStyle: darkText.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w400),
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
        });
  }
}
