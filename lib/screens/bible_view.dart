// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:provider/provider.dart';
import 'package:usfm_bible/providers/user_prefs.dart';

import '../models/database_builder.dart';
import '../widgets/scripture_column.dart';
import '../providers/user_prefs.dart';

class BibleView extends StatefulWidget {
  final AppInfo appInfo;

  const BibleView({
    Key? key,
    required this.appInfo,
  }) : super(key: key);

  @override
  State<BibleView> createState() => _BibleViewState();
}

class _BibleViewState extends State<BibleView> {
  late List<BibleReference> columnInfo;
  // int numberOfColumns = 2;
  int currentIndex = 0;
  List<Widget> scriptureColumns = [];

  // @override
  // void initState() {

  //   super.initState();
  // }

  // @override
  // void didChangeDependencies() {
  // //Getting current usercolumns
  // List<BibleReference>? userColumns =
  //     Provider.of<UserPrefs>(context, listen: true).userPrefList.userColumns;

  // scriptureColumns = List.generate(
  //     userColumns!.length,
  //     (index) => ScriptureColumn(
  //         myColumnIndex: index,
  //         numberOfColumns: userColumns.length,
  //         appInfo: widget.appInfo,
  //         bibleReference: userColumns[index]));
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    //Getting current usercolumns
    List<BibleReference>? userColumns =
        Provider.of<UserPrefs>(context, listen: true).userColumns;

    print('userColumns in Bible View');
    for (var item in userColumns) {
      print(item.collectionID);
    }

    scriptureColumns = List.generate(
      userColumns.length,
      (index) => ScriptureColumn(
        key: UniqueKey(),
        myColumnIndex: index,
        numberOfColumns: userColumns.length,
        appInfo: widget.appInfo,
        bibleReference: userColumns[index],
      ),
    );

    print('bibleview build');

    return Row(
      children: scriptureColumns,
    );

    // return FutureBuilder(
    //     future: columnInit,
    //     builder: (ctx, snapshot) =>
    //         snapshot.connectionState == ConnectionState.waiting
    //             ? const Center(child: ProgressRing())
    //             : Row(children: scriptureColumns));
  }
}
