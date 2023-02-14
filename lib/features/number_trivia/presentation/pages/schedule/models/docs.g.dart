// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'docs.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DocsAdapter extends TypeAdapter<Docs> {
  @override
  final int typeId = 0;

  @override
  Docs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Docs(
      fields[0] as String,
      fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Docs obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
