import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import '../models/features/pet.model.dart';

abstract class IPetRepository {
  AsyncResult<List<PetModel>> getPetsForUser(String userId);
  AsyncResult<Unit> addPetForUser(String userId, PetModel pet);
  AsyncResult<Unit> removePetForUser(String userId, String petId);
}

class PetRepositoryImpl implements IPetRepository {
  @override
  AsyncResult<List<PetModel>> getPetsForUser(String userId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      final mockPets = [
        PetModel(
          name: "Rex",
          imageUrl: "https://placedog.net/200",
          borderColor: Colors.teal,
          hasWarning: true,
        ),
        PetModel(
          name: "Luna",
          imageUrl: "https://placedog.net/201",
          borderColor: Colors.orange,
          hasWarning: true,
        ),
        PetModel(
          name: "Thor",
          imageUrl: "https://placedog.net/202",
          borderColor: Colors.purple,
          hasWarning: false,
        ),
      ];

      return Success(mockPets);
    } catch (e) {
      return Failure(Exception("Erro ao buscar pets"));
    }
  }

  @override
  AsyncResult<Unit> addPetForUser(String userId, PetModel pet) async {
    await Future.delayed(const Duration(seconds: 1));
    return Success(unit);
  }

  @override
  AsyncResult<Unit> removePetForUser(String userId, String petId) async {
    await Future.delayed(const Duration(seconds: 1));
    return Success(unit);
  }
}
