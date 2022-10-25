// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_columns_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserColumnsDBAdapter extends TypeAdapter<UserColumnsDB> {
  @override
  final int typeId = 1;

  @override
  UserColumnsDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserColumnsDB()
      ..key = fields[0] as String
      ..partOfScrollGroup = fields[1] as bool
      ..collectionID = fields[2] as String
      ..bookID = fields[3] as String?
      ..chapter = fields[4] as String?
      ..verse = fields[5] as String?
      ..columnIndex = fields[6] as int;
  }

  @override
  void write(BinaryWriter writer, UserColumnsDB obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.partOfScrollGroup)
      ..writeByte(2)
      ..write(obj.collectionID)
      ..writeByte(3)
      ..write(obj.bookID)
      ..writeByte(4)
      ..write(obj.chapter)
      ..writeByte(5)
      ..write(obj.verse)
      ..writeByte(6)
      ..write(obj.columnIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserColumnsDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
