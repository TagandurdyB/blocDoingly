// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListModelAdapter extends TypeAdapter<ListModel> {
  @override
  final int typeId = 0;

  @override
  ListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListModel(
      name: fields[0] as String,
      uuid: fields[1] as String,
      isConnect: fields[4] as bool,
      isEdit: fields[5] as bool,
      taskCount: fields[2] as int,
      completed: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ListModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.uuid)
      ..writeByte(2)
      ..write(obj.taskCount)
      ..writeByte(3)
      ..write(obj.completed)
      ..writeByte(4)
      ..write(obj.isConnect)
      ..writeByte(5)
      ..write(obj.isEdit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
