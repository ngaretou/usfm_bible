// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:usfm_bible/logic/database_builder.dart';
import 'dart:core';
import 'package:hive_flutter/hive_flutter.dart';

import '../hive/user_columns_db.dart';
import '../main.dart' as main;

class BibleReference {
  Key key;
  bool partOfScrollGroup;
  String collectionID;
  String? bookID;
  String? chapter;
  String? verse;
  int columnIndex;

  BibleReference(
      {required this.key,
      required this.partOfScrollGroup,
      required this.collectionID,
      this.bookID,
      this.chapter,
      this.verse,
      required this.columnIndex});
}

class UserPrefList {
  List<BibleReference>? userColumns;
  String? userLang;

  UserPrefList({this.userColumns, this.userLang});
}

class UserPrefs with ChangeNotifier {
  Box<UserColumnsDB> mybox = main.userColumnsBox;
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

 
  loadUserPrefs(AppInfo appInfo) async {
    // printWhatsInList();
    //Check if the user has an existing session. If not, set up the initial session.
    if (main.userColumnsBox.isEmpty) {
      initializePrefs(appInfo);
    } else {
      try {
        // print('getting usercolumns from local db');
        // printWhatsInBox();
        for (var i = 0; i < main.userColumnsBox.length; i++) {
          Key newKeyForSession = UniqueKey();

          BibleReference ref = BibleReference(
              // key: UniqueKey(), //Here is where the unique key comes from after reloading.
              // ScriptureColumns (List<Widget>) HAS to have a key so we can locate it later.
              // The old key stored in the db is as String, but no way to convert String back to Key.
              //For that reason fdtrtffgrdesfredswredsawe make a new key for this session above, then save it as we populate our in-memory copy of usercolumns
              //And we also delete the old copy of the column info in the db and replace it with a new one
              key: newKeyForSession,
              partOfScrollGroup:
                  main.userColumnsBox.getAt(i)!.partOfScrollGroup,
              collectionID: main.userColumnsBox.getAt(i)!.collectionID,
              bookID: main.userColumnsBox.getAt(i)!.bookID,
              chapter: main.userColumnsBox.getAt(i)!.chapter,
              verse: main.userColumnsBox.getAt(i)!.verse,
              columnIndex: main.userColumnsBox.getAt(i)!.columnIndex);
          userColumns.add(ref);
        }
        //clear the box
        await main.userColumnsBox.clear();
        // repopulate with the new values - really just the key is new
        //but with the String/key problem have to do the whole thing
        for (var i = 0; i < userColumns.length; i++) {
          saveScrollGroupState(userColumns[i]);
        }

        //Get them in the right order
        userColumns.sort(((a, b) => a.columnIndex.compareTo(b.columnIndex)));
        //Now potentially you have some columnIndexes out of order which will probably not hurt the program but just for my peace of mind let's reset the column indexes
        for (var i = 0; i < userColumns.length; i++) {
          userColumns[i].columnIndex = i;
        }

        _userPrefList = UserPrefList(userColumns: userColumns);
      } catch (e) {
        // safety valve in case seomething goes wrong - reset db and start over
        print('Error in loading user prefs, reinitializing columns...');
        main.userColumnsBox.clear();
        initializePrefs(appInfo);
      }
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
            partOfScrollGroup: partOfScrollGroup,
            collectionID: "C0${(index + 1).toString()}",
            bookID: null,
            chapter: null,
            verse: null,
            columnIndex: index),
      );
    }

    _userPrefList = UserPrefList(userColumns: userColumns);
    // End of default initialization

    //Now save the initial values to the user columns db
    // var box = await Hive.openBox<UserColumnsDB>('userColumnsDB');

    for (var i = 0; i < userColumns.length; i++) {
      UserColumnsDB colDB = UserColumnsDB()
        ..key = userColumns[i].key.toString()
        ..partOfScrollGroup = userColumns[i].partOfScrollGroup
        ..collectionID = userColumns[i].collectionID
        ..bookID = userColumns[i].bookID
        ..chapter = userColumns[i].chapter
        ..verse = userColumns[i].verse
        ..columnIndex = i;

      main.userColumnsBox.put(userColumns[i].key.toString(), colDB);
    }
  }

  void saveScrollGroupState(BibleReference ref) {
    // printWhatsInBox();
    UserColumnsDB colDB = UserColumnsDB()
      ..key = ref.key.toString()
      ..partOfScrollGroup = ref.partOfScrollGroup
      ..collectionID = ref.collectionID
      ..bookID = ref.bookID
      ..chapter = ref.chapter
      ..verse = ref.verse
      ..columnIndex = ref.columnIndex;

    //We found the key, now replace the record at that spot or add it if it's new
    main.userColumnsBox.put(ref.key.toString(), colDB);
    // printWhatsInBox();
  }

  deleteColumnFromBox(String keyAsString) {
    // Box<UserColumnsDB> box = await Hive.openBox<UserColumnsDB>('userColumnsDB');
    // printWhatsInBox();
    main.userColumnsBox.delete(keyAsString);
    // printWhatsInBox();
  }
}
