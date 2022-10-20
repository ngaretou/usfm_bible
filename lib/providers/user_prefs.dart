// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:usfm_bible/logic/database_builder.dart';
import 'dart:core';

class BibleReference {
  Key key;
  final bool partOfScrollGroup;
  final String collectionID;
  String? bookID;
  String? chapter;
  String? verse;

  BibleReference({
    required this.key,
    required this.partOfScrollGroup,
    required this.collectionID,
    this.bookID,
    this.chapter,
    this.verse,
  });
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

  List<BibleReference> userColumns = [];

  Future<void> loadUserPrefs(AppInfo appInfo) async {
    bool hasPrefs = false;
    //May in the future Check if the user has an existing session.

    //If not, set up the initial session.
    if (!hasPrefs) {
      initializePrefs(appInfo);
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
    } else if (appInfo.collections.length == 3) {
      numberOfColumns = 2;
    } else if (appInfo.collections.length > 3) {
      numberOfColumns = 4;
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
              verse: null));
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
            verse: null),
      );
    }
    // End of default initialization
    _userPrefList = UserPrefList(userColumns: userColumns);
  }
}
