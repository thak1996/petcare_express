import 'package:flutter/material.dart';

enum NotificationType { warning, promo, info }

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final NotificationType type;
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
