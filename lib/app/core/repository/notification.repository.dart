import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:result_dart/result_dart.dart';
import '../database/hive_config.dart';
import '../models/features/notification.model.dart';

abstract class INotificationRepository {
  AsyncResult<List<NotificationModel>> getNotifications(String userId);
  AsyncResult<Unit> dismissNotification(String notificationId);
  Stream<String> get onNotificationDismissed;
}

class NotificationRepositoryImpl implements INotificationRepository {
  final Box<NotificationModel> _box = Hive.box<NotificationModel>(
    HiveConfig.notificationBoxName,
  );
  final _dismissController = StreamController<String>.broadcast();

  @override
  Stream<String> get onNotificationDismissed => _dismissController.stream;

  @override
  AsyncResult<List<NotificationModel>> getNotifications(String userId) async {
    try {
      return Success(_box.values.toList());
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  AsyncResult<Unit> dismissNotification(String notificationId) async {
    try {
      await _box.delete(notificationId);
      _dismissController.add(notificationId);
      return Success(unit);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }
}
