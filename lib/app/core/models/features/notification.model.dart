import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'notification.model.g.dart';

@HiveType(typeId: 3)
enum NotificationType {
  @HiveField(0)
  warning,
  @HiveField(1)
  promo,
  @HiveField(2)
  info,
}

@HiveType(typeId: 4)
class NotificationModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String body;
  @HiveField(3)
  final NotificationType type;
  @HiveField(4)
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    this.isRead = false,
  });

  Color get color {
    switch (type) {
      case NotificationType.warning:
        return Colors.red;
      case NotificationType.promo:
        return Colors.green;
      case NotificationType.info:
        return Colors.blue;
    }
  }

  IconData get icon {
    switch (type) {
      case NotificationType.warning:
        return Icons.warning_amber_rounded;
      case NotificationType.promo:
        return Icons.local_offer_outlined;
      case NotificationType.info:
        return Icons.info_outline;
    }
  }
}
