import 'package:isar/isar.dart';
import 'package:usfm_bible/models/parsed_line_db.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> addLine(ParsedLineDB line) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.parsedLineDBs.put(line); // insert & update
    });
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([ParsedLineDBSchema], inspector: true);
    }
    return Future.value(Isar.getInstance());
  }
}
