// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fluent_ui/fluent_ui.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../models/database_builder.dart';
import '../widgets/scripture_column.dart';

class BibleReference {
  final String collectionID;
  final String bookID;
  final String chapter;
  final String verse;

  BibleReference({
    required this.collectionID,
    required this.bookID,
    required this.chapter,
    required this.verse,
  });
}

class BibleView extends StatefulWidget {
  int numberOfColumns;
  final AppInfo appInfo;
  final Function(int) deleteColumn;

  BibleView(
      {Key? key,
      required this.numberOfColumns,
      required this.appInfo,
      required this.deleteColumn})
      : super(key: key);

  @override
  State<BibleView> createState() => _BibleViewState();
}

class _BibleViewState extends State<BibleView> {
  List<Widget> scriptureColumns = [];
  int currentIndex = 0;

  //We're limiting it to four panes and four scrollcontrollers.
  ItemScrollController scrollController1 = ItemScrollController();
  ItemScrollController scrollController2 = ItemScrollController();
  ItemScrollController scrollController3 = ItemScrollController();
  ItemScrollController scrollController4 = ItemScrollController();
  List<ItemScrollController> scrollControllers = [];

  @override
  void initState() {
    scrollControllers = [
      scrollController1,
      scrollController2,
      scrollController3,
      scrollController4,
    ];
    AppInfo appInfo = widget.appInfo;

    scriptureColumns = List.generate(
      widget.numberOfColumns,
      (index) {
        return Expanded(
          child: Center(
            child: ScriptureColumn(
                myColumnIndex: index,
                numberOfColumns: widget.numberOfColumns,
                appInfo: appInfo,
                scrollController: scrollControllers[index],
                deleteColumn: deleteColumnTry),
          ),
        );
      },
    );

    super.initState();
  }

  deleteColumnTry(int indexToDelete) {
    scriptureColumns.removeAt(indexToDelete);
    widget.numberOfColumns--;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('bibleview build');
    print('no. columns ${widget.numberOfColumns}');

    return Row(children: scriptureColumns);
  }
}
