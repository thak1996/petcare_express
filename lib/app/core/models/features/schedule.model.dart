import 'package:flutter/material.dart';

enum TaskType { health, food, activity }

class ScheduleModel {
  final String id;
  final String title;
  final String time;
  final String subtitle;
  final TaskType type;
  final bool isDone;
  final String petId;
  final String petName;
  final String? petImage;

  ScheduleModel({
    required this.id,
    required this.title,
    required this.time,
    required this.subtitle,
    required this.type,
    required this.petId,
    required this.petName,
    this.petImage,
    this.isDone = false,
  });

  Color get themeColor {
    switch (type) {
      case TaskType.health:
        return Colors.blue;
      case TaskType.food:
        return Colors.orange;
      case TaskType.activity:
        return Colors.purple;
    }
  }

  IconData get icon {
    switch (type) {
      case TaskType.health:
        return Icons.vaccines;
      case TaskType.food:
        return Icons.restaurant;
      case TaskType.activity:
        return Icons.pets;
    }
  }

  String get translation {
    switch (type) {
      case TaskType.health:
        return "Saúde";
      case TaskType.food:
        return "Alimentação";
      case TaskType.activity:
        return "Atividade";
    }
  }
}
