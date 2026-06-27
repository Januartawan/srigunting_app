import 'package:flutter/foundation.dart';
import 'package:srigunting_app/src/domain/balance.dart';
import 'package:srigunting_app/src/domain/guide.dart';
import 'package:srigunting_app/src/domain/information.dart';
import 'package:srigunting_app/src/domain/pagination.dart';
import 'package:srigunting_app/src/domain/notification.dart';
import 'package:srigunting_app/src/infrastructure/services/local_storage/local_storage_repository.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/auth_repository.dart';
import 'package:srigunting_app/src/repository/balance_repopsitory.dart';
import 'package:srigunting_app/src/repository/guide_repository.dart';
import 'package:srigunting_app/src/repository/information_repository.dart';
import 'package:srigunting_app/src/repository/pagination.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';
import 'package:srigunting_app/src/repository/reward_repository.dart';
import 'package:srigunting_app/src/repository/notification_repository.dart';
part 'home_event.dart';
part 'home_state.dart';
class HomeBloc extends ABlocManagement<HomeEvent, HomeState> {
  final GuideRepository _guideRepository;
  final BalanceRepopsitory _balanceRepopsitory;
  final RewardRepository _rewardRepository;
  final InformationRepository _informationRepository;
  final LocalStorageRepository _localStorageRepository;
  final NotificationRepository _notificationRepository;
  final AuthRepository _authRepository;
  HomeBloc(
      this._guideRepository,
      this._balanceRepopsitory,
      this._rewardRepository,
      this._informationRepository,
      this._localStorageRepository,
      this._notificationRepository,
      this._authRepository)
      : super(HomeInitial()) {
    on<HomeInitialExecute>((event, emit) async {
      try {
        emit(HomeInitialLoading());
        var dataState = HomeInitialLoaded(
          dataGuide: null,
          databalance: null,
          dataPointReward: null,
          paginationInformation: null,
          hasUnreadNotification: null,
        );
        List<Future> apiCalls = [
          _guideRepository.detailAccountSrigunting(),
          _balanceRepopsitory.showBalance(),
          _rewardRepository.showPointReward(),
          _informationRepository
              .fetchInformation(PaginationRequest(page: 1, perPage: 10)),
          _notificationRepository
              .fetchNotification(PaginationRequest(page: 1, perPage: 10)),
        ];
        if (event.deviceToken != null && event.platform != null) {
          apiCalls.add(_authRepository.updateDeviceToken(
            deviceToken: event.deviceToken!,
            platform: event.platform!,
          ));
        }
        var res = await Future.wait(apiCalls);
        await responseHandler<Guide>(res[0], onSuccess: (response) {
          dataState = dataState.copyWith(dataGuide: response);
          _localStorageRepository.write(
              LocalStorageKey.GUIDE_CODE, response?.guideCode ?? '');
        }, onError: (dioError, code, errorMessage) {
          emit(HomeInitialError(error: errorMessage));
        });
        await responseHandler<Balance>(res[1], onSuccess: (response) {
          dataState = dataState.copyWith(databalance: response);
        }, onError: (dioError, code, errorMessage) {
          emit(HomeInitialError(error: errorMessage));
        });
        await responseHandler<Balance>(res[2], onSuccess: (response) {
          dataState = dataState.copyWith(dataPointReward: response);
        }, onError: (dioError, code, errorMessage) {
          emit(HomeInitialError(error: errorMessage));
        });
        await responseHandler<Pagination<Information>>(res[3],
            onSuccess: (response) {
          dataState =
              dataState.copyWith(paginationInformation: response);
        }, onError: (dioError, code, errorMessage) {
          dataState = dataState.copyWith(paginationInformation: null);
        });
        await responseHandler<Pagination<NotificationApp>>(res[4],
            onSuccess: (response) {
          final hasUnread =
              (response?.data ?? []).any((notif) => notif.isRead == false);
          dataState = dataState.copyWith(hasUnreadNotification: hasUnread);
        }, onError: (dioError, code, errorMessage) {
          dataState = dataState.copyWith(hasUnreadNotification: false);
        });
        if (event.deviceToken != null && event.platform != null) {
          await responseHandler(res[5], onSuccess: (response) {
            if (kDebugMode) {
              print('Device token updated successfully');
            }
          }, onError: (dioError, code, errorMessage) {
            if (kDebugMode) {
              print('Device token update failed: $errorMessage');
            }
          });
        }
        emit(dataState);
      } catch (e) {
        emit(HomeInitialError(error: e.toString()));
      }
    });
  }
}