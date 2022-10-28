// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_lines_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParsedLineDBAdapter extends TypeAdapter<ParsedLineDB> {
  @override
  final int typeId = 2;

  @override
  ParsedLineDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParsedLineDB()
      ..collectionid = fields[0] as String
      ..book = fields[1] as String
      ..chapter = fields[2] as String
      ..verse = fields[3] as String
      ..verseFragment = fields[4] as String
      ..audioMarker = fields[5] as String
      ..verseText = fields[6] as String
      ..verseStyle = fields[7] as String;
  }

  @override
  void write(BinaryWriter writer, ParsedLineDB obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.collectionid)
      ..writeByte(1)
      ..write(obj.book)
      ..writeByte(2)
      ..write(obj.chapter)
      ..writeByte(3)
      ..write(obj.verse)
      ..writeByte(4)
      ..write(obj.verseFragment)
      ..writeByte(5)
      ..write(obj.audioMarker)
      ..writeByte(6)
      ..write(obj.verseText)
      ..writeByte(7)
      ..write(obj.verseStyle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParsedLineDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
