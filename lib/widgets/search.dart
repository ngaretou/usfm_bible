// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

import '../models/database_builder.dart';

class SearchWidget extends StatefulWidget {
  final Function closeSearch;

  const SearchWidget({Key? key, required this.closeSearch}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final searchController = TextEditingController();
  List<bool> collectionsToSearch = [];
  List<Checkbox> checkBoxes = [];

  @override
  void initState() {
    collectionsToSearch = List.generate(collections.length, (i) => true);

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

  @override
  Widget build(BuildContext context) {
    checkBoxes = List.generate(collections.length, (i) {
      return Checkbox(
        checked: collectionsToSearch[i],
        onChanged: (bool? value) {
          setState(() {
            print('setting ${collectionsToSearch[i]} to $value');
            collectionsToSearch[i] = value!;
          });
        },
        content: Text(
          collections[i].name,
          // style: TextStyle(
          //   color: FluentTheme.of(context).inactiveColor),
        ),
      );
    });

    return Container(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          //header toolbar/s
          children: [
            //Scripture column toolbar
            Padding(
              padding: const EdgeInsets.only(top: 5.0, right: 5, left: 5),
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
                          Wrap(
                            spacing: 5,
                            runSpacing: 8,
                            children: [
                              TextFormBox(
                                maxLines: null,
                                controller: searchController,
                                suffixMode: OverlayVisibilityMode.always,
                                expands: true,
                                suffix: searchController.text.isEmpty
                                    ? null
                                    : IconButton(
                                        icon: const Icon(
                                            material.Icons.backspace),
                                        onPressed: () {
                                          searchController.clear();
                                        },
                                      ),
                                placeholder: 'Text box with clear button',
                              ),
                            ],
                          ),
                          Wrap(spacing: 5, runSpacing: 8, children: checkBoxes),
                          Button(
                            child: const Text('Search'),
                            onPressed: () {
                              print('searching');
                            },
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
          ],
        ));
  }
}
