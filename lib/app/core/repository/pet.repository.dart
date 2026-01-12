import 'package:hive_flutter/hive_flutter.dart';
import 'package:result_dart/result_dart.dart';
import '../database/hive_config.dart';
import '../models/features/pet.model.dart';

abstract class IPetRepository {
  AsyncResult<List<PetModel>> getPetsForUser(String userId);
  AsyncResult<Unit> addPetForUser(String userId, PetModel pet);
  AsyncResult<Unit> removePetForUser(String userId, String petId);
}

class PetRepositoryImpl implements IPetRepository {
  final Box<PetModel> _box = Hive.box<PetModel>(HiveConfig.petBoxName);

  @override
  AsyncResult<List<PetModel>> getPetsForUser(String userId) async {
    try {
      final pets = _box.values.toList();
      return Success(pets);
    } catch (e) {
      return Failure(Exception("Erro ao buscar pets: $e"));
    }
  }

  @override
  AsyncResult<Unit> addPetForUser(String userId, PetModel pet) async {
    try {
      await _box.put(pet.id, pet);
      return Success(unit);
    } catch (e) {
      return Failure(Exception("Erro ao adicionar pet: $e"));
    }
  }

  @override
  AsyncResult<Unit> removePetForUser(String userId, String petId) async {
    try {
      await _box.delete(petId);
      return Success(unit);
    } catch (e) {
      return Failure(Exception("Erro ao remover pet: $e"));
    }
  }
}
