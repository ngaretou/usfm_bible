// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

// import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:xml/xml.dart';

class Font {
  final String fontFamily;
  final String fontName;
  final String displayName;
  final String filename;
  final String weight;
  final String style;

  Font({
    required this.fontFamily,
    required this.fontName,
    required this.displayName,
    required this.filename,
    required this.weight,
    required this.style,
  });
}

class Book {
  final String id;
  final String name;
  final String filename;
  final String source;

  Book({
    required this.id,
    required this.name,
    required this.filename,
    required this.source,
  });
}

class Collection {
  final String id;
  final String name;
  final String abbreviation;
  final List<Book> books;
  final List<Font> fonts;
  final String textDirection;

  Collection({
    required this.id,
    required this.name,
    required this.abbreviation,
    required this.fonts,
    required this.books,
    required this.textDirection,
  });
}

class ParsedLine {
  // late int id;
  late String collectionid;
  late String book;
  late String chapter;
  late String verse;
  late String verseFragment;
  late String audioMarker;
  late String verseText;
  late String verseStyle;
  // late bool newParagraph;

  ParsedLine({
    // required this.id,
    required this.collectionid,
    required this.book,
    required this.chapter,
    required this.verse,
    required this.verseFragment,
    required this.audioMarker,
    required this.verseText,
    required this.verseStyle,
    // required this.newParagraph,
  });
}

class AppInfo {
  List<Collection> collections;
  List<ParsedLine> verses;

  AppInfo({
    required this.collections,
    required this.verses,
  });
}

List<Collection> collections = [];
List<ParsedLine> verses = [];
List<Font> allFonts = [];

Future<String> asyncGetProjectName(BuildContext context) async {
  AssetBundle assetBundle = DefaultAssetBundle.of(context);

  //get the appDef xml from outside the flutter project
  String appDefLocation = 'assets/project/appDef.appDef';
  String xmlFileString = await assetBundle.loadString(appDefLocation);
  //get the document into a usable iterable
  final document = XmlDocument.parse(xmlFileString);
  //This is the overall app name
  final projectName = document
      .getElement('app-definition')!
      .getElement('app-name')!
      .innerText
      .toString(); // e.g. Kaddug Yalla Gi
  return projectName;
}

Future<AppInfo> buildDatabaseFromXML(BuildContext context) async {
  AssetBundle assetBundle = DefaultAssetBundle.of(context);
  //
  String appDefLocation = 'assets/project/appDef.appDef';
  String xmlFileString = await assetBundle.loadString(appDefLocation);
  //get the document into a usable iterable
  final document = XmlDocument.parse(xmlFileString);

  //Get the font information

  String fontWeight = "";
  String fontStyle = "";

  // var xmlFontsSection = document.findElements('fonts');
  var xmlFontsSection =
      document.getElement('app-definition')!.getElement('fonts');
  if (xmlFontsSection != null) {
    Iterable<XmlElement> xmlFonts = xmlFontsSection.findAllElements('font');
    //Loop through fonts gathering info about each
    for (var xmlFont in xmlFonts) {
      Iterable<XmlElement> xmlFontProperties =
          xmlFont.findAllElements('style-decl');

      for (var xmlFontProperty in xmlFontProperties) {
        //the font weight and style are a bit different, they are in the same kind of xml tag,
        //so we have to get them both out here and save them for the add to list
        String property = xmlFontProperty.getAttribute('property').toString();
        String value = xmlFontProperty.getAttribute('value').toString();
        if (property == 'font-weight') fontWeight = value;
        if (property == 'font-style') fontStyle = value;
      }

      allFonts.add(Font(
          fontFamily: xmlFont.getAttribute('family').toString(),
          fontName: xmlFont.getElement('font-name')!.innerText.toString(),
          displayName: xmlFont.getElement('font-name')!.innerText.toString(),
          filename: xmlFont.getElement('filename')!.innerText.toString(),
          weight: fontWeight,
          style: fontStyle));
    }
  }

  //Get each collection's information
  final Iterable<XmlElement> xmlCollections = document.findAllElements('books');
  for (var xmlCollection in xmlCollections) {
    //holder for the Book list
    List<Book> books = [];

    //now get the collection's book information
    Iterable<XmlElement> xmlBookList = xmlCollection.findAllElements('book');
    for (var xmlBook in xmlBookList) {
      //Add the book
      books.add(Book(
        id: xmlBook.getAttribute('id').toString(),
        name: xmlBook.getElement('name')!.innerText.toString(),
        filename: xmlBook.getElement('filename')!.innerText.toString(),
        source: xmlBook.getElement('source')!.innerText.toString(),
      ));
    }

    //Now put it all together
    collections.add(Collection(
        id: xmlCollection.getAttribute('id').toString(),
        name: xmlCollection
            .getElement('book-collection-name')!
            .innerText
            .toString(),
        abbreviation: xmlCollection
            .getElement('book-collection-abbrev')!
            .innerText
            .toString(),
        fonts: allFonts
            .where((element) =>
                element.fontFamily ==
                xmlCollection
                    .getElement('styles-info')!
                    .getElement('text-font')!
                    .getAttribute('family'))
            .toList(),
        books: books,
        textDirection: xmlCollection
            .getElement('styles-info')!
            .getElement('text-direction')!
            .getAttribute('value')
            .toString()));
  }

  //Now we know about the collections and can populate the content.

  for (var collection in collections) {
    List<Book> books = collection.books;
    for (var book in books) {
      String url =
          'assets/project/data/books/${collection.id}/${book.filename}';
      String chapterText = await assetBundle.loadString(url);
      List<String> chapters = chapterText.split(r"\c ");
      //Removes all the headers etc - this also removes files that have not content - something to look at later
      chapters.removeAt(0);
      for (var chapter in chapters) {
        RegExpMatch? match = RegExp(r'(^\d+)(\s)').firstMatch(chapter);
        //ˆ: beginning of line; \d digit, + 1 or more; \s whitespace
        String? chapterNumber = match?.group(1);

        //split chapter on line break
        List<String> chapterByLineBreaks = chapter.split('\n');

        ///\r?\n|\r/g is all linebreaks
        //This juts gets rid of the chapter number
        chapterByLineBreaks.removeAt(0);

        //Set up variables for the chapters - having them here resets them each new chapter also
        String verseStyle = "";
        String verseNumber = "";
        String verseText = "";

        for (var line in chapterByLineBreaks) {
          // https://medium.com/flutter-community/extracting-text-from-a-string-with-regex-groups-in-dart-b6be604c8a69
          // This regex matches the initial style -
          //match is an iterable with an element for each matching group of the regexp
          RegExpMatch? match =
              RegExp(r'(\\)(\w+)(\s)(.*)').firstMatch(line); // \s asdfaf
          if (match != null) {
            if (match.group(2) != null) verseStyle = match.group(2)!;
            if (match.group(4) != null) {
              verseText = match.group(
                  4)!; //?? = if_null operator: https://dart-lang.github.io/linter/lints/prefer_if_null_operators.html

            }

            //New Paragraph section

            //verse checking
            if (verseStyle == 'v') {
              RegExpMatch? match = RegExp(r'(\d+)(\s)(.*)').firstMatch(
                  verseText); //\d+ = digits, \s whitespace ,.* anything
              if (match != null) {
                if (match.group(1) != null) verseNumber = match.group(1)!;
                if (match.group(3) != null) verseText = match.group(3)!;
              }
            } else {
              verseNumber = "";
            }

            //TODO: final verseText string cleanup

            //Now finally add the elements to the List<ParsedVerse>
            verses.add(ParsedLine(
                collectionid: collection.id,
                book: book.id,
                chapter: chapterNumber!,
                verse: verseNumber,
                verseFragment: "",
                audioMarker: "",
                verseText: verseText,
                verseStyle: verseStyle));
          }
        }
      }
      print('ending current book ${book.name}');
    }
    print('ending current collection ${collection.id}');
  }

  AppInfo appInfo = AppInfo(collections: collections, verses: verses);
  return appInfo;
}
