// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:provider/provider.dart';
import 'package:usfm_bible/providers/user_prefs.dart';

import '../models/database_builder.dart';
import '../widgets/scripture_column.dart';
import '../providers/user_prefs.dart';
import '../providers/add_column.dart';

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
  late int numberOfColumns;
  int currentIndex = 0;
  List<Widget> scriptureColumns = [];
  List<BibleReference> userColumns = [];

  @override
  void initState() {
    userColumns = Provider.of<UserPrefs>(context, listen: false).userColumns;

    // for (var item in userColumns) {
    //   print(item.collectionID);
    // }

    numberOfColumns = userColumns.length;
    /*
    Here and elsewhere, creating the ScriptureColumn we're doing something odd. 
    Normally the data flows into a stateless widget list that gets recreated with data updates. 
    https://stackoverflow.com/questions/66314111/how-to-remove-an-element-from-list-of-widgets-in-flutter
    Here the data takes a while to rebuild as you're cycling through a while Bible each time. 
    So unusually we keep track of the column BibleReferences (for saving preferences and getting reference to number of columns etc)
    and the widgets. I'm not sure this is the right way to go but we have so much data processing with each ScriptureColumn rebuild 
    that it seems like the most likely to serve us here. 
    */
    scriptureColumns = List.generate(userColumns.length, (index) {
      Key key = UniqueKey();

      userColumns[index].key = key;

      return ScriptureColumn(
        key: key,
        myColumnIndex: index,
        appInfo: widget.appInfo,
        bibleReference: userColumns[index],
        deleteColumn: deleteColumn,
      );
    });
    super.initState();
  }

  void deleteColumn(Key keyToDelete) {
    print('deleting column index $keyToDelete in BibleView');
    //This removes the desired element from the record in memory
    userColumns.removeWhere((element) => element.key == keyToDelete);
    //and the widget
    scriptureColumns.removeWhere((element) => element.key == keyToDelete);

    setState(() {});
  }

  void addColumn() {
    print('adding a column in Bible View');
    if (userColumns.length <= 3) {
      //This common key helps us keep track of refs and columns
      Key key = UniqueKey();

      //new default bible reference
      BibleReference newDefaultRef = BibleReference(
          key: key,
          partOfScrollGroup: true,
          collectionID: "C01",
          bookID: null,
          chapter: null,
          verse: null);

      userColumns.add(newDefaultRef);
      //new default column
      scriptureColumns.add(
        ScriptureColumn(
            key: key,
            myColumnIndex: scriptureColumns.length,
            appInfo: widget.appInfo,
            bibleReference: newDefaultRef,
            deleteColumn: deleteColumn),
      );
      setState(() {});
    }

    //TODO add user feedback when trying to create too many columns
  }

  void openSearch() {
    print('opening search pane  ${DateTime.now().toLocal().toString()}');
  }

  @override
  Widget build(BuildContext context) {
    print('bibleview build');

    //Listen around the corner from the main.dart NavPaneButtons

    if (Provider.of<AddColumn>(context, listen: true).readyToAddColumn) {
      print('AddColumn notified');
      addColumn();
    }

    Provider.of<OpenSearch>(context, listen: true).addListener(() {
      openSearch();
    });

    return Container(
      color: FluentTheme.of(context).inactiveBackgroundColor,
      child: Row(
        children: scriptureColumns,
      ),
    );
  }
}
