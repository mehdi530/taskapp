// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class taskmodelAdapter extends TypeAdapter<task_model> {
  @override
  final int typeId = 1;

  @override
  task_model read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return task_model(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, task_model obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.task_text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is taskmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
