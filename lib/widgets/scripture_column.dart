// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../models/database_builder.dart';
import '../widgets/paragraph_builder.dart';
import '../providers/user_prefs.dart';

class ScriptureColumn extends StatefulWidget {
  final int myColumnIndex;

  final AppInfo appInfo;
  final BibleReference bibleReference;
  final Function deleteColumn;

  const ScriptureColumn({
    required Key? key,
    required this.myColumnIndex,
    required this.appInfo,
    required this.bibleReference,
    required this.deleteColumn,
  }) : super(key: key);

  @override
  State<ScriptureColumn> createState() => _ScriptureColumnState();
}

class _ScriptureColumnState extends State<ScriptureColumn> {
  late ItemScrollController itemScrollController;
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  bool wideWindow = false;
  late double wideWindowPadding = 0;
  bool partOfScrollGroup = true;

  List<ParsedLine> versesInCollection = []; //All verses in Collection
  List<ParsedLine> versesToDisplay =
      []; //the specific verses to display in a paragraph
  // late BibleReference bibleReference;
  List<String> collectionNames = [];
  late Collection currentCollectionInfo;
  String currentCollection = "C01";
  List<Book> currentCollectionBooks = [];
  String currentBook = "GEN";
  List<String> currentBookChapters = [];
  String currentChapter = "1";
  List<String> currentChapterVerseNumbers = [];
  String currentVerse = "1";

  List<List<ParsedLine>> versesByParagraph = [];
  List<ParsedLine> currentParagraph = [];

  String? collectionComboBoxValue;
  String? bookComboBoxValue;
  String? chapterComboBoxValue;
  String? verseComboBoxValue;

  @override
  void initState() {
    print('scripture column initState');
    itemScrollController = ItemScrollController();

    scrollToReference(
        collection: widget.bibleReference.collectionID,
        bookID: widget.bibleReference.bookID,
        chapter: widget.bibleReference.chapter,
        verse: widget.bibleReference.verse,
        isInitState: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //do after whole widget builds
      // setSelectorsToClosestReference();
    });

    super.initState();
  }

  //from combobox selectors
  scrollToReference(
      {String? collection,
      String? bookID,
      String? chapter,
      String? verse,
      bool isInitState = false}) {
    //If we're changing the collection, we need to rebuild the whole column's content.
    //If just navigating in the collection it's scrollTo.
    print('here');
    if ((collection != null && currentCollection != collection) ||
        currentCollection == "" ||
        isInitState == true) {
      currentCollection = collection!;
      //reset the components of the paragraph builder
      versesInCollection = [];
      versesByParagraph = [];
      currentParagraph = [];

      versesInCollection = widget.appInfo.verses
          .where((element) => element.collectionid == currentCollection)
          .toList();

      //Books in current collection
      currentCollectionBooks = widget.appInfo.collections
          .where((element) => element.id == currentCollection)
          .toList()[0]
          .books;

      if (bookID == null) {
        currentBook = currentCollectionBooks[0].id;
      }

      setUpComboBoxesChVs(currentBook, currentChapter, currentVerse);

      //Because the collection changed, we're leaving the book/ch/vs as they were, but have to
      //TODO check to see if currentBook/ch/vs exists in the collection and choose what to do

      //Now get chapters in current book

      for (var i = 0; i < versesInCollection.length; i++) {
        //if not new paragraph marker, add the line to the current paragraph
        if (!versesInCollection[i].verseStyle.contains(RegExp(r'[p,m,s\d*]'))) {
          currentParagraph.add(versesInCollection[i]);
        } else {
          //If it is a new paragraph marker, add the existing verses to the big list, and start over with a new paragraph
          versesByParagraph.add(currentParagraph);
          currentParagraph = [versesInCollection[i]];
          // if (currentParagraph.isNotEmpty) {
          //   versesByParagraph.add(currentParagraph);
          //   currentParagraph = [];
          // }
        }
      }
      if (!isInitState) setState(() {});
    } else {
      //Above is collection change, which resets the whole column.
      //Here is where the choice of book, ch, vs comes, and is a scrollTo with the same content
      //Find index of the paragraph that has the desired verse
      //We don't know which the user has navigated to, so sort that out
      if (bookID != null) currentBook = bookID;
      if (chapter != null) currentChapter = chapter;
      if (verse != null) currentVerse = verse;

      int navigateToParagraph = 0;
      for (int i = 0; i < versesByParagraph.length; i++) {
        var test = versesByParagraph[i].indexWhere((element) =>
            element.book == currentBook &&
            element.chapter == currentChapter &&
            element.verse == currentVerse);
        if (test != -1) {
          navigateToParagraph = i;
          break;
        }
      } //for loop
      setUpComboBoxesChVs(currentBook, currentChapter, currentVerse);
      //Navigate to the paragraph.
      itemScrollController.scrollTo(
          index: navigateToParagraph, duration: Duration(milliseconds: 500));
      setState(() {});

      // print(navigateToParagraph.toString());
    } //end of book/ch/vs else
    // print(currentCollection);
    // print(currentBook);
    // print(currentChapter);
    // print(currentVerse);
  }

  //On user end scroll notification
  setSelectorsToClosestReference() {
    var oldBook = currentBook;
    var oldChapter = currentChapter;

    var p = itemPositionsListener.itemPositions.value.first.index;

    List<ParsedLine> para = versesByParagraph[p];

    outerloop:
    for (var i = p; i < versesByParagraph.length; i++) {
      para = versesByParagraph[i];
      if (para.isNotEmpty) {
        for (var l = 0; l < para.length; l++) {
          if ((para[l].chapter != "" && para[l].chapter != "0") &&
              (para[l].verse != "" && para[l].chapter != "0")) {
            currentBook = para[l].book;
            currentChapter = para[l].chapter;
            currentVerse = para[l].verse;
            if (currentBook != oldBook || currentChapter != oldChapter) {
              //reset combobox
              setUpComboBoxesChVs(currentBook, currentChapter, currentVerse);
            }

            // print(para[l].book);
            // print(para[l].chapter);
            // print(para[l].verse);

            setState(() {});

            break outerloop;
          }
        }
      }
    }
  }

  setUpComboBoxesChVs(String newBook, String newChapter, String newVerse) {
    currentBook = newBook;

    List<String> temp = versesInCollection
        .where((element) => element.book == currentBook)
        .map((e) => e.chapter)
        .toList();

    //.toSet().toList() here reduces a big list to unique values
    currentBookChapters = temp.toSet().toList();

    currentChapter = newChapter;

    currentChapterVerseNumbers = versesInCollection
        .where((element) =>
            element.book == currentBook &&
            element.chapter == currentChapter &&
            element.verse != "")
        .map((e) => e.verse)
        .toList();

    currentVerse = newVerse;
  }

  @override
  Widget build(BuildContext context) {
    print('Scripture Column build');
    int numberOfColumns =
        Provider.of<UserPrefs>(context, listen: false).userColumns.length;
    double windowWidth = MediaQuery.of(context).size.width;
    // print('windowWidth $windowWidth');
    // print('numberOfColumns $numberOfColumns');
    if (windowWidth > 500 && numberOfColumns == 1) {
      wideWindow = true;
      wideWindowPadding = windowWidth / 5;
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //header toolbar/s
        children: [
          //Scripture column toolbar
          Padding(
            padding: const EdgeInsets.only(top: 5.0, right: 5, left: 5),
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
                            //Collections/translations
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
                                  scrollToReference(collection: value);
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
                                  scrollToReference(bookID: value);
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
                                    scrollToReference(chapter: value);
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
                                    scrollToReference(verse: value);
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
                        widget.deleteColumn(widget.key);
                      },
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
            child: NotificationListener(
              onNotification: (dynamic notification) {
                if (notification is ScrollEndNotification) {
                  setSelectorsToClosestReference();
                }

                return true;
              },
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: true),
                child: Padding(
                  padding: wideWindow
                      ? EdgeInsets.only(
                          left: wideWindowPadding,
                          right: wideWindowPadding,
                          top: 0,
                          bottom: 0)
                      : const EdgeInsets.only(
                          left: 12.0, right: 12, top: 0, bottom: 0),
                  child: ScrollablePositionedList.builder(
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
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
          ),
        ],
      ),
    );
  }
}
