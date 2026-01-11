import 'dart:async';

import 'package:result_dart/result_dart.dart';
import '../models/features/notification.model.dart';

abstract class INotificationRepository {
  AsyncResult<List<NotificationModel>> getNotifications(String userId);

  AsyncResult<Unit> dismissNotification(String notificationId);

  Stream<String> get onNotificationDismissed;
}

class NotificationRepositoryImpl implements INotificationRepository {
  final _dismissController = StreamController<String>.broadcast();
  
  final List<NotificationModel> _mockNotifications = [
    NotificationModel(
      id: "1",
      title: "Vacina Vencendo",
      body: "A vacina de raiva do Rex vence amanhã!",
      type: NotificationType.warning,
    ),
    NotificationModel(
      id: "2",
      title: "Promoção Relâmpago",
      body: "15% de desconto em banho e tosa hoje.",
      type: NotificationType.promo,
    ),
    NotificationModel(
      id: "3",
      title: "Bem-vindo",
      body: "Complete o perfil do seu pet.",
      type: NotificationType.info,
    ),
  ];

  @override
  AsyncResult<Unit> dismissNotification(String notificationId) async {
    _mockNotifications.removeWhere((n) => n.id == notificationId);
    _dismissController.add(notificationId);
    return Success(unit);
  }

  @override
  AsyncResult<List<NotificationModel>> getNotifications(String userId) async {
    return Success(_mockNotifications);
  }

  @override
  Stream<String> get onNotificationDismissed => _dismissController.stream;
}
