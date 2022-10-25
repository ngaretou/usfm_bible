import 'package:hive/hive.dart';

part 'user_columns_db.g.dart';

@HiveType(typeId: 1)
class UserColumnsDB {
  @HiveField(0)
  late String key;

  @HiveField(1)
  late bool partOfScrollGroup;

  @HiveField(2)
  late String collectionID;

  @HiveField(3)
  String? bookID;

  @HiveField(4)
  String? chapter;

  @HiveField(5)
  String? verse;

  @HiveField(6)
  late int columnIndex;
}
