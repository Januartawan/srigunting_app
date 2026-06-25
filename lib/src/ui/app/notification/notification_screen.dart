import 'package:flutter/material.dart';
import 'package:srigunting_app/src/domain/notification.dart';
import 'package:srigunting_app/src/domain/pagination.dart';
import 'package:srigunting_app/src/domain/transaction.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/image/image_svg.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/shimmer/shimmer_list.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/list/lasy_load_scroll_view.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/state_management/ui.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:srigunting_app/src/routing/routing_constant.dart';
import 'package:srigunting_app/src/ui/app/notification/bloc/notification_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends AUIManagement<NotificationBloc,
    NotificationState, NotificationScreen> {
  List<NotificationApp> notifications = [];
  Pagination<NotificationApp>? pagination;
  bool isLoadingMore = false;
  int currentPage = 1;
  String? loadingNotificationId; // Track which notification is loading

  @override
  void onStart() {
    stateManagement.pushEvent(NotificationInitialEvent());
    super.onStart();
  }

  @override
  Widget buildState(BuildContext context, NotificationState state) {
    switch (state) {
      case NotificationInitialLoaded():
        notifications = state.dataNotification;
        pagination = state.pagination;
        currentPage = 1;
        isLoadingMore = false;
      case NotificationLoadMoreLoading():
        isLoadingMore = true;
      case NotificationLoadMoreLoaded():
        notifications.addAll(state.dataNotification);
        pagination = state.pagination;
        isLoadingMore = false;
      case NotificationLoadMoreError():
        isLoadingMore = false;
        showToastError(context, message: state.error);
      case NotificationInitialError():
        showToastError(context, message: state.error);
        break;
      case NotificationShowDetailLoaded():
        loadingNotificationId = null; // Clear loading state
        _navigateToCommissionHistoryDetail(state.notification);
        break;
      case NotificationShowDetailError():
        loadingNotificationId = null; // Clear loading state
        showToastError(context, message: state.error);
        break;
      case NotificationShowTransactionDetailLoaded():
        loadingNotificationId = null; // Clear loading state
        pushNamed(Routing.CLAIMED_DETAIL,
            arguments: {"transaction": state.notifTransaction});
        break;
      case NotificationShowFreeVisitDetailLoaded():
        loadingNotificationId = null; // Clear loading state
        pushNamed(Routing.FREE_VISIT_DETAIL,
            arguments: {"free_visit": state.notifFreeVisit});
        break;
      case NotificationShowFreeVisitDetailError():
        loadingNotificationId = null; // Clear loading state
        showToastError(context, message: state.error);
        break;
      case NotificationShowTransactionDetailError():
        loadingNotificationId = null; // Clear loading state
        showToastError(context, message: state.error);
        break;
      case NotificationShowDetailLoading():
        // Loading state is already set in _onNotificationTap
        break;
      case NotificationShowTransactionDetailLoading():
        // Loading state is already set in _onNotificationTap
        break;
      case NotificationShowFreeVisitDetailLoading():
        // Loading state is already set in _onNotificationTap
        break;
      default:
    }

    return SScaffold(
      title: 'Notification',
      onBackAction: () {
        Navigator.pop(context);
      },
      body: Column(
        children: [
          Expanded(
            child: LazyLoadScrollView(
              onEndOfPage: () {
                _loadMore();
              },
              isLoading: isLoadingMore,
              child: state is NotificationInitialLoading
                  ? ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: 5,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        return const SShimmerList(
                          height: 100,
                        );
                      },
                    )
                  : (state is NotificationInitialLoaded &&
                          notifications.isEmpty &&
                          !isLoadingMore)
                      ? _buildEmptyNotification()
                      : RefreshIndicator(
                          color: AppColors.bgBrandPrimary,
                          backgroundColor: AppColors.bgBasePrimary,
                          onRefresh: () async {
                            currentPage = 1;
                            notifications.clear();
                            stateManagement
                                .pushEvent(NotificationInitialEvent());
                          },
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount:
                                notifications.length + (isLoadingMore ? 1 : 0),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              if (index == notifications.length) {
                                return const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              return GestureDetector(
                                onTap: () {
                                  _onNotificationTap(notifications[index]);
                                },
                                child: _buildNotificationList(
                                  description: notifications[index].description,
                                  date: notifications[index].date,
                                  isRead: notifications[index].isRead,
                                  isLoading: loadingNotificationId ==
                                      notifications[index].slug,
                                ),
                              );
                            },
                          ),
                        ),
            ),
          ),
        ],
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
        stateManagement.pushEvent(NotificationLoadMoreEvent(page: nextPage));
      }
    }
  }

  void _onNotificationTap(NotificationApp notification) {
    final slug = notification.slug;
    if (slug != null) {
      // Set loading state for this notification
      loadingNotificationId = notification.slug;

      if (slug.startsWith('reward-point')) {
        stateManagement
            .pushEvent(NotificationShowDetailTransactionEvent(slug: slug));
      } else if (slug.startsWith('susuk-detail')) {
        stateManagement
            .pushEvent(NotificationShowDetailTransactionEvent(slug: slug));
      } else if (slug.startsWith('free-visit')) {
        stateManagement
            .pushEvent(NotificationShowDetailFreeVisitEvent(slug: slug));
      } else {
        // Handle unknown slug or show error
        loadingNotificationId = null; // Clear loading state
        showToastError(context, message: 'Unknown notification type');
      }
    }
  }

  void _navigateToCommissionHistoryDetail(NotificationApp notification) {
    switch (notification.slug) {
      case 'reward-point':
        Navigator.pushNamed(
          context,
          Routing.REWARD_AND_POINT_DETAIL,
        );
        break;
      case 'susuk-detail':
        // Create a Transaction object from notification data
        final transaction = Transaction(
          trxCode: notification.name,
          status: 'claim', // Default status
          point: null,
          susuk: 0,
          trxDate: notification.date,
        );
        Navigator.pushNamed(
          context,
          Routing.CLAIMED_DETAIL,
          arguments: {"transaction": transaction},
        );
        break;
      case 'free-visit':
        Navigator.pushNamed(
          context,
          Routing.FREE_VISIT_DETAIL,
        );
        break;
      default:
        // Handle unknown slug or show error
        showToastError(context, message: 'Unknown notification type');
        break;
    }
  }

  Widget _buildNotificationList(
      {String? description,
      String? date,
      bool isRead = false,
      bool isLoading = false}) {
    return Container(
      color: AppColors.bgBasePrimary,
      child: Row(
        children: [
          isLoading
              ? const SizedBox(
                  width: 44,
                  height: 44,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.bgBrandPrimary,
                    ),
                  ),
                )
              : const SImageSvgAsset(
                  fileName: "check_outline.svg",
                  height: 44,
                ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description ?? '',
                  style: darkText.copyWith(
                    fontSize: 14,
                    fontWeight: isRead ? FontWeight.w400 : FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  date ?? '',
                  style: darkText.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEmptyNotification() {
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
              'Tidak ada notifikasi',
              style:
                  darkText.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Kamu belum memiliki notifikasi apapun saat ini.',
              style: darkText.copyWith(
                  fontSize: 14, color: AppColors.textBaseSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement initialData
  NotificationState get initialData => NotificationInitial();
}
