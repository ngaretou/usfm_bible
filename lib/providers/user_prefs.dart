// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:usfm_bible/models/database_builder.dart';
import 'dart:core';
// import 'dart:async';
import 'dart:convert';

class BibleReference {
  final Key key;
  // final int columnIndex;
  final bool partOfScrollGroup;
  final String collectionID;
  String? bookID;
  String? chapter;
  String? verse;

  BibleReference({
    required this.key,
    // required this.columnIndex,
    required this.partOfScrollGroup,
    required this.collectionID,
    this.bookID,
    this.chapter,
    this.verse,
  });
}

class UserPrefList {
  List<BibleReference>? userColumns;

  UserPrefList({
    this.userColumns,
  });
}

class UserPrefs with ChangeNotifier {
  late UserPrefList _userPrefList;

  UserPrefList get userPrefList {
    return _userPrefList;
  }

  List<BibleReference> userColumns = [];

  Future<void> loadUserPrefs(AppInfo appInfo) async {
    bool hasPrefs = false;
    //TODO Check if the user has an existing session.

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
    switch (appInfo.collections.length) {
      case 1:
        numberOfColumns = 2; //if one collection, open two views
        break;
      case 2:
        numberOfColumns = 2;
        break;
      case 3:
        numberOfColumns = 3;
        break;
      case 4:
        numberOfColumns = 4;
        break;

      default:
        2;
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
              verse: null));
    }
    // End of default initialization
    _userPrefList = UserPrefList(userColumns: userColumns);
  }

  void addColumn() {
    print('adding a column in ColumnManager');
    //new default column
    userColumns.add(BibleReference(
        key: UniqueKey(),
        // columnIndex: userColumns.length,
        partOfScrollGroup: true,
        collectionID: "C01",
        bookID: null,
        chapter: null,
        verse: null));
    notifyListeners();
  }

  deleteColumn(Key keyToDelete) {
    print('deleting column index $keyToDelete');
    //This removes the desired element
    userColumns.removeWhere((element) => element.key == keyToDelete);
    //This reorders the list, refreshing the indices
    // userColumns = userColumns.toList();
    print('deleteColumn in userprefs');
    for (var item in userColumns) {
      print(item.collectionID);
    }
    notifyListeners();
    print('here');
  }

  void openSearchColumn() {}
}
