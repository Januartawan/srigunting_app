import 'package:flutter/material.dart';
import 'package:srigunting_app/src/domain/reward.dart';
import 'package:srigunting_app/src/domain/balance.dart';
import 'package:srigunting_app/src/domain/transaction.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/chips/chips.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/shimmer/shimmer_list.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/tab/tab.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/card/card_redeem_point_item.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/list/lasy_load_scroll_view.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
import 'package:srigunting_app/src/ui/app/redeem_point/bloc/redeem_point_bloc.dart';
import 'package:srigunting_app/src/infrastructure/constant/point_status.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/image/image_svg.dart';
class RedeemPointScreen extends StatefulWidget {
  const RedeemPointScreen({super.key});
  @override
  State<RedeemPointScreen> createState() => _RedeemPointScreenState();
}
class _RedeemPointScreenState extends AUIManagement<RedeemPointBloc,
    RedeemPointState, RedeemPointScreen> {
  static const String _itemsTab = 'Items';
  static const String _historyTab = "Riwayat";
  String _selectedTab = _itemsTab;
  List<Reward>? rewards;
  Balance? totalPointUndian;
  Balance? availablePointReward;
  List<Transaction> history = [];
  dynamic pagination;
  bool isLoadingMore = false;
  int currentPage = 1;
  @override
  void onStart() {
    stateManagement.pushEvent(RedeemPointInitialEvent());
    super.onStart();
  }
  @override
  Widget buildState(BuildContext context, RedeemPointState state) {
    switch (state) {
      case RedeemPointInitialLoaded():
        rewards = state.dataReward;
        totalPointUndian = state.totalPointUndian;
        availablePointReward = state.availablePointReward;
        history = state.dataPointHistory ?? [];
        pagination = state.pagination;
        currentPage = 1;
        isLoadingMore = false;
        break;
      case RedeemPointLoadMoreHistoryLoading():
        isLoadingMore = true;
        break;
      case RedeemPointLoadMoreHistoryLoaded():
        history = state.dataPointHistory;
        pagination = state.pagination;
        isLoadingMore = false;
        break;
      case RedeemPointLoadMoreHistoryError():
        isLoadingMore = false;
        break;
      default:
    }
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        SScaffold(
          height: 260,
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
                      'Tukar Point',
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
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              children: [
                STab(
                  tabNames: const [_itemsTab, _historyTab],
                  initTab: _itemsTab,
                  onChanged: (v) {
                    setState(() {
                      _selectedTab = v;
                    });
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                _bodyTab(context, state)
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
              decoration: BoxDecoration(
                color: AppColors.bgBasePrimary,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(25),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Point (Akumulasi)',
                        style: lightText.copyWith(
                            decoration: TextDecoration.none,
                            color: AppColors.textBaseSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      state is RedeemPointInitialLoading
                          ? const SShimmerList(
                              height: 32,
                              width: 100,
                            )
                          : Text(
                              totalPointUndian?.totalPoint?.toString() ?? '0',
                              style: lightText.copyWith(
                                  decoration: TextDecoration.none,
                                  color: AppColors.textBasePrimary,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600),
                            ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Point tersedia yang bisa di tukar',
                        style: lightText.copyWith(
                            decoration: TextDecoration.none,
                            color: AppColors.textBaseSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      state is RedeemPointInitialLoading
                          ? const SShimmerList(
                              height: 32,
                              width: 100,
                            )
                          : Text(
                              availablePointReward?.totalPoint?.toString() ??
                                  '0',
                              style: lightText.copyWith(
                                  decoration: TextDecoration.none,
                                  color: AppColors.bgBrandPrimary,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600),
                            ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _bodyTab(BuildContext context, RedeemPointState state) {
    switch (_selectedTab) {
      case _itemsTab:
        return Expanded(child: _items(context, state));
      case _historyTab:
        return Expanded(child: _history(context, state));
      default:
        return Expanded(child: _items(context, state));
    }
  }
  Widget _items(BuildContext context, RedeemPointState state) {
    return state is RedeemPointInitialLoading
        ? ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: 20,
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemBuilder: (context, index) {
              return const SShimmerList(
                height: 100,
              );
            },
          )
        : (state is RedeemPointInitialLoaded &&
                (rewards == null || rewards!.isEmpty))
            ? _buildEmptyRedeemItems()
            : RefreshIndicator(
                color: AppColors.bgBrandPrimary,
                backgroundColor: AppColors.bgBasePrimary,
                onRefresh: () async {
                  stateManagement.pushEvent(RedeemPointInitialEvent());
                },
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: rewards?.length ?? 0,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 24),
                  itemBuilder: (context, index) {
                    final data = rewards?[index];
                    final availablePoints = double.tryParse(
                            availablePointReward?.totalPoint ?? '0') ??
                        0.0;
                    final requiredPoints = data?.minPoint ?? 0;
                    final canRedeem = availablePoints >= requiredPoints;

                    return CardRedeemPointItem(
                      imagePath: data?.image,
                      name: data?.name,
                      points: data?.minPoint.toString(),
                      stock: data?.stok.toString(),
                      onPressedRedeem: canRedeem
                          ? () {
                              pushNamed(
                                Routing.REDEEM_POINT_DETAIL,
                                arguments: {
                                  'image': data?.image,
                                  'name': data?.name,
                                  'point': data?.minPoint,
                                  'stock': data?.stok,
                                },
                              );
                            }
                          : null,
                    );
                  },
                ),
              );
  }
  Widget _history(BuildContext context, RedeemPointState state) {
    if (state is RedeemPointInitialLoading) {
      return const SShimmerList(height: 100);
    }
    if (history.isEmpty) {
      return _buildEmptyRedeemHistory();
    }
    return LazyLoadScrollView(
      onEndOfPage: _loadMoreHistory,
      isLoading: isLoadingMore,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: history.length + (isLoadingMore ? 1 : 0),
        separatorBuilder: (context, index) => const SizedBox(height: 24),
        itemBuilder: (context, index) {
          if (index == history.length && isLoadingMore) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final trx = history[index];
          ChipType chipType;
          if (trx.status == PointHistoryStatus.pointIn) {
            chipType = ChipType.success;
          } else if (trx.status == PointHistoryStatus.pointOut) {
            chipType = ChipType.danger;
          } else {
            chipType = ChipType.info;
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trx.trxCode ?? '-',
                    style: darkText.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBasePrimary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${trx.point ?? '0'} Points',
                    style: darkText.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textBaseSecondary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    trx.trxDate ?? '-',
                    style: darkText.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textBaseSecondary),
                  ),
                ],
              ),
              SChips2(
                label: PointHistoryStatus.displayLabel(
                  trx.status,
                  fallback: '-',
                ),
                type: chipType,
              )
            ],
          );
        },
      ),
    );
  }
  Widget _buildEmptyRedeemItems() {
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
              "Tidak ada item penukaran",
              style:
                  darkText.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Belum ada item yang bisa ditukar dengan point kamu.',
              style: darkText.copyWith(
                  fontSize: 14, color: AppColors.textBaseSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildEmptyRedeemHistory() {
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
              'Tidak ada riwayat penukaran point',
              style:
                  darkText.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Kamu belum pernah menukar point apapun.',
              style: darkText.copyWith(
                  fontSize: 14, color: AppColors.textBaseSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
  void _loadMoreHistory() {
    if (!isLoadingMore && pagination != null) {
      final nextPage = (pagination?.page ?? 0).toInt() + 1;
      final totalPages =
          (pagination?.totalRows ?? 0) / (pagination?.limit ?? 10);
      if (nextPage <= totalPages.ceil()) {
        currentPage = nextPage;
        stateManagement
            .pushEvent(RedeemPointLoadMoreHistoryEvent(page: nextPage));
      }
    }
  }
  @override
  RedeemPointState get initialData => RedeemPointInitial();
}