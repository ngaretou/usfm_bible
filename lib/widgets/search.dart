// ignore_for_file: sized_box_for_whitespace, avoid_print
import 'dart:ui' as ui;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:provider/provider.dart';
import 'package:diacritic/diacritic.dart';

import '../logic/database_builder.dart';
import '../logic/verse_composer.dart';
import '../providers/user_prefs.dart';
import '../providers/column_manager.dart';

class SearchWidget extends StatefulWidget {
  final Function closeSearch;
  final String? comboBoxFont;

  const SearchWidget(
      {Key? key, required this.closeSearch, required this.comboBoxFont})
      : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final searchController = TextEditingController();
  final expanderKey = GlobalKey<ExpanderState>();

  List<String> collectionsToSearch = [];
  List<Checkbox> checkBoxes = [];
  List<ParsedLine> searchResults = [];

  @override
  void initState() {
    collectionsToSearch =
        List.generate(collections.length, (i) => collections[i].id);

    searchController.addListener(() {
      if (searchController.text.length == 1 && mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchFunction(String searchRequest) {
    List<ParsedLine> results = [];

    String normalizedSearchRequest = removeDiacritics(searchRequest);
    //strict search
    // results = verses
    //     .where((element) =>
    //         collectionsToSearch.any((id) => id == element.collectionid) &&
    //         element.verseText.contains(searchRequest) &&
    //         element.verseStyle == 'v')
    //     .toList();

    //fuzzy search
    results = verses
        .where((element) =>
            collectionsToSearch.any((id) => id == element.collectionid) &&
            removeDiacritics(element.verseText)
                .contains(normalizedSearchRequest) &&
            element.verseStyle == 'v')
        .toList();

    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle searchControlsStyle = DefaultTextStyle.of(context).style.copyWith(
          fontFamily: widget.comboBoxFont,
          fontSize: 16,
        );

    checkBoxes = List.generate(collections.length, (i) {
      return Checkbox(
        checked: collectionsToSearch.contains(collections[i].id),
        onChanged: (bool? value) {
          setState(() {
            // print('setting ${collectionsToSearch[i]} to $value');
            if (collectionsToSearch.contains(collections[i].id)) {
              collectionsToSearch
                  .removeWhere((element) => element == collections[i].id);
            } else {
              collectionsToSearch.add(collections[i].id);
            }
          });
        },
        content: Text(collections[i].name, style: searchControlsStyle),
      );
    });

    return Container(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Search tool card
            Padding(
              padding:
                  const EdgeInsets.only(top: 5.0, right: 5, left: 5, bottom: 5),
              child: Card(
                backgroundColor:
                    FluentTheme.of(context).brightness == Brightness.dark
                        ? null
                        : FluentTheme.of(context)
                            .cardColor
                            .lerpWith(Colors.grey, .1),
                padding: const EdgeInsets.only(
                    top: 12, bottom: 12, left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            // direction: Axis.horizontal,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            // alignment: WrapAlignment.start,
                            // spacing: 5,
                            // runSpacing: 8,
                            children: [
                              Expanded(
                                child: TextFormBox(
                                  style: searchControlsStyle,
                                  onEditingComplete: () => searchFunction(
                                      searchController.value.text),
                                  maxLines: 1,
                                  controller: searchController,
                                  suffixMode: OverlayVisibilityMode.always,
                                  expands: false,
                                  suffix: searchController.text.isEmpty
                                      ? null
                                      : IconButton(
                                          icon: const Icon(
                                              material.Icons.backspace),
                                          onPressed: () {
                                            searchController.clear();
                                          },
                                        ),
                                  placeholder: Provider.of<UserPrefs>(context,
                                          listen: false)
                                      .currentTranslation
                                      .search,
                                  placeholderStyle:
                                      searchControlsStyle.copyWith(
                                          color: DefaultTextStyle.of(context)
                                              .style
                                              .color!
                                              .withOpacity(.4)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Expander(
                            key: expanderKey,
                            //change the default icon here from down/up arrow:
                            // icon: Icon(FluentIcons.settings),
                            leading: Button(
                              child: Text(
                                  Provider.of<UserPrefs>(context, listen: false)
                                      .currentTranslation
                                      .search,
                                  style: searchControlsStyle),
                              onPressed: () =>
                                  searchFunction(searchController.value.text),
                            ),
                            header: const Text(''),
                            // headerHeight: 15,

                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: checkBoxes,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.closeSearch();
                      },
                      icon: const Icon(FluentIcons.calculator_multiply),
                    ),
                  ],
                ),
              ),
            ),
            searchResults.isEmpty
                ? const SizedBox(
                    height: 200,
                    child: Center(child: Icon(FluentIcons.search, size: 40)))
                : Flexible(
                    child: ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (ctx, i) => SearchResultTile(
                              line: searchResults[i],
                            )),
                  ),
          ],
        ));
  }
}

class SearchResultTile extends StatefulWidget {
  final ParsedLine line;

  const SearchResultTile({Key? key, required this.line}) : super(key: key);

  @override
  State<SearchResultTile> createState() => _SearchResultTileState();
}

class _SearchResultTileState extends State<SearchResultTile> {
  Color? cardColor;

  void searchNavigator(ParsedLine line) {
    print(line.verseText);
  }

  @override
  Widget build(BuildContext context) {
    String currentCollectionName = collections
        .where((element) => element.id == widget.line.collectionid)
        .first
        .name;

    List<Book> currentCollectionBooks = collections
        .where((element) => element.id == widget.line.collectionid)
        .toList()[0]
        .books;

    String bookName = currentCollectionBooks
        .where((element) => element.id == widget.line.book)
        .first
        .name;

    Collection thisCollection = collections
        .firstWhere((element) => element.id == widget.line.collectionid);

    String resultsFont = thisCollection.fonts.first.fontFamily;

    TextStyle computedTextStyle = TextStyle(
      fontFamily: resultsFont,
      fontSize: 20,
      color: DefaultTextStyle.of(context).style.color,
    );

    late ui.TextDirection textDirection;
    // late AlignmentGeometry alignment;
    late TextAlign textAlign;

    if (thisCollection.textDirection == 'LTR') {
      textDirection = ui.TextDirection.ltr;
      textAlign = TextAlign.left;
      // alignment = Alignment.centerLeft;
      // comboBoxFontSize = DefaultTextStyle.of(context).style.fontSize;
    } else {
      textDirection = ui.TextDirection.rtl;
      textAlign = TextAlign.right;
      // alignment = Alignment.centerRight;
      // comboBoxFontSize = 18;
    }

    List<InlineSpan> styledParagraphFragments = verseComposer(
            line: widget.line,
            computedTextStyle: computedTextStyle,
            includeFootnotes: false,
            context: context)
        .versesAsSpans;

    String chVsSeparator =
        textDirection == ui.TextDirection.rtl ? '\u{200F}.' : '.';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            cardColor = FluentTheme.of(context)
                .cardColor
                .lerpWith(FluentTheme.of(context).accentColor, .3);
          });
        },
        onExit: (event) {
          setState(() {
            cardColor = null;
          });
        },
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            BibleReference ref = BibleReference(
                key: UniqueKey(),
                partOfScrollGroup: true,
                collectionID: widget.line.collectionid,
                bookID: widget.line.book,
                chapter: widget.line.chapter,
                verse: widget.line.verse,
                columnIndex:
                    1); //This is dummy data as we dont care about the columnIndex here, just the ref

            Provider.of<ScrollGroup>(context, listen: false).setScrollGroupRef =
                ref;
          },
          child: Card(
            // elevation: 1,
            backgroundColor: cardColor,
            child: Column(
              crossAxisAlignment: textAlign == TextAlign.left
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    children: styledParagraphFragments,
                  ),
                  textAlign: textAlign,
                ),
                // Text(
                //   widget.line.verseText,
                //   style: DefaultTextStyle.of(context)
                //       .style
                //       .copyWith(fontFamily: 'font1'),
                // ),
                const SizedBox(height: 10),
                const Divider(),
                Wrap(
                    // crossAxisAlignment: WrapCrossAlignment.end,
                    textDirection: textDirection,
                    children: [
                      Text(
                        '$bookName ${widget.line.chapter}$chVsSeparator${widget.line.verse}  |  ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                            fontFamily: resultsFont,
                            fontStyle: FontStyle.italic),
                        textDirection: textDirection,
                        textAlign: textAlign,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            currentCollectionName,
                            style: DefaultTextStyle.of(context).style.copyWith(
                                fontFamily: resultsFont,
                                fontStyle: FontStyle.italic),
                            textDirection: textDirection,
                            textAlign: textAlign,
                          ),
                        ],
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
