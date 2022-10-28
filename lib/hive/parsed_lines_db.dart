import 'package:hive/hive.dart';

part 'parsed_lines_db.g.dart';

@HiveType(typeId: 2)
class ParsedLineDB {
  @HiveField(0)
  late String collectionid;
  @HiveField(1)
  late String book;
  @HiveField(2)
  late String chapter;
  @HiveField(3)
  late String verse;
  @HiveField(4)
  late String verseFragment;
  @HiveField(5)
  late String audioMarker;
  @HiveField(6)
  late String verseText;
  @HiveField(7)
  late String verseStyle;
}
