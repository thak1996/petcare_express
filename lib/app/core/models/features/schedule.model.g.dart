// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleModelAdapter extends TypeAdapter<ScheduleModel> {
  @override
  final int typeId = 1;

  @override
  ScheduleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleModel(
      id: fields[0] as String,
      title: fields[1] as String,
      time: fields[2] as String,
      subtitle: fields[3] as String,
      type: fields[4] as TaskType,
      petId: fields[6] as String,
      petName: fields[7] as String,
      date: fields[9] as DateTime,
      petImage: fields[8] as String?,
      isDone: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.subtitle)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.isDone)
      ..writeByte(6)
      ..write(obj.petId)
      ..writeByte(7)
      ..write(obj.petName)
      ..writeByte(8)
      ..write(obj.petImage)
      ..writeByte(9)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TaskTypeAdapter extends TypeAdapter<TaskType> {
  @override
  final int typeId = 2;

  @override
  TaskType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskType.health;
      case 1:
        return TaskType.food;
      case 2:
        return TaskType.activity;
      default:
        return TaskType.health;
    }
  }

  @override
  void write(BinaryWriter writer, TaskType obj) {
    switch (obj) {
      case TaskType.health:
        writer.writeByte(0);
        break;
      case TaskType.food:
        writer.writeByte(1);
        break;
      case TaskType.activity:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
