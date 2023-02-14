// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BooksAdapter extends TypeAdapter<Books> {
  @override
  final int typeId = 1;

  @override
  Books read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Books(
      id: fields[0] as int?,
      author: fields[2] as String?,
      title: fields[1] as String?,
      quantity: fields[3] as int?,
      doc: fields[4] as String?,
      date: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Books obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.doc)
      ..writeByte(5)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BooksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
