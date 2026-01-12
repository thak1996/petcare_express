import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'schedule.model.g.dart';

@HiveType(typeId: 2)
enum TaskType {
  @HiveField(0)
  health,
  @HiveField(1)
  food,
  @HiveField(2)
  activity,
}

@HiveType(typeId: 1)
class ScheduleModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String time;
  @HiveField(3)
  final String subtitle;
  @HiveField(4)
  final TaskType type;
  @HiveField(5)
  final bool isDone;
  @HiveField(6)
  final String petId;
  @HiveField(7)
  final String petName;
  @HiveField(8)
  final String? petImage;
  @HiveField(9)
  final DateTime date;

  ScheduleModel({
    required this.id,
    required this.title,
    required this.time,
    required this.subtitle,
    required this.type,
    required this.petId,
    required this.petName,
    required this.date,
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

  ScheduleModel copyWith({
    String? id,
    String? title,
    String? time,
    String? subtitle,
    TaskType? type,
    bool? isDone,
    String? petId,
    String? petName,
    String? petImage,
    DateTime? date,
  }) {
    return ScheduleModel(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      subtitle: subtitle ?? this.subtitle,
      type: type ?? this.type,
      isDone: isDone ?? this.isDone,
      petId: petId ?? this.petId,
      petName: petName ?? this.petName,
      petImage: petImage ?? this.petImage,
      date: date ?? this.date,
    );
  }
}
