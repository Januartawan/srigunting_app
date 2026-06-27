import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:srigunting_app/src/domain/free_visit.dart';
import 'package:srigunting_app/src/domain/notification.dart';
import 'package:srigunting_app/src/domain/pagination.dart';
import 'package:srigunting_app/src/domain/transaction.dart';
import 'package:srigunting_app/src/infrastructure/state_management/bloc/bloc_state.dart';
import 'package:srigunting_app/src/infrastructure/state_management/event.dart';
import 'package:srigunting_app/src/infrastructure/state_management/state.dart';
import 'package:srigunting_app/src/repository/notification_repository.dart';
import 'package:srigunting_app/src/repository/pagination.dart';
import 'package:srigunting_app/src/repository/rest/tool/network_func.dart';
part 'notification_event.dart';
part 'notification_state.dart';
class NotificationBloc
    extends ABlocManagement<NotificationEvent, NotificationState> {
  final NotificationRepository _notificationRepository;
  NotificationBloc(this._notificationRepository)
      : super(NotificationInitial()) {
    on<NotificationInitialEvent>((event, emit) async {
      try {
        emit(NotificationInitialLoading());
        var res = await _notificationRepository.fetchNotification(PaginationRequest(page: 1, perPage: 10));
        responseHandler<Pagination<NotificationApp>>(res,
            onSuccess: (response) {
          emit(NotificationInitialLoaded(
            dataNotification: response?.data ?? [],
            pagination: response,
          ));
        }, onError: (dioError, code, errorMessage) {
          emit(NotificationInitialError(error: errorMessage));
        });
      } catch (e) {
        emit(NotificationInitialError(error: e.toString()));
      }
    });
    on<NotificationLoadMoreEvent>((event, emit) async {
      try {
        emit(NotificationLoadMoreLoading(
          dataNotification: const [],
          pagination: null,
        ));
        var res = await _notificationRepository.fetchNotification(
            PaginationRequest(page: event.page, perPage: 10));
        responseHandler<Pagination<NotificationApp>>(res,
            onSuccess: (response) {
          emit(NotificationLoadMoreLoaded(
            dataNotification: response?.data ?? [],
            pagination: response,
          ));
        }, onError: (dioError, code, errorMessage) {
          emit(NotificationLoadMoreError(
            error: errorMessage,
            dataNotification: const [],
            pagination: null,
          ));
        });
      } catch (e) {
        emit(NotificationLoadMoreError(
          error: e.toString(),
          dataNotification: const [],
          pagination: null,
        ));
      }
    });
    on<NotificationShowDetailEvent>((event, emit) async {
      try {
        emit(NotificationShowDetailLoading());
        var res = await _notificationRepository.showNotification(event.slug);
        responseHandler<NotificationApp>(res, onSuccess: (response) {
          emit(NotificationShowDetailLoaded(notification: response!));
        }, onError: (dioError, code, errorMessage) {
          emit(NotificationShowDetailError(error: errorMessage));
        });
      } catch (e) {
        emit(NotificationShowDetailError(error: e.toString()));
      }
    });
    on<NotificationShowDetailTransactionEvent>((event, emit) async {
      try {
        emit(NotificationShowTransactionDetailLoading());
        var res = await _notificationRepository.showNotificationTransaction(event.slug);
        responseHandler<Transaction>(res, onSuccess: (response) {
          emit(NotificationShowTransactionDetailLoaded(
              notifTransaction: response!));
        }, onError: (dioError, code, errorMessage) {
          emit(NotificationShowTransactionDetailError(error: errorMessage));
        });
      } catch (e) {
        emit(NotificationShowTransactionDetailError(error: e.toString()));
      }
    });
    on<NotificationShowDetailFreeVisitEvent>((event, emit) async {
      try {
        emit(NotificationShowFreeVisitDetailLoading());
        var res = await _notificationRepository.showNotificationFreeVisit(event.slug);
        responseHandler<FreeVisit>(res, onSuccess: (response) {
          emit(
              NotificationShowFreeVisitDetailLoaded(notifFreeVisit: response!));
        }, onError: (dioError, code, errorMessage) {
          emit(NotificationShowFreeVisitDetailError(error: errorMessage));
        });
      } catch (e) {
        emit(NotificationShowFreeVisitDetailError(error: e.toString()));
      }
    });
  }
}