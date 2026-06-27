import 'package:flutter/material.dart';
import 'package:srigunting_app/src/domain/balance.dart';
import 'package:srigunting_app/src/domain/guide.dart';
import 'package:srigunting_app/src/domain/transaction.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/image/image_svg.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/qr_code/qr_code.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/shimmer/shimmer_list.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/card/card_commision.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/list/lasy_load_scroll_view.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/constant/commision_status.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/extention/idr.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
import 'package:srigunting_app/src/ui/app/commision_history/bloc/commision_history_bloc.dart';
import 'package:srigunting_app/src/domain/pagination.dart';

class CommisionHistoryScreen extends StatefulWidget {
  const CommisionHistoryScreen({super.key});

  @override
  State<CommisionHistoryScreen> createState() => _CommisionHistoryScreenState();
}

class _CommisionHistoryScreenState extends AUIManagement<CommisionHistoryBloc,
    CommisionHistoryState, CommisionHistoryScreen> {
  Guide? guide;
  Balance? balance;
  Balance? reward;
  List<Transaction>? commisionHistory;
  List<Transaction>? pointHistory;
  Pagination<Transaction>? pagination;
  bool isLoadingMore = false;
  int currentPage = 1;

  @override
  void onStart() {
    stateManagement.pushEvent(CommisionHistoryInitialEvent());
    super.onStart();
  }

  @override
  Widget buildState(BuildContext context, CommisionHistoryState state) {
    switch (state) {
      case CommisionInitialLoaded():
        balance = state.dataBalance;
        guide = state.dataGuide;
        reward = state.dataPointReward;
        commisionHistory = state.dataCommissionHistory;
        pointHistory = state.dataPointHistory;
        pagination = state.pagination;
        currentPage = 1;
        isLoadingMore = false;
        break;
      case CommisionLoadMoreLoading():
        isLoadingMore = true;
        break;
      case CommisionLoadMoreLoaded():
        commisionHistory = state.dataCommissionHistory;
        pagination = state.pagination;
        isLoadingMore = false;
        break;
      case CommisionLoadMoreError():
        isLoadingMore = false;
        break;
      default:
    }

    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        SScaffold(
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
                      'Riwayat Susuk',
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
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                _commisionHistory(context, state)
              ],
            ),
          ),
        ),
        Positioned(
          top: 100,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              width: 350,
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.bgBasePrimary,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(26),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Susuk',
                            style: lightText.copyWith(
                                decoration: TextDecoration.none,
                                color: AppColors.textBaseSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          state is CommisionInitialLoading
                              ? const SShimmerList()
                              : Text(
                                  balance?.balance.convertIDR() ?? '',
                                  style: lightText.copyWith(
                                      decoration: TextDecoration.none,
                                      color: AppColors.bgBrandPrimary,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Point',
                            style: lightText.copyWith(
                                decoration: TextDecoration.none,
                                color: AppColors.textBaseSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          state is CommisionInitialLoading
                              ? const SShimmerList()
                              : Text(
                                  reward?.totalPoint.toString() ?? '',
                                  style: lightText.copyWith(
                                      decoration: TextDecoration.none,
                                      color: AppColors.textBasePrimary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                child: _dialogShowQr(
                                    context, guide?.guideCode ?? '')),
                          );
                        },
                        child: Column(
                          children: [
                            SQRCode(
                              data: guide?.guideCode ?? '',
                              size: 100.0,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            state is CommisionInitialLoading
                                ? const SShimmerList(
                                    width: 100,
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            width: 1,
                                            color:
                                                AppColors.borderBaseTeritary)),
                                    child: Text(
                                      guide?.guideCode ?? '',
                                      style: darkText.copyWith(
                                        decoration: TextDecoration.none,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
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
        ),
      ],
    );
  }

  Widget _dialogShowQr(BuildContext context, String idMember) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgBasePrimary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Member ID Semeton',
                style: darkText.copyWith(
                  color: AppColors.textBasePrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.bgBrandTeritaryInvert,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.bgBasePrimary,
                          borderRadius: BorderRadius.circular(16)),
                      child: SQRCode(
                        data: idMember,
                        size: 250.0,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      idMember,
                      style: lightText.copyWith(
                          fontSize: 14, color: AppColors.textBrandOn),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Gunakan QR Code ini untuk klaim susuk',
                textAlign: TextAlign.center,
                style: darkText.copyWith(
                    color: AppColors.textBasePrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 12,
              ),
              SButton(
                label: 'Close',
                textStyle: darkText.copyWith(
                    fontSize: 14, fontWeight: FontWeight.w400),
                buttonStyle: secondaryStyleButton,
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _commisionHistory(BuildContext context, CommisionHistoryState state) {
    return Expanded(
      child: LazyLoadScrollView(
        onEndOfPage: () {
          _loadMore();
        },
        isLoading: isLoadingMore,
        child: state is CommisionInitialLoading
            ? ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: 60,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  return const SShimmerList(
                    height: 60,
                  );
                },
              )
            : (state is CommisionInitialLoaded &&
                    (commisionHistory == null || commisionHistory!.isEmpty) &&
                    !isLoadingMore)
                ? _buildEmptyCommisionHistory()
                : RefreshIndicator(
                    color: AppColors.bgBrandPrimary,
                    backgroundColor: AppColors.bgBasePrimary,
                    onRefresh: () async {
                      currentPage = 1;
                      commisionHistory?.clear();
                      stateManagement.pushEvent(CommisionHistoryInitialEvent());
                    },
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: (commisionHistory?.length ?? 0) +
                          (isLoadingMore ? 1 : 0),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 24),
                      itemBuilder: (context, index) {
                        if (index == (commisionHistory?.length ?? 0)) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        final data = commisionHistory?[index];
                        return CardCommision(
                          date: commisionHistory?[index].trxDate,
                          type: data?.status?.contains(
                                      CommissionHistoryStatus.claim) ==
                                  true
                              ? CardCommisionType.claimed
                              : CardCommisionType.redeem,
                          amount: data?.susuk.convertIDR() ?? '0',
                          onTap: () {
                            pushNamed(
                              Routing.CLAIMED_DETAIL,
                              arguments: {
                                "transaction": commisionHistory?[index]
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
      ),
    );
  }

  void _loadMore() {
    if (!isLoadingMore && pagination != null) {
      final nextPage = (pagination!.page ?? 0).toInt() + 1;
      final totalPages =
          (pagination!.totalRows ?? 0) / (pagination!.limit ?? 10);
      if (nextPage <= totalPages.ceil()) {
        currentPage = nextPage;
        stateManagement
            .pushEvent(CommisionHistoryLoadMoreEvent(page: nextPage));
      }
    }
  }

  @override
  CommisionHistoryState get initialData => CommisionHistoryInitial();

  Widget _buildEmptyCommisionHistory() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SImageSvgAsset(
              fileName: "icon_information.svg",
              height: 100,
            ),
            const SizedBox(height: 24),
            Text(
              'Tidak ada riwayat susuk',
              style:
                  darkText.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Kamu belum memiliki riwayat susuk apapun saat ini.',
              style: darkText.copyWith(
                  fontSize: 14, color: AppColors.textBaseSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
