import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'pet.model.g.dart';

@HiveType(typeId: 0)
class PetModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final int colorValue;

  @HiveField(4)
  final bool hasWarning;

  PetModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.colorValue,
    this.hasWarning = false,
  });

  Color get borderColor => Color(colorValue);
}
