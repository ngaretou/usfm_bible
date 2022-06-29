// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:async';

import 'dart:async';

// import 'package:flutter/material.dart' as material;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:usfm_bible/providers/column_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

import '../models/database_builder.dart';
import '../widgets/paragraph_builder.dart';
import 'package:contextmenu/contextmenu.dart';
import '../providers/user_prefs.dart';
import '../providers/column_manager.dart';

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
  late double wideWindowPadding;
  late bool partOfScrollGroup;

  late double baseFontSize;
  List<ParsedLine> rangeOfVersesToCopy = [];

  List<ParsedLine> versesInCollection = []; //All verses in Collection
  List<ParsedLine> versesToDisplay =
      []; //the specific verses to display in a paragraph
  // late BibleReference bibleReference;
  List<String> collectionNames = [];
  late Collection currentCollectionInfo;
  ValueNotifier<String> currentCollection = ValueNotifier("C01");
  List<Book> currentCollectionBooks = [];
  ValueNotifier<String> currentBook = ValueNotifier("GEN");

  List<String> currentBookChapters = [];
  ValueNotifier<String> currentChapter = ValueNotifier("1");

  List<String> currentChapterVerseNumbers = [];

  ValueNotifier<String> currentVerse = ValueNotifier("1");

  List<List<ParsedLine>> versesByParagraph = [];
  List<ParsedLine> currentParagraph = [];

  String? collectionComboBoxValue;
  String? bookComboBoxValue;
  String? chapterComboBoxValue;
  String? verseComboBoxValue;

  @override
  void initState() {
    partOfScrollGroup = widget.bibleReference.partOfScrollGroup;
    print('scripture column initState');
    baseFontSize = 20;
    itemScrollController = ItemScrollController();

    scrollToReference(
        collection: widget.bibleReference.collectionID,
        bookID: widget.bibleReference.bookID,
        chapter: widget.bibleReference.chapter,
        verse: widget.bibleReference.verse,
        isInitState: true);

    super.initState();
  }

  // changeCollection(String newCollection) {
  //   // do something to rebuild only 1st column Text not the whole page
  //   currentCollection.value = newCollection;
  // }

  //from combobox selectors
  scrollToReference(
      {String? collection,
      String? bookID,
      String? chapter,
      String? verse,
      bool isInitState = false}) {
    print('scrollToReference');
    //If we're changing the collection, we need to rebuild the whole column's content.
    //If just navigating in the collection it's scrollTo.

    if ((collection != null && currentCollection.value != collection) ||
        currentCollection.value == "" ||
        isInitState == true) {
      currentCollection.value = collection!;

      //reset the components of the paragraph builder
      versesInCollection = [];
      versesByParagraph = [];
      currentParagraph = [];

      versesInCollection = widget.appInfo.verses
          .where((element) => element.collectionid == currentCollection.value)
          .toList();

      //Books in current collection
      currentCollectionBooks = widget.appInfo.collections
          .where((element) => element.id == currentCollection.value)
          .toList()[0]
          .books;

      if (bookID == null) {
        currentBook.value = currentCollectionBooks[0].id;
      }

      //get some reasonable initial values based on the contents if no explicit destination
      if (chapter == null) {
        currentChapter.value = versesInCollection
            .firstWhere((element) => element.book == currentBook.value)
            .chapter;
      }
      if (verse == null) {
        currentVerse.value = versesInCollection
            .firstWhere((element) =>
                element.book == currentBook.value &&
                element.chapter == currentChapter.value &&
                element.verse != "")
            .verse;
      }

      //TODO Because the collection changed, we're leaving the book/ch/vs as they were, but have to
      // check to see if currentBook/ch/vs exists in the collection and choose what to do

      //Now get chapters in current book

      for (var i = 0; i < versesInCollection.length; i++) {
        //if not new paragraph marker, add the line to the current paragraph
        if (!versesInCollection[i].verseStyle.contains(RegExp(
            r'[p,m,po,pr,cls,pmo,pm,pmc,pmr,pi\d,mi,nb,pc,ph\d,b,mt\d,mte\d,ms\d,mr,s\d*,sr,r,d,sp,sd\d,q,q1,q2,qr,qc,qa,qm\d,qd,lh,li\d,lf,lim\d]'))) {
          currentParagraph.add(versesInCollection[i]);
        } else {
          //If it is a new paragraph marker, add the existing verses to the big list, and start over with a new paragraph
          versesByParagraph.add(currentParagraph);
          currentParagraph = [versesInCollection[i]];
        }
      }
      setUpComboBoxesChVs(
          currentBook.value, currentChapter.value, currentVerse.value);
    } else {
      String oldBook = currentBook.value;
      String oldChapter = currentChapter.value;
      String oldVerse = currentVerse.value;

      //Above is collection change, which resets the whole column.
      //Here is where the choice of book, ch, vs comes, and is a scrollTo with the same content
      //Find index of the paragraph that has the desired verse
      //We don't know which the user has navigated to, so sort that out
      if (bookID != null && chapter != null && verse != null) {
        currentBook.value = bookID;
        currentChapter.value = chapter;
        currentVerse.value = verse;
      } else if (bookID != null && chapter == null && verse == null) {
        currentBook.value = bookID;
        currentChapter.value = '1';
        currentVerse.value = '1';
      } else if (chapter != null && verse == null) {
        currentChapter.value = chapter;
        currentVerse.value = '1';
      } else if (verse != null) {
        currentVerse.value = verse;
      }

      int? navigateToParagraph;

      for (int i = 0; i < versesByParagraph.length; i++) {
        int test;
        if (chapter == '1' && verse == '1') {
          test = versesByParagraph[i]
              .indexWhere((element) => element.book == currentBook.value);
        } else {
          test = versesByParagraph[i].indexWhere((element) =>
              element.book == currentBook.value &&
              element.chapter == currentChapter.value &&
              element.verse == currentVerse.value);
        }

        if (test != -1) {
          navigateToParagraph = i;
          break;
        }
      } //for loop

      //Earlier possibility for no result:
      //If there is no result- the desired reference is not in the collection,
      //unhook from the scrollgroup and go to first reference in collection
      // if (navigateToParagraph == null) {
      //   partOfScrollGroup = false;

      //   currentBook.value = currentCollectionBooks[0].id;

      //   currentChapter.value = versesInCollection
      //       .firstWhere((element) => element.book == currentBook.value)
      //       .chapter;

      //   currentVerse.value = versesInCollection
      //       .firstWhere((element) =>
      //           element.book == currentBook.value &&
      //           element.chapter == currentChapter.value &&
      //           element.verse != "")
      //       .verse;

      //   itemScrollController.scrollTo(
      //       index: 0, alignment: 0.125, duration: Duration(milliseconds: 500));
      //   setState(() {});
      // }

      //If no result, just hang on, don't scroll, just stay
      if (navigateToParagraph != null) {
        //If it's the normal situation, we did find the reference, so go there.
        setUpComboBoxesChVs(
            currentBook.value, currentChapter.value, currentVerse.value);

        //This is so that it will leave a bit more space at the beginning for the book title to show
        bool firstVerseOfChapter =
            currentChapter.value == '1' && currentVerse.value == '1';

        //Navigate to the paragraph.
        itemScrollController.scrollTo(
          index: navigateToParagraph,
          alignment: firstVerseOfChapter ? 0.125 : 0,
          duration: Duration(milliseconds: 500),
        );

        BibleReference ref = BibleReference(
            key: widget.bibleReference.key,
            partOfScrollGroup: partOfScrollGroup,
            collectionID: currentCollection.value,
            bookID: currentBook.value,
            chapter: currentChapter.value,
            verse: currentVerse.value);

        if (partOfScrollGroup) {
          Provider.of<ColumnManager>(context, listen: false).setScrollGroupRef =
              ref;
        }
      } else {
        currentBook.value = oldBook;
        currentChapter.value = oldChapter;
        currentVerse.value = oldVerse;
      }
    } //end of book/ch/vs else
  }

  //On user end scroll notification
  setSelectorsToClosestReferenceAfterScroll() {
    // print('setSelectorsToClosestReferenceAfterScroll');
    // var oldBook = currentBook;
    // var oldChapter = currentChapter;

    var p = itemPositionsListener.itemPositions.value.first.index;

    List<ParsedLine> para = versesByParagraph[p];

    outerloop:
    for (var i = p; i < versesByParagraph.length; i++) {
      para = versesByParagraph[i];
      if (para.isNotEmpty) {
        for (var l = 0; l < para.length; l++) {
          if ((para[l].chapter != "" && para[l].chapter != "0") &&
              (para[l].verse != "" && para[l].verse != "0")) {
            if (currentBook.value != para[l].book) {
              currentBook.value = para[l].book;
            }
            if (currentChapter.value != para[l].chapter) {
              currentChapter.value = para[l].chapter;
            }
            if (currentVerse.value != para[l].verse) {
              print('verse change');
              currentVerse.value = para[l].verse;
            }

            BibleReference ref = BibleReference(
                key: widget.bibleReference.key,
                partOfScrollGroup: partOfScrollGroup,
                collectionID: currentCollection.value,
                bookID: currentBook.value,
                chapter: currentChapter.value,
                verse: currentVerse.value);

            if (partOfScrollGroup) {
              Provider.of<ColumnManager>(context, listen: false)
                  .setScrollGroupRef = ref;
            }

            //reset combobox
            setUpComboBoxesChVs(
                currentBook.value, currentChapter.value, currentVerse.value);

            break outerloop;
          }
        }
      }
    }
  }

  setUpComboBoxesChVs(String newBook, String newChapter, String newVerse) {
    // print('setUpComboBoxesChVs');
    currentBook.value = newBook;

    List<String> temp = versesInCollection
        .where((element) => element.book == currentBook.value)
        .map((e) => e.chapter)
        .toList();

    //.toSet().toList() here reduces a big list to unique values
    currentBookChapters = temp.toSet().toList();

    currentChapter.value = newChapter;

    currentChapterVerseNumbers = versesInCollection
        .where((element) =>
            element.book == currentBook.value &&
            element.chapter == currentChapter.value &&
            element.verse != "")
        .map((e) => e.verse)
        .toList();

    // currentVerse = newVerse;
  }

  addVerseToCopyRange(ParsedLine ref) {
    addVersesBetweenIndexes(int startIndex, int endIndex) {
      rangeOfVersesToCopy = [];
      for (var i = startIndex; i <= endIndex; i++) {
        rangeOfVersesToCopy.add(versesInCollection[i]);
      }
    }

    int startIndex = 0;
    int endIndex = 0;

    bool verseAlreadyInRange = rangeOfVersesToCopy.any((ParsedLine element) =>
        element.book == ref.book &&
        element.chapter == ref.chapter &&
        element.verse == ref.verse);

    //If no verses yet, just add the ref
    if (rangeOfVersesToCopy.isEmpty) {
      rangeOfVersesToCopy.add(ref);
    }
    // if there is only one verse, and the incoming verse is the same as the one that's in there, get rid of it.
    else if (rangeOfVersesToCopy.length == 1 && verseAlreadyInRange) {
      rangeOfVersesToCopy = [];
    }
    //if only 2 verses, and the one clicked is already in, remove it
    else if (rangeOfVersesToCopy.length == 2 && verseAlreadyInRange) {
      rangeOfVersesToCopy.remove(ref);
    }
    // if the verses to copy does not contain the ref that the user just sent, add all the refs between the first and last ref
    else if (!verseAlreadyInRange) {
      print('third case');
      //add this verse and then
      rangeOfVersesToCopy.add(ref);
      //add all between the first and last
      int oneEnd = versesInCollection.indexWhere((element) =>
          element.book == rangeOfVersesToCopy.first.book &&
          element.chapter == rangeOfVersesToCopy.first.chapter &&
          element.verse == rangeOfVersesToCopy.first.verse);

      int otherEnd = versesInCollection.indexWhere((element) =>
          element.book == rangeOfVersesToCopy.last.book &&
          element.chapter == rangeOfVersesToCopy.last.chapter &&
          element.verse == rangeOfVersesToCopy.last.verse);

      //See which way round the entries are - later verse first or earlier first
      int result = oneEnd.compareTo(otherEnd);
      if (result < 0) {
        startIndex = oneEnd;
        endIndex = otherEnd;
      } else {
        startIndex = otherEnd;
        endIndex = oneEnd;
      }
      addVersesBetweenIndexes(startIndex, endIndex);
    }
    //if the user has changed their minds and wants to shorten the list of verses to work with
    else if (rangeOfVersesToCopy.length >= 2 && verseAlreadyInRange) {
      print('fourth option');
      startIndex = versesInCollection.indexWhere((element) =>
          element.book == rangeOfVersesToCopy[0].book &&
          element.chapter == rangeOfVersesToCopy[0].chapter &&
          element.verse == rangeOfVersesToCopy[0].verse);

      endIndex = versesInCollection.indexWhere((element) =>
          element.book == ref.book &&
          element.chapter == ref.chapter &&
          element.verse == ref.verse);
      addVersesBetweenIndexes(startIndex, endIndex);
    }
    setState(() {});
  }

  String textToShareOrCopy() {
    String textToReturn = '';
    String reference = '';
    // String lineBreak = kIsWeb ? '%0d%0a' : '\n';
    String lineBreak = '\n';

    for (var i = 0; i < rangeOfVersesToCopy.length; i++) {
      var temp =
          verseComposer(line: rangeOfVersesToCopy[i], includeFootnotes: false)
              .versesAsString;
      textToReturn = '$textToReturn$temp ';
    }

    //Reference
    //Get collection name in regular text
    String currentCollectionName = collections
        .where((element) => element.id == currentCollection.value)
        .first
        .name;

    //Get the books
    if (rangeOfVersesToCopy.first.book == rangeOfVersesToCopy.last.book) {
      String bookName = currentCollectionBooks
          .where((element) => element.id == rangeOfVersesToCopy.first.book)
          .first
          .name;

      //only one verse: Genesis 1.1
      if (rangeOfVersesToCopy.length == 1) {
        reference =
            '$bookName ${rangeOfVersesToCopy.first.chapter}.${rangeOfVersesToCopy.first.verse}';
      }
      //same chapter: Genesis 1.2-10
      else if (rangeOfVersesToCopy.first.chapter ==
          rangeOfVersesToCopy.last.chapter) {
        reference =
            '$bookName ${rangeOfVersesToCopy.first.chapter}.${rangeOfVersesToCopy.first.verse}-${rangeOfVersesToCopy.last.verse}';
      } else {
        //same book different chapter: Genesis 1.20-2.2
        reference =
            '$bookName ${rangeOfVersesToCopy.first.chapter}.${rangeOfVersesToCopy.first.verse}-${rangeOfVersesToCopy.last.chapter}.${rangeOfVersesToCopy.last.verse}';
      }
    } else {
      // range is across books so just take first and last
      String firstBookName = currentCollectionBooks
          .where((element) => element.id == rangeOfVersesToCopy.first.book)
          .first
          .name;
      String lastBookName = currentCollectionBooks
          .where((element) => element.id == rangeOfVersesToCopy.last.book)
          .last
          .name;

      //Genesis 50.30-Exodus 1.20
      reference =
          '$firstBookName ${rangeOfVersesToCopy.first.chapter}.${rangeOfVersesToCopy.first.verse}-$lastBookName ${rangeOfVersesToCopy.last.chapter}.${rangeOfVersesToCopy.last.verse}';
    }

    textToReturn = '$textToReturn$lineBreak$reference ($currentCollectionName)';
    rangeOfVersesToCopy = [];
    setState(() {});
    return textToReturn;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BibleReference? ref =
          Provider.of<ColumnManager>(context, listen: false).getScrollGroupRef;

      if (partOfScrollGroup && ref != null) {
        if (currentBook.value != ref.bookID ||
            currentChapter.value != ref.chapter ||
            currentVerse.value != ref.verse) {
          print('trying to simulscroll in ${widget.key}');
          print('${ref.bookID} ${ref.chapter} ${ref.verse}');
          scrollToReference(
              bookID: ref.bookID, chapter: ref.chapter, verse: ref.verse);
        }
      }
    });
    print('Scripture Column build ${widget.key}');

    // var ref = Provider.of<ColumnManager>(context, listen: true).getScrollGroupRef;

    if (Provider.of<ColumnManager>(context, listen: true).readyToAddColumn) {
      //this rebuilds when adding a column
      setState(() {});
    }

    if (Provider.of<ColumnManager>(context, listen: true)
        .timeToRebuildColumns) {
      print('Rebuild request received');
      setState(() {});
    }

    int numberOfColumns =
        Provider.of<UserPrefs>(context, listen: true).userColumns.length;

    double windowWidth = MediaQuery.of(context).size.width;

    if (windowWidth > 1024 && numberOfColumns == 1) {
      wideWindow = true;
      wideWindowPadding = windowWidth / 5;
    } else {
      wideWindow = false;
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
                              child: ValueListenableBuilder<String>(
                                  valueListenable: currentCollection,
                                  builder: (context, val, child) {
                                    return Combobox<String>(
                                      isExpanded: true,
                                      items: widget.appInfo.collections
                                          .map((e) => ComboboxItem<String>(
                                                value: e.id,
                                                child: Text(
                                                  e.name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ))
                                          .toList(),
                                      value: val,
                                      onChanged: (value) {
                                        scrollToReference(collection: value);
                                      },
                                    );
                                  }),
                            ),

                            // Book
                            SizedBox(
                              width: 150,
                              child: ValueListenableBuilder<String>(
                                  valueListenable: currentBook,
                                  builder: (context, val, child) {
                                    return Combobox<String>(
                                      isExpanded: true,
                                      items: currentCollectionBooks
                                          .map((e) => ComboboxItem<String>(
                                                value: e.id,
                                                child: Text(e.name,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ))
                                          .toList(),
                                      value: val,
                                      onChanged: (value) {
                                        scrollToReference(bookID: value);
                                      },
                                    );
                                  }),
                            ),
                            //This Row keeps chapter and verse together!
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              // //chapter
                              SizedBox(
                                width: 60,
                                child: ValueListenableBuilder<String>(
                                    valueListenable: currentChapter,
                                    builder: (context, val, child) {
                                      return Combobox<String>(
                                        isExpanded: true,
                                        items: currentBookChapters
                                            .map((e) => ComboboxItem<String>(
                                                  value: e,
                                                  child: Text(e),
                                                ))
                                            .toList(),
                                        value: val,
                                        onChanged: (value) {
                                          scrollToReference(chapter: value);
                                        },
                                      );
                                    }),
                              ),
                              SizedBox(
                                width: 5,
                              ),

                              // //verse
                              SizedBox(
                                width: 60,
                                child: ValueListenableBuilder<String>(
                                    valueListenable: currentVerse,
                                    builder: (context, val, child) {
                                      return Combobox<String>(
                                        placeholder: const Text('150'),
                                        // isExpanded: true,
                                        items: currentChapterVerseNumbers
                                            .map((e) => ComboboxItem<String>(
                                                  value: e,
                                                  child: Text(e),
                                                ))
                                            .toList(),
                                        value: val,
                                        onChanged: (value) {
                                          scrollToReference(verse: value);
                                        },
                                      );
                                    }),
                              ),
                            ]),

                            //Grouping for the buttons
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //Font increase/decrease
                                Button(
                                  onPressed: () {
                                    if (baseFontSize < 37) {
                                      setState(() {
                                        baseFontSize = baseFontSize + 1;
                                        print(baseFontSize);
                                      });
                                    }
                                  },
                                  child: const Icon(FluentIcons.font_increase),
                                ),
                                Button(
                                  onPressed: () {
                                    if (baseFontSize > 10) {
                                      setState(() {
                                        baseFontSize = baseFontSize - 1;
                                      });
                                    }
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
              onNotification: (ScrollNotification notification) {
                //This if reduces the number of times the selector method is triggered
                // print(notification);
                if (notification is UserScrollNotification &&
                    notification.direction == ScrollDirection.idle) {
                  Timer(Duration(milliseconds: 20),
                      setSelectorsToClosestReferenceAfterScroll);
                }

                return true;
              },
              // child: ScrollConfiguration(
              //   behavior: ScrollConfiguration.of(context).copyWith(
              //     scrollbars: true,
              //     overscroll: true,
              //     platform: TargetPlatform.macOS,
              //   ),
              child: Padding(
                padding: wideWindow
                    ? EdgeInsets.only(
                        left: wideWindowPadding,
                        right: wideWindowPadding,
                        top: 0,
                        bottom: 0)
                    : const EdgeInsets.only(
                        left: 12.0, right: 4, top: 0, bottom: 0),
                child: ContextMenuArea(
                  builder: (context) => [
                    GestureDetector(
                      child: const ListTile(
                          leading: Icon(FluentIcons.copy), title: Text('Copy')),
                      onTap: () {
                        Navigator.of(context).pop();
                        Clipboard.setData(
                            ClipboardData(text: textToShareOrCopy()));
                      },
                    ),
                    GestureDetector(
                      child: const ListTile(
                          leading: Icon(FluentIcons.share),
                          title: Text('Share')),
                      onTap: () async {
                        Navigator.of(context).pop();
                        //if it's not the web app, share using the device share function
                        String textToShare = textToShareOrCopy();
                        if (!kIsWeb) {
                          Share.share(textToShare);
                        } else {
                          //If it's the web app version best way to share is probably email, so put the text to share in an email
                          final String url =
                              "mailto:?subject=&body=$textToShare";

                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url));
                          } else {
                            throw 'Could not launch $url';
                          }
                        }
                      },
                    ),
                  ],
                  child: ScrollablePositionedList.builder(
                      padding: EdgeInsets.only(right: 12),
                      initialAlignment: 1,
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                      itemCount: versesByParagraph.length,
                      shrinkWrap: false,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        return ParagraphBuilder(
                          paragraph: versesByParagraph[i],
                          fontSize: baseFontSize,
                          rangeOfVersesToCopy: rangeOfVersesToCopy,
                          addVerseToCopyRange: addVerseToCopyRange,
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
