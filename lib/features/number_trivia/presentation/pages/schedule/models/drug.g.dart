// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DrugAdapter extends TypeAdapter<Drug> {
  @override
  final int typeId = 5;

  @override
  Drug read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Drug()
      ..drugName = fields[0] as String?
      ..drugDate = fields[1] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, Drug obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.drugName)
      ..writeByte(1)
      ..write(obj.drugDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrugAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
