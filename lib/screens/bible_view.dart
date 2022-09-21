// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:usfm_bible/providers/user_prefs.dart';

import '../models/database_builder.dart';
import '../widgets/scripture_column.dart';
import '../providers/column_manager.dart';
import '../widgets/search.dart';

class BibleView extends StatefulWidget {
  final AppInfo appInfo;
  final String? comboBoxFont;

  const BibleView({Key? key, required this.appInfo, this.comboBoxFont})
      : super(key: key);

  @override
  State<BibleView> createState() => _BibleViewState();
}

class _BibleViewState extends State<BibleView> {
  late List<BibleReference> columnInfo;
  late int numberOfColumns;
  int currentIndex = 0;
  List<Widget> scriptureColumns = [];
  List<Widget> columnsToShow = [];
  List<BibleReference> userColumns = [];
  Widget? search;

  @override
  void initState() {
    userColumns = Provider.of<UserPrefs>(context, listen: false).userColumns;

    numberOfColumns = userColumns.length;

    /*
    Here and elsewhere, creating the ScriptureColumn we're doing something odd. 
    Normally the data flows into a stateless widget list that gets recreated with data updates. 
    https://stackoverflow.com/questions/66314111/how-to-remove-an-element-from-list-of-widgets-in-flutter
    Here the data takes a while to rebuild as you're cycling through a whole Bible each time. 
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
        comboBoxFont: widget.comboBoxFont,
      );
    });

    columnsToShow = scriptureColumns;
    super.initState();
  }

  void deleteColumn(Key keyToDelete) {
    print('deleting column index $keyToDelete in BibleView');
    //This removes the desired element from the record in memory
    userColumns.removeWhere((element) => element.key == keyToDelete);
    //and the widget
    scriptureColumns.removeWhere((element) => element.key == keyToDelete);
    Provider.of<ColumnManager>(context, listen: false)
        .deleteColumnRebuildCall();
    setState(() {});
  }

  void addColumn() {
    //limit to four columns
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
      int position = search == null
          ? scriptureColumns.length
          : scriptureColumns.length - 1;
      scriptureColumns.insert(
        position,
        ScriptureColumn(
          key: key,
          myColumnIndex: scriptureColumns.length,
          appInfo: widget.appInfo,
          bibleReference: newDefaultRef,
          deleteColumn: deleteColumn,
          comboBoxFont: widget.comboBoxFont,
        ),
      );

      setState(() {});
    } else {
      //may in the future add user feedback when trying to create too many columns
    }
  }

  void openSearch() {
    setState(() {
      search = SearchWidget(
          closeSearch: closeSearch, comboBoxFont: widget.comboBoxFont);
      columnsToShow.add(search!);
    });
  }

  void closeSearch() {
    search = null;
    columnsToShow.removeLast();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('bibleview build');

    //Listen around the corner from the main.dart NavPaneButtons

    if (Provider.of<ColumnManager>(context, listen: true).readyToAddColumn) {
      print('AddColumn notified');
      addColumn();
    }

    if (Provider.of<ColumnManager>(context, listen: true).readyToOpenSearch) {
      print('OpenSearch notified');
      if (search == null) {
        openSearch();
      }
    }

    return Container(
      //Bible view pane overall padding - each column has 5 above and then 2.5 l and r,
      //which when beside each other makes 5 between each col.
      //This padding here makes the first and last column have the full 5.
      padding: EdgeInsets.symmetric(horizontal: 2.5),
      color: FluentTheme.of(context).scaffoldBackgroundColor,
      child: Row(children: scriptureColumns),
    );
  }
}
