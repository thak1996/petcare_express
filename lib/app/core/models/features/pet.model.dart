import 'package:flutter/material.dart';

class PetModel {
  final String id;
  final String name;
  final String imageUrl;
  final Color borderColor;
  final bool hasWarning;

  PetModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.borderColor,
    this.hasWarning = false,
  });
}
