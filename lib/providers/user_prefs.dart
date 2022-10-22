// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:usfm_bible/models/database_builder.dart';
import 'dart:core';
import 'package:hive_flutter/hive_flutter.dart';

import '../hive/user_columns_db.dart';

class BibleReference {
  Key key;
  final bool partOfScrollGroup;
  final String collectionID;
  String? bookID;
  String? chapter;
  String? verse;
  int? columnIndex;

  BibleReference(
      {required this.key,
      required this.partOfScrollGroup,
      required this.collectionID,
      this.bookID,
      this.chapter,
      this.verse,
      this.columnIndex});
}

class UserPrefList {
  List<BibleReference>? userColumns;
  String? userLang;

  UserPrefList({this.userColumns, this.userLang});
}

class UserPrefs with ChangeNotifier {
  late UserPrefList _userPrefList;

  UserPrefList get userPrefList {
    return _userPrefList;
  }

  List<BibleReference> userColumns = [];

  String? userLang;

  Translation get currentTranslation {
    return translations
        .where((element) => element.langCode == currentLang)
        .first;
  }

  String? get currentLang => userLang;

  set setUserLang(String lang) {
    userLang = lang;
    notifyListeners();
  }

  Future<void> loadUserPrefs(AppInfo appInfo) async {
    var box = await Hive.openBox<UserColumnsDB>('userColumnsDB');
    //Check if the user has an existing session.

    //If not, set up the initial session.
    if (box.isEmpty) {
      initializePrefs(appInfo);
    } else {
      print('getting usercolumns from local db');

      for (var i = 0; i < box.length; i++) {
        BibleReference ref = BibleReference(
            // key: UniqueKey(), //Here is where the unique key comes from after reloading
            key: box.getAt(i)!.key,
            partOfScrollGroup: box.getAt(i)!.partOfScrollGroup,
            collectionID: box.getAt(i)!.collectionID,
            bookID: box.getAt(i)!.bookID,
            chapter: box.getAt(i)!.chapter,
            verse: box.getAt(i)!.verse,
            columnIndex: box.getAt(i)!.columnIndex);
        userColumns.add(ref);
      }

      userColumns.sort(((a, b) => a.columnIndex!.compareTo(a.columnIndex!)));

      _userPrefList = UserPrefList(userColumns: userColumns);
    }
  }

  // void saveUserPrefs() {}

  //If no prefs, set them up. This gets called from loadUserPrefs.
  Future<void> initializePrefs(AppInfo appInfo) async {
    late bool partOfScrollGroup;
    late String currentCollection;
    late int numberOfColumns;

    //How many columns should we initially open?
    if (appInfo.collections.length == 1) {
      numberOfColumns = 2;
    } else if (appInfo.collections.length == 2) {
      numberOfColumns = 2;
    } else if (appInfo.collections.length > 2) {
      numberOfColumns = 3;
    }

    //If just one collection, initially give the users two views but not tied to the same scrollgroup.
    if (appInfo.collections.length == 1) {
      partOfScrollGroup = false;
      currentCollection = "C01";
      userColumns = List.generate(
          2,
          (index) => BibleReference(
              key: UniqueKey(),
              // columnIndex: index,
              partOfScrollGroup: partOfScrollGroup,
              collectionID: currentCollection,
              bookID: null,
              chapter: null,
              verse: null,
              columnIndex: index));
    } else {
      //If it is more than one collection, each column initially will just take the next collection down.
      partOfScrollGroup = true;

      userColumns = List.generate(
        numberOfColumns,
        (index) => BibleReference(
            key: UniqueKey(),
            // columnIndex: index,
            partOfScrollGroup: partOfScrollGroup,
            collectionID: "C0${(index + 1).toString()}",
            bookID: null,
            chapter: null,
            verse: null,
            columnIndex: index),
      );
    }
    // End of default initialization
    _userPrefList = UserPrefList(userColumns: userColumns);

    for (var i = 0; i < userColumns.length; i++) {
      UserColumnsDB colDB = UserColumnsDB()
        ..key = userColumns[i].key
        ..partOfScrollGroup = userColumns[i].partOfScrollGroup
        ..collectionID = userColumns[i].collectionID
        ..bookID = userColumns[i].bookID
        ..chapter = userColumns[i].chapter
        ..verse = userColumns[i].verse
        ..columnIndex = i;
      var box = await Hive.openBox<UserColumnsDB>('userColumnsDB');
      box.put(userColumns[i].key, colDB);
      print('almost there');
    }
  }

  saveScrollGroupState(BibleReference ref) async {
    var box = await Hive.openBox<UserColumnsDB>('userColumnsDB');
    UserColumnsDB? refInQuestion = box.get(ref.key);
    print(ref.key.toString());
    for (var i = 0; i < box.length; i++) {
      print('${i.toString()} ${box.keyAt(i)}');
    }

    if (refInQuestion != null) {
      print('found the key for refInQuestion');
    } else {
      print('refInQuestion was null');
    }

    // refInQuestion!.partOfScrollGroup = ref.partOfScrollGroup;
    // refInQuestion.collectionID = ref.collectionID;
    // refInQuestion.bookID = ref.bookID;
    // refInQuestion.chapter = ref.chapter;
    // refInQuestion.verse = ref.verse;
    // refInQuestion.save();

    // print(colIndex);
    // print(ref.key.toString());
    // print(ref.partOfScrollGroup);
    // print(ref.collectionID);
    // print(ref.bookID);
    // print(ref.chapter);
    // print(ref.verse);
  }
}
