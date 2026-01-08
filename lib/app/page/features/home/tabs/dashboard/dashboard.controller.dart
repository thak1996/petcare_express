import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import '../../../../../core/models/auth/user.model.dart';
import '../../../../../core/models/features/notification.model.dart';
import '../../../../../core/models/features/pet.model.dart';
import '../../../../../core/repository/auth.repository.dart';
import '../../../../../core/repository/notification.repository.dart';
import '../../../../../core/repository/pet.repository.dart';
import 'dashboard.state.dart';

class DashBoardTabController extends Cubit<DashBoardTabState> {
  DashBoardTabController(
    this._authRepository,
    this._petRepository,
    this._notificationRepo,
  ) : super(DashBoardTabInitial());

  final IAuthRepository _authRepository;
  final IPetRepository _petRepository;
  final INotificationRepository _notificationRepo;

  Future<void> loadData() async {
    if (isClosed) return;
    if (state is! DashBoardTabSuccess) emit(DashBoardTabLoading());
    final userResult = await _authRepository.getCurrentUser();
    if (userResult.isError()) {
      emit(DashBoardTabError(userResult.exceptionOrNull().toString()));
      return;
    }
    final user = userResult.getOrDefault(UserModel.empty());
    final userId = user.id;
    final [notificationResult, petsResult] = await Future.wait([
      _notificationRepo.getNotifications(userId.toString()),
      _petRepository.getPetsForUser(userId.toString()),
    ]);
    if (isClosed) return;
    if (notificationResult.isError() || petsResult.isError()) {
      final errorMsg =
          notificationResult.exceptionOrNull()?.toString() ??
          petsResult.exceptionOrNull()?.toString() ??
          "Erro ao carregar dados";
      emit(DashBoardTabError(errorMsg));
      return;
    }
    emit(
      DashBoardTabSuccess(
        userName: user.name ?? 'Usuário',
        pets: petsResult.getOrDefault(<PetModel>[]).cast<PetModel>(),
        notifications: notificationResult
            .getOrDefault(<NotificationModel>[])
            .cast<NotificationModel>(),
      ),
    );
  }

  Future<void> dismissNotification(NotificationModel notification) async {
    if (isClosed) return;
    log("Dismiss notification resulting in ID: ${notification.id}");
    final result = await _notificationRepo.dismissNotification(notification.id);
    if (result.isError()) {
      emit(DashBoardTabError(result.exceptionOrNull().toString()));
      return;
    }
    loadData();
  }
}
