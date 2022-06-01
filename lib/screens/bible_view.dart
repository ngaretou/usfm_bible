// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fluent_ui/fluent_ui.dart';
import '../models/database_builder.dart';
import '../widgets/paragraph_builder.dart';

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
  final bool? addPane;
  final AppInfo appInfo;

  const BibleView({Key? key, this.addPane, required this.appInfo})
      : super(key: key);

  @override
  State<BibleView> createState() => _BibleViewState();
}

class _BibleViewState extends State<BibleView> {
  int currentIndex = 0;

  //Initial number of columns - to be refigured below
  int numberOfColumns = 2;
  //We're limiting it to four panes and four scrollcontrollers.
  ScrollController scrollController1 = ScrollController();
  ScrollController scrollController2 = ScrollController();
  ScrollController scrollController3 = ScrollController();
  ScrollController scrollController4 = ScrollController();
  List<ScrollController> scrollControllers = [];

  @override
  void initState() {
    scrollControllers = [
      scrollController1,
      scrollController2,
      scrollController3,
      scrollController4,
    ];
    //How many columns should we initially open?
    switch (widget.appInfo.collections.length) {
      case 1:
        numberOfColumns = 2;
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

    super.initState();
  }

  changeNumberColumns(bool add) {
    print('changeNumberColumns');
    if (add == true) {
      numberOfColumns++;
    } else {
      numberOfColumns--;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppInfo appInfo = widget.appInfo;
    print('bible view build');
    if (widget.addPane != null && widget.addPane!) changeNumberColumns(true);

    return Row(
      children: List.generate(numberOfColumns, (index) {
        return Expanded(
          child: Center(
            child: ScriptureColumn(
              myColumnIndex: index,
              numberOfColumns: numberOfColumns,
              appInfo: appInfo,
              scrollController: scrollControllers[index],
              changeNumberColumns: changeNumberColumns,
            ),
          ),
        );
      }),
    );
  }
}

class ScriptureColumn extends StatefulWidget {
  final int myColumnIndex;
  final int numberOfColumns;
  final AppInfo appInfo;
  final ScrollController scrollController;
  final Function(bool) changeNumberColumns;

  const ScriptureColumn(
      {Key? key,
      required this.myColumnIndex,
      required this.numberOfColumns,
      required this.appInfo,
      required this.scrollController,
      required this.changeNumberColumns})
      : super(key: key);

  @override
  State<ScriptureColumn> createState() => _ScriptureColumnState();
}

class _ScriptureColumnState extends State<ScriptureColumn> {
  bool partOfScrollGroup = true;

  List<ParsedLine> versesInColumn = []; //All verses in Collection
  List<ParsedLine> versesToDisplay =
      []; //the specific verses to display in a paragraph
  late BibleReference bibleReference;
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
    //set initial collection
    //If just one collection, iniitally give the users two views but not tied to the same scrollgroup.
    if (widget.appInfo.collections.length == 1) {
      partOfScrollGroup = false;
      currentCollection = "C01";
    } else {
      partOfScrollGroup = false;
      //If it is more than one collection, each column initially will just take the next collection down.
      String collectionString = (widget.myColumnIndex + 1).toString();
      currentCollection = "C0$collectionString";
      // versesToShow = widget.appInfo.verses
      //     .where((element) => element.collectionid == "C0$collectionString")
      //     .toList();
    }
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
    //receive list of verses

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      //header toolbar/s
      children: [
        //Scripture column toolbar
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            child: Wrap(
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
                              child:
                                  Text(e.name, overflow: TextOverflow.ellipsis),
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
                // //chapter
                SizedBox(
                  width: 54,
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
                // //verse
                SizedBox(
                  width: 54,
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
                SizedBox(
                  width: 20,
                ),

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
                      onPressed: () {},
                      child: const Icon(FluentIcons.font_decrease),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //Add new column
                    Button(
                      onPressed:
                          widget.numberOfColumns <= 3 //keep it to four columns
                              ? () => widget.changeNumberColumns(
                                  true) //communicating up widget tree
                              : null,
                      child: const Icon(FluentIcons.calculator_addition),
                    ), //null makes it disabled
                    //remove a column
                    if (widget.myColumnIndex != 0)
                      Button(

                          //If this is column 1, don't let the user delete the column
                          onPressed: widget.myColumnIndex != 0
                              ? () => widget.changeNumberColumns(false)
                              : null,
                          child: const Icon(FluentIcons.calculator_subtract)),

                    // Button(
                    //     child: const Icon(FluentIcons.accessibilty_checker),
                    //     onPressed: () {}),

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
          ),
        ),
        //End of scripture column toolbar

        //The scripture container
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12, top: 12, bottom: 0),
            //TODO: Scrollable positioned list
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: true),
              child: ListView.builder(
                  controller: widget.scrollController,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (ctx, i) {
                    return ParagraphBuilder(
                      paragraph: versesByParagraph[i],
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
