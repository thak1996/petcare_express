import 'package:result_dart/result_dart.dart';
import '../models/features/notification.model.dart';

abstract class INotificationRepository {
  AsyncResult<List<NotificationModel>> getNotifications(String userId);
  AsyncResult<Unit> dismissNotification(String notificationId);
}

class NotificationRepositoryImpl implements INotificationRepository {
  @override
  AsyncResult<List<NotificationModel>> getNotifications(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Success([
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
    ]);
  }

  @override
  AsyncResult<Unit> dismissNotification(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Success(unit);
  }
}
