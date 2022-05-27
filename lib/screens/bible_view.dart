// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fluent_ui/fluent_ui.dart';
import '../models/database_builder.dart';

class BibleView extends StatefulWidget {
  final bool? addPane;

  const BibleView({Key? key, this.addPane}) : super(key: key);

  @override
  State<BibleView> createState() => _BibleViewState();
}

class _BibleViewState extends State<BibleView> {
  int currentIndex = 0;
  late List<Tab> tabs;
  late Future<List<ParsedVerse>> init;
  int numberOfColumns = 3;

  ScrollController scrollController1 = ScrollController();
  ScrollController scrollController2 = ScrollController();
  ScrollController scrollController3 = ScrollController();
  ScrollController scrollController4 = ScrollController();
  List<ScrollController> scrollControllers = [];

  @override
  void initState() {
    init = callInititalization();
    scrollControllers = [
      scrollController1,
      scrollController2,
      scrollController3,
      scrollController4,
    ];
    // tabs = List.generate(3, (index) {
    //   late Tab tab;
    //   tab = Tab(
    //     text: Text('Document $index'),
    //     onClosed: () {
    //       _handleTabClosed(tab);
    //     },
    //   );
    //   return tab;
    // });
    super.initState();
  }

  Future<List<ParsedVerse>> callInititalization() async {
    var response = await buildDatabaseFromXML(context);
    print('returning future from initialization');
    return response;
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
    if (widget.addPane != null && widget.addPane!) changeNumberColumns(true);
    //Main row that holds the text columns
    return Row(
      children: List.generate(
        numberOfColumns,
        (index) => Expanded(
          child: Center(
              child: FutureBuilder(
                  future: init,
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Center(child: ProgressRing())
                          : ParagraphBuilder(
                              myColumnIndex: index,
                              numberOfColumns: numberOfColumns,
                              verses: snapshot.data as List<ParsedVerse>,
                              scrollController: scrollControllers[index],
                              changeNumberColumns: changeNumberColumns,
                            ))),
        ),
      ),
    );
  }
}

class ParagraphBuilder extends StatefulWidget {
  final int myColumnIndex;
  final int numberOfColumns;
  final List<ParsedVerse> verses;
  final ScrollController scrollController;
  final Function(bool) changeNumberColumns;

  const ParagraphBuilder(
      {Key? key,
      required this.myColumnIndex,
      required this.numberOfColumns,
      required this.verses,
      required this.scrollController,
      required this.changeNumberColumns})
      : super(key: key);

  @override
  State<ParagraphBuilder> createState() => _ParagraphBuilderState();
}

class _ParagraphBuilderState extends State<ParagraphBuilder> {
  late bool partOfScrollGroup;
  static const values = <String>[
    'Red',
    'Yellow',
    'Green',
    'Cyan',
    'Blue',
    'Magenta',
    'Orange',
    'Violet',
    'Pink',
    'Brown',
    'Purple',
    'Gray',
    'Black',
    'White',
  ];
  static const tempVerseNumbers = <String>[
    '1',
    '2',
    '3',
  ];
  String? comboBoxValue;

  @override
  void initState() {
    partOfScrollGroup = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //receive list of verses

    List<ParsedVerse> versesToShow = widget.verses
        .where((element) => element.collectionid == "C01")
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      //header toolbar/s
      children: [
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
                Combobox<String>(
                  placeholder: const Text('Clctn'),
                  isExpanded: false,
                  items: values
                      .map((e) => ComboboxItem<String>(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  value: comboBoxValue,
                  onChanged: (value) {
                    print(value);
                    if (value != null) {
                      setState(() => comboBoxValue = value);
                    }
                  },
                ),
                // Book
                Combobox<String>(
                  placeholder: const Text('Book'),
                  isExpanded: false,
                  items: values
                      .map((e) => ComboboxItem<String>(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  value: comboBoxValue,
                  onChanged: (value) {
                    print(value);
                    if (value != null) {
                      setState(() => comboBoxValue = value);
                    }
                  },
                ),
                //chapter
                Combobox<String>(
                  placeholder: const Text('C'),
                  isExpanded: false,
                  items: tempVerseNumbers
                      .map((e) => ComboboxItem<String>(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  value: '2',
                  onChanged: (value) {
                    print(value);
                    if (value != null) {
                      setState(() => comboBoxValue = value);
                    }
                  },
                ),
                //verse
                Combobox<String>(
                  placeholder: const Text('V'),
                  isExpanded: false,
                  items: tempVerseNumbers
                      .map((e) => ComboboxItem<String>(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  value: '2',
                  onChanged: (value) {
                    print(value);
                    if (value != null) {
                      setState(() => comboBoxValue = value);
                    }
                  },
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
                    ), //null makes //null
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

        //The scripture container
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12, top: 12, bottom: 0),
            child: ListView.builder(
                controller: widget.scrollController,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (ctx, i) {
                  return ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: true),
                      child: Text(versesToShow[i].verseText));
                }
                // itemCount: ,

                ),
          ),
        ),
      ],
    );
  }
}

// TABVIEW SKELETON
// @override
// Widget build(BuildContext context) {
//   return TabView(
//     currentIndex: currentIndex,
//     onChanged: _handleTabChanged,
//     tabWidthBehavior: TabWidthBehavior.sizeToContent,
//     onReorder: (oldIndex, newIndex) {
//       setState(() {
//         if (oldIndex < newIndex) {
//           newIndex -= 1;
//         }
//         final Tab item = tabs.removeAt(oldIndex);
//         tabs.insert(newIndex, item);
//         if (currentIndex == newIndex) {
//           currentIndex = oldIndex;
//         } else if (currentIndex == oldIndex) {
//           currentIndex = newIndex;
//         }
//       });
//     },
//     onNewPressed: () {
//       setState(() {
//         late Tab tab;
//         tab = Tab(
//           text: Text('Document ${tabs.length}'),
//           onClosed: () {
//             _handleTabClosed(tab);
//           },
//         );
//         tabs.add(tab);
//       });
//     },
//     tabs: tabs,
//     bodies: List.generate(tabs.length,
//         (index) => const Center(child: SelectableText('BibleView'))),
//   );
// }

// void _handleTabChanged(int index) {
//   setState(() => currentIndex = index);
// }

// void _handleTabClosed(Tab tab) {
//   setState(() {
//     tabs.remove(tab);
//     if (currentIndex > tabs.length - 1) currentIndex--;
//   });
// }
