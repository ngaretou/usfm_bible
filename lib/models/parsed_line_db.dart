import 'package:isar/isar.dart';
// import 'collections.dart';

part 'parsed_line_db.g.dart';

@Collection()
class ParsedLineDB {
  Id isarId = Isar.autoIncrement;
  late String collectionid;
  late String book;
  late String chapter;
  late String verse;
  late String verseFragment;
  late String audioMarker;
  late String verseText;
  late String verseStyle;
}
