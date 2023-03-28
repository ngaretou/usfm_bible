import 'dart:ui' as ui;
import 'dart:async';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:usfm_bible/providers/column_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:context_menus/context_menus.dart';

import '../logic/database_builder.dart';
import '../logic/verse_composer.dart';
import '../widgets/paragraph_builder.dart';

import '../providers/user_prefs.dart';

class ScriptureColumn extends StatefulWidget {
  final int myColumnIndex;
  final AppInfo appInfo;
  final BibleReference bibleReference;
  final Function deleteColumn;
  final String? comboBoxFont;

  const ScriptureColumn({
    required Key? key,
    required this.myColumnIndex,
    required this.appInfo,
    required this.bibleReference,
    required this.deleteColumn,
    this.comboBoxFont,
  }) : super(key: key);

  @override
  State<ScriptureColumn> createState() => _ScriptureColumnState();
}

class _ScriptureColumnState extends State<ScriptureColumn> {
  late ItemScrollController itemScrollController;
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  late ScrollablePositionedList scrollablePositionedList;

  int? delayedScrollIndex;
  bool wideWindow = false;
  late double wideWindowPadding;
  late bool partOfScrollGroup;
  late double baseFontSize;
  List<ParsedLine> rangeOfVersesToCopy = [];

  //All verses in Collection
  List<ParsedLine> versesInCollection = [];

  List<String> collectionNames = [];
  List<Book> currentCollectionBooks = [];

  //Just default values, will get set below
  ValueNotifier<String> currentCollection = ValueNotifier("C01");
  ValueNotifier<String> currentBook = ValueNotifier("GEN");
  ValueNotifier<String> currentChapter = ValueNotifier("1");
  ValueNotifier<String> currentVerse = ValueNotifier("1");

  List<String> currentBookChapters = [];
  List<String> currentChapterVerseNumbers = [];

  List<List<ParsedLine>> versesByParagraph = [];
  List<ParsedLine> currentParagraph = [];

  String? collectionComboBoxValue;
  String? bookComboBoxValue;
  String? chapterComboBoxValue;
  String? verseComboBoxValue;

  late int previousParaPosition;

  @override
  void initState() {
    print('scripture column initState');
    partOfScrollGroup = widget.bibleReference.partOfScrollGroup;
    baseFontSize = 20;
    previousParaPosition = 0;
    itemScrollController = ItemScrollController();

    scrollToReference(
        collection: widget.bibleReference.collectionID,
        bookID: widget.bibleReference.bookID,
        chapter: widget.bibleReference.chapter,
        verse: widget.bibleReference.verse,
        isInitState: true);

    super.initState();
  }

  //Function called on first open and also from combobox selectors to go to a Bible reference
  scrollToReference(
      {String? collection,
      String? bookID,
      String? chapter,
      String? verse,
      bool isInitState = false}) {
    Key? activeColumnKey = context.read<ScrollGroup>().getActiveColumnKey;

    /// Function to check if a reference is in the collection, return the index of the PARAGRAPH it is in or if not found, null
    int checkIfRefIsInCollection(String bk, String ch, String vs) {
      int returnMe = -1;

      // Get the reference to the paragraph we're heading to - at the same time test if it does exist.
      for (int i = 0; i < versesByParagraph.length; i++) {
        int test;
        if (ch == '1' && vs == '1') {
          test =
              versesByParagraph[i].indexWhere((element) => element.book == bk);
        } else {
          test = versesByParagraph[i].indexWhere((element) =>
              // element.book == currentBook.value &&
              // element.chapter == currentChapter.value &&
              // element.verse == currentVerse.value);
              element.book == bk &&
              element.chapter == ch &&
              element.verse == vs);
        }

        //if the destination does exist in the collection, initiate a scroll to it.
        if (test != -1) {
          returnMe = i;
          break;
        }
      } //for loop
      return returnMe;
    }

    //If we're changing the collection, we need to rebuild the whole column's content.
    //If just navigating in the collection (the 'else' below) it's scrollTo.

    if (collection != null) {
      // If we are navigating to a new collection or opening the app
      //or rebuilding after either changing light to dark mode or coming back
      //after settings screen etc...

      currentCollection.value = collection;

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

      // Organize the verses into paragraphs
      for (var i = 0; i < versesInCollection.length; i++) {
        //If it is a new paragraph marker, add the existing verses to the big list, and start over with a new paragraph
        if (versesInCollection[i].verseStyle.contains(RegExp(
            r'[p,po,pr,cls,pmo,pm,pmc,pmr,pi\d,mi,nb,pc,ph\d,b,mt\d,mte\d,ms\d,mr,s\d*,sr,sp,sd\d,q,q1,q2,qr,qc,qa,qm\d,qd,lh,li\d,lf,lim\d]'))) {
          versesByParagraph.add(currentParagraph);
          currentParagraph = [versesInCollection[i]];
          //If it's a one line paragraph
        } else if ((versesInCollection[i]
            .verseStyle
            .contains(RegExp(r'[m,r,d]')))) {
          versesByParagraph.add(currentParagraph);
          versesByParagraph.add([versesInCollection[i]]);
          currentParagraph = [];
        } else {
          //otheriwise just add the line to the paragraph
          currentParagraph.add(versesInCollection[i]);
        }
      }
      //Get that last paragraph added!
      versesByParagraph.add(currentParagraph);

      //Verses in order; //////////////////////
      //Now figure out where we're going
      BibleReference? scrollCollectionRef =
          Provider.of<ScrollGroup>(context, listen: false).getScrollGroupRef;
      int navigateToParagraph = 0;

      //Now we have three different cases -
      //if there is a scroll ref and this column is part of the group, scroll to it;
      //if bk, ch, vs all not null go to that indicated passage;
      //go to first ref in collection if neither of those are true

      //This is a helper in cases where a ref is not in the collection
      void refNotInCollection() {
        void goToBeginning() {
          //our column has a ref but something is wrong - go to first ref in collection
          currentBook.value = currentCollectionBooks[0].id;

          currentChapter.value = '1';
          currentVerse.value = '1';
          navigateToParagraph = 0;
        }
        //if our column has a ref, just stay at it -
        //this is when a NT does not have an OT book but you're trying to scroll to it

        List<BibleReference> userColumns =
            Provider.of<UserPrefs>(context, listen: false).userColumns;
        BibleReference savedBibleRefForThisColumn = userColumns
            .firstWhere((element) => element.key == widget.bibleReference.key);
        /*We're here b/c we're trying to scroll to a ref not in the collection
          If there is an existing ref for this column, let's try to scroll to it*/
        if (savedBibleRefForThisColumn.bookID != null) {
          //Just to be on the safe side check to make sure that ref does in fact exist.
          navigateToParagraph = checkIfRefIsInCollection(
              widget.bibleReference.bookID!,
              widget.bibleReference.chapter!,
              widget.bibleReference.verse!);
          //If it does exist, then go ahead and navigate
          if (navigateToParagraph != -1) {
            currentBook.value = widget.bibleReference.bookID!;
            currentChapter.value = widget.bibleReference.chapter!;
            currentVerse.value = widget.bibleReference.verse!;
          } else {
            //Otherwise go to beginning
            goToBeginning();
          }
        } else {
          //This is we've tried to navigate to a ref, it doesn't exist,
          //and we checked for an existing ref, it also doesn't exist:
          goToBeginning();
        }
      }

      if (scrollCollectionRef != null && partOfScrollGroup) {
        //Check to see if the scrollCollectionRef is in the collection
        // checkIfRefIsInCollection sets the currentRef valuenotifiers if found
        navigateToParagraph = checkIfRefIsInCollection(
            scrollCollectionRef.bookID!,
            scrollCollectionRef.chapter!,
            scrollCollectionRef.verse!);
        print(
            'navigateToParagraph in collection change is $navigateToParagraph');
        if (navigateToParagraph == -1) refNotInCollection();
      } else if (bookID != null && chapter != null && verse != null) {
        //Here there is an incoming full ref
        navigateToParagraph = checkIfRefIsInCollection(bookID, chapter, verse);
        if (navigateToParagraph == -1) {
          refNotInCollection();
        } else {
          currentBook.value = bookID;
          currentChapter.value = chapter;
          currentVerse.value = verse;
        }
      } else {
        //Safety valve - if none of the above, just go to the beginning.
        //could be: not part of scroll group; the scrollCollectionRef is not initialized && no incoming full ref...
        refNotInCollection();
      }

      if (isInitState || navigateToParagraph > versesByParagraph.length) {
        //If going from a short NT only collection to full Bible, at this point the scrollablePositionedList
        //hasn't rebuilt and so a scroll will fail. Set a ref here to scroll in the post frame callback
        delayedScrollIndex = navigateToParagraph;
      } else {
        // print('set ActiveColumnKey1');
        Provider.of<ScrollGroup>(context, listen: false).setActiveColumnKey =
            widget.key;
        // Navigate to the paragraph. This is the collection change section.
        itemScrollController.scrollTo(
          index: navigateToParagraph,
          duration: const Duration(milliseconds: 200),
        );
      }
      // }
      setUpComboBoxesChVs();
    } else {
      //Above is collection change, which resets the whole column.
      //Here is where the choice of book, ch, vs comes, and is a scrollTo with the same collection
      String oldBook = currentBook.value;
      String oldChapter = currentChapter.value;
      String oldVerse = currentVerse.value;

      //Find index of the paragraph that has the desired verse
      //We don't know which the user has navigated to, so sort that out
      //First option comes from scrolling - other options come from DropdownBoxes
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

      int? navigateToParagraph = checkIfRefIsInCollection(
          currentBook.value, currentChapter.value, currentVerse.value);

      //If we found that the ref requested does exist
      if (navigateToParagraph != -1) {
        //If it's the normal situation, we did find the reference, so go there.

        //Filtering for active column scrolling

        if (activeColumnKey == null) {
          print('set ActiveColumnKey2');
          print(activeColumnKey);
          print(widget.key);
          Provider.of<ScrollGroup>(context, listen: false).setActiveColumnKey =
              widget.key;
        }

        //Navigate to the paragraph. This is in the the book/ch/vs section.
        itemScrollController.scrollTo(
          index: navigateToParagraph,
          duration: const Duration(milliseconds: 200),
        );

        BibleReference ref = BibleReference(
            key: widget.bibleReference.key,
            partOfScrollGroup: partOfScrollGroup,
            collectionID: currentCollection.value,
            bookID: currentBook.value,
            chapter: currentChapter.value,
            verse: currentVerse.value,
            columnIndex: widget.myColumnIndex);

        if (partOfScrollGroup) {
          Provider.of<ScrollGroup>(context, listen: false).setScrollGroupRef =
              ref;
        }
        setUpComboBoxesChVs();
      } else {
        //If no result, just hang on, don't scroll, just stay
        currentBook.value = oldBook;
        currentChapter.value = oldChapter;
        currentVerse.value = oldVerse;
      }
    } //end of book/ch/vs else
  }
  // End scroll To Reference

  //On user end scroll notification
  void setSelectorsToClosestReferenceAfterScroll() {
    // print(
    //     'set SelectorsToClosestReferenceAfterScroll called ${widget.bibleReference.collectionID}');
    int p = itemPositionsListener.itemPositions.value.first.index;
    //'first' includes the item that is in first position as it slides out of view, so look for the second item, looks better
    int pPlus1 = p + 1;
    //This if makes it so this only fires when needed
    if (previousParaPosition != pPlus1) {
      // print(
      //     'set SelectorsToClosestReferenceAfterScroll doing something ${widget.bibleReference.collectionID}');
      previousParaPosition = pPlus1;

      List<ParsedLine> para = versesByParagraph[pPlus1];

      breakingloop:
      //This is all verses by paragraph - go through each one starting with the current paragraph - 'p' above
      for (var i = pPlus1; i < versesByParagraph.length; i++) {
        para = versesByParagraph[i];
        if (para.isNotEmpty) {
          //Now in each paragraph start looking to see which verse is the first in the scrolled-to paragraph
          for (var l = 0; l < para.length; l++) {
            //If we're in a sane reference
            if (
                //first test: if the ch number is a number
                (para[l].chapter != "" && para[l].chapter != "0") &&
                    //second test: the verse number is a number
                    (para[l].verse != "" && para[l].verse != "0") &&
                    //third test: if it's a paragraph marker with no text
                    (para[l].verseText != "")) {
              //
              if (currentBook.value != para[l].book) {
                currentBook.value = para[l].book;
              }
              if (currentChapter.value != para[l].chapter) {
                currentChapter.value = para[l].chapter;
              }
              if (currentVerse.value != para[l].verse) {
                // print('verse change to ${para[l].verse}');
                currentVerse.value = para[l].verse;
              }

              BibleReference ref = BibleReference(
                  key: widget.bibleReference.key,
                  partOfScrollGroup: partOfScrollGroup,
                  collectionID: currentCollection.value,
                  bookID: currentBook.value,
                  chapter: currentChapter.value,
                  verse: currentVerse.value,
                  columnIndex: widget.myColumnIndex);

              if (partOfScrollGroup) {
                //communicate to other columns if part of scrollgroup
                Provider.of<ScrollGroup>(context, listen: false)
                    .setScrollGroupRef = ref;
              }

              //reset combobox
              setUpComboBoxesChVs();

              break breakingloop;
            }
          }
        }
      }
    }
  }

  void setUpComboBoxesChVs() {
    // print('setUp ComboBoxesChVs');

    List<String> temp = versesInCollection
        .where((element) => element.book == currentBook.value)
        .map((e) => e.chapter)
        .toList();

    //.toSet().toList() here reduces a big list to unique values
    currentBookChapters = temp.toSet().toList();

    currentChapterVerseNumbers = versesInCollection
        .where((element) =>
            element.book == currentBook.value &&
            element.chapter == currentChapter.value &&
            element.verse != "")
        .map((e) => e.verse)
        .toList();

    setState(() {});

    BibleReference ref = BibleReference(
        key: widget.bibleReference.key,
        partOfScrollGroup: partOfScrollGroup,
        collectionID: currentCollection.value,
        bookID: currentBook.value,
        chapter: currentChapter.value,
        verse: currentVerse.value,
        columnIndex: widget.myColumnIndex);

    Provider.of<UserPrefs>(context, listen: false).saveScrollGroupState(ref);
  }

  void addVerseToCopyRange(ParsedLine ref) {
    //This function fills in the gaps where there is poetry over many ParsedLines to get the whole verse despite the separation
    /*
    Xanaa dungeen bàyyee songandoo nit, 
    nar koo sànk, 
    ni kuy màbb tabax bu joy, 
    mbaa ngay bàddi per mu ràpp?  
      Sabóor 62.4-4 (Kàddug Yàlla)
     */
    addLinesBetweenIndexes() {
      int startIndex = 0;
      int endIndex = 0;

      /*add all between the first and last index. 
      Because the user can select up as well as down (select vs 5 then 1 as well as 1 and then 5)
      Check first which way round we're going */
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
        // endIndex = otherEnd;
        endIndex = versesInCollection.lastIndexWhere((element) =>
            element.book == rangeOfVersesToCopy.last.book &&
            element.chapter == rangeOfVersesToCopy.last.chapter &&
            element.verse == rangeOfVersesToCopy.last.verse);
      } else {
        startIndex = otherEnd;
        endIndex = versesInCollection.lastIndexWhere((element) =>
            element.book == rangeOfVersesToCopy.first.book &&
            element.chapter == rangeOfVersesToCopy.first.chapter &&
            element.verse == rangeOfVersesToCopy.first.verse);
      }
      rangeOfVersesToCopy = [];
      for (var i = startIndex; i <= endIndex; i++) {
        rangeOfVersesToCopy.add(versesInCollection[i]);
      }
    }

    //Start of function
    bool verseAlreadyInRange = rangeOfVersesToCopy.any((ParsedLine element) =>
        element.book == ref.book &&
        element.chapter == ref.chapter &&
        element.verse == ref.verse);

    // if there is only one verse, and the incoming verse is the same as the one that's in there, get rid of it.
    if (rangeOfVersesToCopy.length == 1 && verseAlreadyInRange) {
      rangeOfVersesToCopy = [];
    }
    // if vs not in range, add it and arrange the lines
    else if (!verseAlreadyInRange) {
      // print('third case');
      //add this verse and then
      rangeOfVersesToCopy.add(ref);

      addLinesBetweenIndexes();
    }

    //if only 2 verses, and the one clicked is already in, remove it and any after it
    else if (verseAlreadyInRange) {
      int first = rangeOfVersesToCopy.indexWhere((element) =>
          element.book == ref.book &&
          element.chapter == ref.chapter &&
          element.verse == ref.verse);

      rangeOfVersesToCopy.removeRange(first, rangeOfVersesToCopy.length);
    }
    // if the verses to copy does not contain the ref that the user just sent, add all the refs between the first and last ref
    // This is the 'normal' case, where there is no selection yet

    //if the user has changed their minds and wants to shorten the list of verses to work with
    // else if (rangeOfVersesToCopy.length >= 2 && verseAlreadyInRange) {
    //   // print('fourth option');
    //   // startIndex = versesInCollection.indexWhere((element) =>
    //   //     element.book == rangeOfVersesToCopy[0].book &&
    //   //     element.chapter == rangeOfVersesToCopy[0].chapter &&
    //   //     element.verse == rangeOfVersesToCopy[0].verse);

    //   // endIndex = versesInCollection.indexWhere((element) =>
    //   //     element.book == ref.book &&
    //   //     element.chapter == ref.chapter &&
    //   //     element.verse == ref.verse);
    //   // addVersesBetweenIndexes(startIndex, endIndex);
    // }
    setState(() {});
  }

  String? textToShareOrCopy() {
    // print('textToShareOrCopy');
    String textToReturn = '';
    String reference = '';
    String lineBreak = '\n';

    //Get the text of the verses to share or copy
    if (rangeOfVersesToCopy.isEmpty) {
      return null;
    } else {
      for (var i = 0; i < rangeOfVersesToCopy.length; i++) {
        var temp = verseComposer(
                line: rangeOfVersesToCopy[i],
                includeFootnotes: false,
                context: context)
            .versesAsString;
        textToReturn = '$textToReturn$temp ';
      }

      //Now get the reference for the selection
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

      textToReturn =
          '$textToReturn$lineBreak$reference ($currentCollectionName)';
      rangeOfVersesToCopy = [];
      setState(() {});
      return textToReturn;
    }
  }

  @override
  Widget build(BuildContext context) {
    Key? activeColumnKey = context.read<ScrollGroup>().getActiveColumnKey;
    ScrollGroup scrollGroup = Provider.of<ScrollGroup>(context, listen: false);
    // print(
    //     'scripture column build: columnIndex: ${widget.bibleReference.columnIndex}; collection: ${widget.bibleReference.collectionID}; key: ${widget.key}');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //if switching from an NT only collection with few paragraphs to a longer full Bible collection
      //it will fail if it tries to scroll before the scrollablePositionedList is rebuilt.
      //Set above, this delayedScrollIndex scrolls after build to the index in such a situation
      if (delayedScrollIndex != null) {
        scrollGroup.setActiveColumnKey = widget.key;
        try {
          itemScrollController.jumpTo(index: delayedScrollIndex!);
        } catch (e) {
          print('$e at scripcol postframecallback');
        }

        delayedScrollIndex = null;
      }

      //This is what triggers the scrolling in other columns
      if (!mounted) return;
      BibleReference? scrollGroupRef =
          context.read<ScrollGroup>().getScrollGroupRef;

      if (partOfScrollGroup &&
          scrollGroupRef != null &&
          activeColumnKey != widget.key) {
        if (currentBook.value != scrollGroupRef.bookID ||
            currentChapter.value != scrollGroupRef.chapter ||
            currentVerse.value != scrollGroupRef.verse) {
          scrollToReference(
              bookID: scrollGroupRef.bookID,
              chapter: scrollGroupRef.chapter,
              verse: scrollGroupRef.verse);
        }
      }
    });

    int numberOfColumns =
        Provider.of<UserPrefs>(context, listen: false).userColumns.length;

    double windowWidth = MediaQuery.of(context).size.width;

    if (windowWidth > 1024 && numberOfColumns == 1) {
      wideWindow = true;
      wideWindowPadding = windowWidth / 5;
    } else {
      wideWindow = false;
    }

    //Couple of things to get to pass in to the Paragraph Builder

    Collection thisCollection = collections
        .firstWhere((element) => element.id == currentCollection.value);

    String fontName = thisCollection.fonts.first.fontFamily;

    late ui.TextDirection textDirection;
    late AlignmentGeometry alignment;
    double? comboBoxFontSize = 16;

    if (thisCollection.textDirection == 'LTR') {
      textDirection = ui.TextDirection.ltr;
      alignment = Alignment.centerLeft;
      // comboBoxFontSize = DefaultTextStyle.of(context).style.fontSize;
    } else {
      textDirection = ui.TextDirection.rtl;
      alignment = Alignment.centerRight;
      // comboBoxFontSize = 18;
    }

    //value notifier that triggers update when scrollgroup ref changes
    context.watch<ScrollGroup>().getScrollGroupRef;

    TextOverflow textOverflow = TextOverflow.ellipsis;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //header toolbar/s
        children: [
          //Scripture column ref selection card
          Padding(
            //Each column has 5 above and then 2.5 l and r,
            //which when beside each other makes 5 between each col.
            //Padding in bible view makes the first and last column have the full 5.
            padding: const EdgeInsets.only(top: 5.0, right: 2.5, left: 2.5),
            child: Card(
              //The default card color is good for dark but for white it's basically just white, so to differentiate soften a bit with grey
              backgroundColor: FluentTheme.of(context).brightness ==
                      Brightness.dark
                  ? null
                  : FluentTheme.of(context).cardColor.lerpWith(Colors.grey, .1),
              padding:
                  const EdgeInsets.only(top: 12, bottom: 12, left: 6, right: 6),
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
                                    return ComboBox<String>(
                                      style: DefaultTextStyle.of(context)
                                          .style
                                          .copyWith(
                                              fontFamily: widget.comboBoxFont,
                                              fontSize: comboBoxFontSize),
                                      isExpanded: true,
                                      items: widget.appInfo.collections
                                          .map((e) => ComboBoxItem<String>(
                                                value: e.id,
                                                child: Align(
                                                  alignment: alignment,
                                                  child: Text(
                                                    e.name,
                                                    overflow: textOverflow,
                                                    textDirection:
                                                        textDirection,
                                                  ),
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
                              width: 175,
                              child: ValueListenableBuilder<String>(
                                  valueListenable: currentBook,
                                  builder: (context, val, child) {
                                    return ComboBox<String>(
                                      style: DefaultTextStyle.of(context)
                                          .style
                                          .copyWith(
                                              fontFamily: widget.comboBoxFont,
                                              fontSize: comboBoxFontSize),
                                      isExpanded: true,
                                      items: currentCollectionBooks.map((e) {
                                        late String name;
                                        if (e.name.contains('Προσ')) {
                                          name = e.name.substring(5);
                                        } else {
                                          name = e.name;
                                        }

                                        return ComboBoxItem<String>(
                                          value: e.id,
                                          child: Align(
                                            alignment: alignment,
                                            child: Text(
                                              name,
                                              overflow: textOverflow,
                                              textDirection: textDirection,
                                            ),
                                          ),
                                        );
                                      }).toList(),
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
                                width: 80,
                                child: ValueListenableBuilder<String>(
                                    valueListenable: currentChapter,
                                    builder: (context, val, child) {
                                      return ComboBox<String>(
                                        style: DefaultTextStyle.of(context)
                                            .style
                                            .copyWith(
                                                fontFamily: widget.comboBoxFont,
                                                fontSize: comboBoxFontSize),
                                        isExpanded: true,
                                        items: currentBookChapters
                                            .map((e) => ComboBoxItem<String>(
                                                  value: e,
                                                  child: Text(
                                                    e,
                                                    overflow: textOverflow,
                                                  ),
                                                ))
                                            .toList(),
                                        value: val,
                                        onChanged: (value) {
                                          scrollToReference(chapter: value);
                                        },
                                      );
                                    }),
                              ),
                              const SizedBox(
                                width: 5,
                              ),

                              // //verse
                              SizedBox(
                                width: 80,
                                child: ValueListenableBuilder<String>(
                                    valueListenable: currentVerse,
                                    builder: (context, val, child) {
                                      return ComboBox<String>(
                                        style: DefaultTextStyle.of(context)
                                            .style
                                            .copyWith(
                                                fontFamily: widget.comboBoxFont,
                                                fontSize: comboBoxFontSize),
                                        placeholder: const Text('150'),
                                        isExpanded: true,
                                        items: currentChapterVerseNumbers
                                            .toSet()
                                            .toList()
                                            .map((e) => ComboBoxItem<String>(
                                                  value: e,
                                                  child: Text(
                                                    e,
                                                    overflow: textOverflow,
                                                  ),
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
                                    if (baseFontSize < 50) {
                                      setState(() {
                                        baseFontSize = baseFontSize + 1;
                                      });
                                    }
                                  },
                                  child: const Icon(FluentIcons.font_increase),
                                ),
                                const SizedBox(width: 5),
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
                                const SizedBox(
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
                  if (widget.myColumnIndex == 0)
                    const SizedBox(
                      width: 30,
                    )
                ],
              ),
            ),
          ),
          // End of scripture column toolbar

          // The scripture container
          Expanded(
            child: NotificationListener(
              onNotification: (ScrollNotification notification) {
                // print(
                //     '$notification   |   ${widget.bibleReference.collectionID}');

                //We're only interested in scrollnotifications
                if (notification is ScrollEndNotification) {
                  //Get a reference to this activeColumnKey
                  Key? activeColumnKey =
                      context.read<ScrollGroup>().getActiveColumnKey;
                  //Below if it's this column that is controlling the scroll we store that for about 2 seconds.
                  //check if this is the active column. If so, or if no active column, initiate simulscrolling
                  //through the valuelistenable.

                  if (activeColumnKey == null) {
                    Provider.of<ScrollGroup>(context, listen: false)
                            .setActiveColumnKey =
                        widget
                            .key; //We're scrolling, so set this column's key as the active column - resets 2 seconds later
                    // print(
                    //     'setting active column in scripcol ${widget.bibleReference.collectionID}');
                    // print(activeColumnKey);
                    // print(widget.key);

                    Timer(const Duration(milliseconds: 100),
                        setSelectorsToClosestReferenceAfterScroll);
                  }
                }

                //Old working version
                // if (notification is UserScrollNotification &&
                //     notification.direction == ScrollDirection.idle) {
                //   Timer(Duration(milliseconds: 200),
                //       setSelectorsToClosestReferenceAfterScroll);
                // }
                return true;
              },
              child: Padding(
                padding: wideWindow
                    ? EdgeInsets.only(
                        left: wideWindowPadding,
                        right: wideWindowPadding,
                        top: 0,
                        bottom: 0)
                    : const EdgeInsets.only(
                        left: 2.5, right: 2.5, top: 0, bottom: 0),
                child: Container(
                  decoration: const BoxDecoration(
                    //This is the border between each scripture column and its neighbor to the right
                    border: Border(
                      right: BorderSide(
                        width: 1.0,
                        color: Color.fromARGB(85, 126, 126, 126),
                      ),
                    ),
                  ),
                  child: ContextMenuRegion(
                    contextMenu: GenericContextMenu(
                      buttonConfigs: [
                        ContextMenuButtonConfig(
                          Provider.of<UserPrefs>(context, listen: false)
                              .currentTranslation
                              .copy,
                          icon: const Icon(FluentIcons.copy),
                          onPressed: () {
                            String? text = textToShareOrCopy();

                            if (text != null) {
                              Clipboard.setData(ClipboardData(text: text));
                            }
                          },
                        ),
                        ContextMenuButtonConfig(
                          Provider.of<UserPrefs>(context, listen: false)
                              .currentTranslation
                              .share,
                          icon: const Icon(FluentIcons.share),
                          onPressed: () async {
                            String? text = textToShareOrCopy();

                            if (text != null) {
                              //if it's not the web app, share using the device share function

                              if (!kIsWeb) {
                                Share.share(text);
                              } else {
                                //If it's the web app version best way to share is probably email, so put the text to share in an email
                                final String url =
                                    "mailto:?subject=&body=$text";

                                if (await canLaunchUrl(Uri.parse(url))) {
                                  await launchUrl(Uri.parse(url));
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }
                            }
                          },
                        )
                      ],
                    ),
                    child: scrollablePositionedList =
                        ScrollablePositionedList.builder(
                            //this is the space between the right of the column and the text for the scrollbar
                            padding: const EdgeInsets.only(right: 10),
                            initialAlignment: 1,
                            itemScrollController: itemScrollController,
                            itemPositionsListener: itemPositionsListener,
                            itemCount: versesByParagraph.length,
                            shrinkWrap: false,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (ctx, i) {
                              return ParagraphBuilder(
                                paragraph: versesByParagraph[i],
                                fontSize: baseFontSize,
                                fontName: fontName,
                                textDirection: textDirection,
                                rangeOfVersesToCopy: rangeOfVersesToCopy,
                                addVerseToCopyRange: addVerseToCopyRange,
                              );
                            }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
