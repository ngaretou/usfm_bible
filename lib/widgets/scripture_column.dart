// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fluent_ui/fluent_ui.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:provider/provider.dart';

import '../models/database_builder.dart';
import '../widgets/paragraph_builder.dart';
import '../screens/bible_view.dart';
import '../providers/user_prefs.dart';

class ScriptureColumn extends StatefulWidget {
  final int myColumnIndex;
  final int numberOfColumns;
  final AppInfo appInfo;
  final BibleReference bibleReference;

  const ScriptureColumn({
    Key? key,
    required this.myColumnIndex,
    required this.numberOfColumns,
    required this.appInfo,
    required this.bibleReference,
  }) : super(key: key);

  @override
  State<ScriptureColumn> createState() => _ScriptureColumnState();
}

class _ScriptureColumnState extends State<ScriptureColumn> {
  late ItemScrollController itemScrollController;
  bool wideWindow = false;
  late double wideWindowPadding = 0;
  bool partOfScrollGroup = true;

  List<ParsedLine> versesInColumn = []; //All verses in Collection
  List<ParsedLine> versesToDisplay =
      []; //the specific verses to display in a paragraph
  // late BibleReference bibleReference;
  List<String> collectionNames = [];
  late Collection currentCollectionInfo;
  String currentCollection = "";
  List<Book> currentCollectionBooks = [];
  String currentBook = "";
  List<String> currentBookChapters = [];
  String currentChapter = "";
  List<String> currentChapterVerseNumbers = [];
  String currentVerse = "";

  List<List<ParsedLine>> versesByParagraph = [];
  List<ParsedLine> currentParagraph = [];

  String? collectionComboBoxValue;
  String? bookComboBoxValue;
  String? chapterComboBoxValue;
  String? verseComboBoxValue;

  @override
  void initState() {
    itemScrollController = ItemScrollController();
    currentCollection = widget.bibleReference.collectionID;

    versesInColumn = widget.appInfo.verses
        .where((element) => element.collectionid == currentCollection)
        .toList();

    //Set initial ch/vs selectors

    //Books in current collection
    currentCollectionBooks = widget.appInfo.collections
        .where((element) => element.id == currentCollection)
        .toList()[0]
        .books;

    //on first open of the app, open the first book
    currentBook = currentCollectionBooks[0].id;

    //Now get chapters in current book

    currentBookChapters = versesInColumn
        .where((element) => element.book == currentBook)
        .map((e) => e.chapter)
        .toList();

    //.toSet().toList() here reduces a big list to uniques
    currentBookChapters = currentBookChapters.toSet().toList();

    //on first open of the app, open the first book
    currentChapter = currentBookChapters[0];

    currentChapterVerseNumbers = versesInColumn
        .where((element) =>
            element.book == currentBook &&
            element.chapter == currentChapter &&
            element.verse != "")
        .map((e) => e.verse)
        .toList();

    currentVerse = currentChapterVerseNumbers[0];
    /*
    */
    for (var i = 0; i < versesInColumn.length; i++) {
      //if not new paragraph marker, add the line to the current paragraph
      if (!versesInColumn[i].verseStyle.contains(RegExp(r'[p,m,s\d*]'))) {
        currentParagraph.add(versesInColumn[i]);
      } else {
        //If it is a new paragraph marker, add the existing verses to the big list, and start over with a new paragraph
        versesByParagraph.add(currentParagraph);
        currentParagraph = [versesInColumn[i]];
        // if (currentParagraph.isNotEmpty) {
        //   versesByParagraph.add(currentParagraph);
        //   currentParagraph = [];
        // }
      }
    }
    /*
    */
    super.initState();
  }

  goToVerse(String collection, String bookID, String chapter, String verse) {}

  @override
  Widget build(BuildContext context) {
    print('Scripture Column build');
    double windowWidth = MediaQuery.of(context).size.width;
    if (windowWidth > 500 && widget.numberOfColumns == 1) {
      wideWindow = true;
      wideWindowPadding = windowWidth / 5;
    }
    // var deleteColumn = Provider.of<UserPrefs>(context, listen: false)
    //     .deleteColumn(widget.myColumnIndex);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //header toolbar/s
        children: [
          //Scripture column toolbar
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              padding: EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Wrap(
                          //space betwen items
                          spacing: 5,
                          //space between rows when stacked
                          runSpacing: 8,
                          direction: Axis.horizontal,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.start,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Combobox<String>(
                                isExpanded: true,
                                items: widget.appInfo.collections
                                    .map((e) => ComboboxItem<String>(
                                          value: e.id,
                                          child: Text(
                                            e.name,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: currentCollection,
                                onChanged: (value) {
                                  print(value);
                                  if (value != null) {
                                    setState(() => currentCollection = value);
                                  }
                                },
                              ),
                            ),
                            // Book
                            SizedBox(
                              width: 150,
                              child: Combobox<String>(
                                isExpanded: true,
                                items: currentCollectionBooks
                                    .map((e) => ComboboxItem<String>(
                                          value: e.id,
                                          child: Text(e.name,
                                              overflow: TextOverflow.ellipsis),
                                        ))
                                    .toList(),
                                value: currentBook,
                                onChanged: (value) {
                                  print(value);
                                  if (value != null) {
                                    setState(() => currentBook = value);
                                  }
                                },
                              ),
                            ),
                            //This Row keeps chapter and verse together!
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              // //chapter
                              SizedBox(
                                width: 60,
                                child: Combobox<String>(
                                  isExpanded: true,
                                  items: currentBookChapters
                                      .map((e) => ComboboxItem<String>(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  value: currentChapter,
                                  onChanged: (value) {
                                    print(value);
                                    if (value != null) {
                                      setState(() => currentChapter = value);
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),

                              // //verse
                              SizedBox(
                                width: 60,
                                child: Combobox<String>(
                                  placeholder: const Text('150'),
                                  // isExpanded: true,
                                  items: currentChapterVerseNumbers
                                      .map((e) => ComboboxItem<String>(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  value: currentVerse,
                                  onChanged: (value) {
                                    print(value);
                                    if (value != null) {
                                      setState(() => currentVerse = value);
                                    }
                                  },
                                ),
                              ),
                            ]),

                            //Grouping for the buttons
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //Font increase/decrease
                                Button(
                                  onPressed: () {},
                                  child: const Icon(FluentIcons.font_increase),
                                ),
                                Button(
                                  onPressed: () {
                                    print('${widget.myColumnIndex}');
                                  },
                                  child: const Icon(FluentIcons.font_decrease),
                                ),
                                SizedBox(
                                  width: 10,
                                ),

                                ToggleButton(
                                  checked: partOfScrollGroup,
                                  onChanged: (_) {
                                    setState(() {
                                      partOfScrollGroup = !partOfScrollGroup;
                                    });
                                  },
                                  child: const Icon(FluentIcons.link),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //If this is column 1, don't let the user delete the column
                  if (widget.myColumnIndex != 0)
                    IconButton(
                      onPressed: () {
                        Provider.of<UserPrefs>(context, listen: false)
                            .deleteColumn(widget.bibleReference.key);
                      },
                      // onPressed:
                      //     widget.myColumnIndex != 0 ? (_) => deleteColumn : null,
                      icon: const Icon(FluentIcons.calculator_multiply),
                    ),
                  // Column(
                  //   mainAxisSize: MainAxisSize.max,
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     //remove a column

                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          // End of scripture column toolbar

          // The scripture container
          Expanded(
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: true),
              child: Padding(
                padding: wideWindow
                    ? EdgeInsets.only(
                        left: wideWindowPadding,
                        right: wideWindowPadding,
                        top: 12,
                        bottom: 0)
                    : const EdgeInsets.only(
                        left: 12.0, right: 12, top: 12, bottom: 0),
                child: ScrollablePositionedList.builder(
                    itemScrollController: itemScrollController,
                    itemCount: versesByParagraph.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (ctx, i) {
                      return ParagraphBuilder(
                        paragraph: versesByParagraph[i],
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
