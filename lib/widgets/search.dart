// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:provider/provider.dart';

import '../models/database_builder.dart';
import '../models/verse_composer.dart';
import '../providers/user_prefs.dart';
import '../providers/column_manager.dart';

class SearchWidget extends StatefulWidget {
  final Function closeSearch;

  const SearchWidget({Key? key, required this.closeSearch}) : super(key: key);

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

    results = verses
        .where((element) =>
            collectionsToSearch.any((id) => id == element.collectionid) &&
            element.verseText.contains(searchRequest) &&
            element.verseStyle == 'v')
        .toList();

    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        content: Text(
          collections[i].name,
        ),
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
                                          listen: true)
                                      .currentTranslation
                                      .search,
                                  placeholderStyle: DefaultTextStyle.of(context)
                                      .style
                                      .copyWith(
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
                                  Provider.of<UserPrefs>(context, listen: true)
                                      .currentTranslation
                                      .search),
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
                        itemBuilder: (ctx, i) =>
                            SearchResultTile(line: searchResults[i])),
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

    TextStyle computedTextStyle = TextStyle(
      fontFamily: 'font1',
      fontSize: 14,
      color: DefaultTextStyle.of(context).style.color,
    );

    List<InlineSpan> styledParagraphFragments = verseComposer(
            line: widget.line,
            computedTextStyle: computedTextStyle,
            includeFootnotes: false,
            context: context)
        .versesAsSpans;

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
                verse: widget.line.verse);

            Provider.of<ColumnManager>(context, listen: false)
                .setScrollGroupRef = ref;
          },
          child: Card(
            // elevation: 1,
            backgroundColor: cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: styledParagraphFragments,
                  ),
                ),
                // Text(
                //   widget.line.verseText,
                //   style: DefaultTextStyle.of(context)
                //       .style
                //       .copyWith(fontFamily: 'font1'),
                // ),
                const SizedBox(height: 10),
                Wrap(children: [
                  Text(
                    '$bookName ${widget.line.chapter}.${widget.line.verse}  |  ',
                    style: DefaultTextStyle.of(context).style.copyWith(
                        fontFamily: 'font1', fontStyle: FontStyle.italic),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentCollectionName,
                        style: DefaultTextStyle.of(context).style.copyWith(
                            fontFamily: 'font1', fontStyle: FontStyle.italic),
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
