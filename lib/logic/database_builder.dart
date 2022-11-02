// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usfm_bible/hive/parsed_lines_db.dart';
import 'package:usfm_bible/providers/user_prefs.dart';
import 'package:xml/xml.dart';
import 'package:flutter/services.dart' show rootBundle;
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

class Translation {
  String langCode;
  String langName;
  String search;
  String addColumn;
  String settingsTheme;
  String systemTheme;
  String lightTheme;
  String darkTheme;
  String about;
  String settings;
  String settingsInterfaceLanguage;
  String copy;
  String share;

  Translation(
      {required this.langCode,
      required this.langName,
      required this.search,
      required this.addColumn,
      required this.settingsTheme,
      required this.systemTheme,
      required this.lightTheme,
      required this.darkTheme,
      required this.about,
      required this.settings,
      required this.settingsInterfaceLanguage,
      required this.copy,
      required this.share});
}

List<Collection> collections = [];
List<ParsedLine> verses = [];
List<Font> allFonts = [];
List<Translation> translations = [];

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

Future<void> asyncGetTranslations(BuildContext context) async {
  //Stuff for supplemental translations
  Map<String, String> translationSupplement = {};
  String translationsJSON =
      await rootBundle.loadString("assets/translations.json");
  final translationData = json.decode(translationsJSON) as List<dynamic>;

  AssetBundle assetBundle = DefaultAssetBundle.of(context);

  //get the appDef xml from outside the flutter project
  String appDefLocation = 'assets/project/appDef.appDef';
  String xmlFileString = await assetBundle.loadString(appDefLocation);
  //get the document into a usable iterable
  final document = XmlDocument.parse(xmlFileString);

  String initialLang = document
      .getElement('app-definition')!
      .getElement('translation-mappings')!
      .getAttribute('default-lang')
      .toString(); // e.g. 'en'

  Iterable<XmlElement> xmlLangs = document
      .getElement('app-definition')!
      .getElement('interface-languages')!
      .getElement('writing-systems')!
      .findAllElements('writing-system');
  //Loop through langs gathering info about each
  for (var lang in xmlLangs) {
    String? enabled = lang.getAttribute('enabled')?.toString();

    if (enabled != 'false') {
      String langCode = lang.getAttribute('code').toString();
      late String langName;
      XmlElement? displayNames = lang.getElement('display-names');
      Iterable<XmlElement> langForms = displayNames!.findAllElements('form');

      Map<String, String> langInfo = {};
      for (var langForm in langForms) {
        langInfo.addAll(
            {langForm.getAttribute('lang').toString(): langForm.innerText});
      }
      if (langInfo.keys.contains(langCode)) {
        langName = langInfo[langCode].toString();
      } else {
        langName = langInfo['en'].toString();
      }

      Iterable<XmlElement> searchTextXML = document
          .getElement('app-definition')!
          .getElement('translation-mappings')!
          .findAllElements('translation-mapping')
          .where((element) => element.getAttribute('id') == 'Search')
          .first
          .findAllElements('translation')
          .toList()
          .where(
              (element) => element.getAttribute('lang').toString() == langCode);
      String searchText = searchTextXML.first.innerText;

      Iterable<XmlElement> settingsTextXml = document
          .getElement('app-definition')!
          .getElement('translation-mappings')!
          .findAllElements('translation-mapping')
          .where((element) => element.getAttribute('id') == 'Settings_Title')
          .first
          .findAllElements('translation')
          .toList()
          .where(
              (element) => element.getAttribute('lang').toString() == langCode);
      String settingsText = settingsTextXml.first.innerText;

      Iterable<XmlElement> settingsInterfaceLanguageTextXml = document
          .getElement('app-definition')!
          .getElement('translation-mappings')!
          .findAllElements('translation-mapping')
          .where((element) =>
              element.getAttribute('id') == 'Settings_Interface_Language')
          .first
          .findAllElements('translation')
          .toList()
          .where(
              (element) => element.getAttribute('lang').toString() == langCode);
      String settingsInterfaceLanguageText =
          settingsInterfaceLanguageTextXml.first.innerText;

      Iterable<XmlElement> aboutTextXml = document
          .getElement('app-definition')!
          .getElement('translation-mappings')!
          .findAllElements('translation-mapping')
          .where((element) => element.getAttribute('id') == 'Menu_About')
          .first
          .findAllElements('translation')
          .toList()
          .where(
              (element) => element.getAttribute('lang').toString() == langCode);
      String aboutText = aboutTextXml.first.innerText;

      Iterable<XmlElement> copyTextXml = document
          .getElement('app-definition')!
          .getElement('translation-mappings')!
          .findAllElements('translation-mapping')
          .where((element) => element.getAttribute('id') == 'Menu_Item_Copy')
          .first
          .findAllElements('translation')
          .toList()
          .where(
              (element) => element.getAttribute('lang').toString() == langCode);
      String copyText = copyTextXml.first.innerText;

      Iterable<XmlElement> shareTextXml = document
          .getElement('app-definition')!
          .getElement('translation-mappings')!
          .findAllElements('translation-mapping')
          .where((element) => element.getAttribute('id') == 'Menu_Item_Share')
          .first
          .findAllElements('translation')
          .toList()
          .where(
              (element) => element.getAttribute('lang').toString() == langCode);
      String shareText = shareTextXml.first.innerText;

      // ----
      //Now get supplemental translations
      translationSupplement = {};
      for (var translation in translationData) {
        if (translation['langCode'] == langCode) {
          translationSupplement.addAll({
            'langCode': translation['langCode'],
            "addColumn": translation['addColumn'],
            "settingsTheme": translation['settingsTheme'],
            "systemTheme": translation['systemTheme'],
            "lightTheme": translation['lightTheme'],
            "darkTheme": translation['darkTheme'],
          });
        }
      }
      // ----

      translations.add(Translation(
          langCode: langCode,
          langName: langName,
          search: searchText,
          addColumn: translationSupplement['addColumn']!,
          settingsTheme: translationSupplement['settingsTheme']!,
          systemTheme: translationSupplement['systemTheme']!,
          lightTheme: translationSupplement['lightTheme']!,
          darkTheme: translationSupplement['darkTheme']!,
          about: aboutText,
          settings: settingsText,
          settingsInterfaceLanguage: settingsInterfaceLanguageText,
          copy: copyText,
          share: shareText));
    }
  }
  Provider.of<UserPrefs>(context, listen: false).setUserLang = initialLang;
}

Future<void> saveToLocalDB(List<ParsedLine> verses) async {
  //Hopefully without detaining the user save locally the resulting List<ParsedLine>
  print('starting to save parsed lines to box');
  Box<ParsedLineDB> versesBox =
      await Hive.openBox<ParsedLineDB>('parsedLineDB');

  for (var i = 0; i < verses.length; i++) {
    ParsedLineDB parsedLineDB = ParsedLineDB()
      ..collectionid = verses[i].collectionid
      ..book = verses[i].book
      ..chapter = verses[i].chapter
      ..verse = verses[i].verse
      ..verseFragment = verses[i].verseFragment
      ..audioMarker = verses[i].audioMarker
      ..verseText = verses[i].verseText
      ..verseStyle = verses[i].verseStyle;

    versesBox.add(parsedLineDB);
  }

  print('finished saving parsed lines to box');
  print(versesBox.length);
  return;
}

Future<AppInfo> buildDatabaseFromXML(BuildContext context) async {
  print('buildDatabaseFromXML');
  bool shouldResetDB = true;

  AssetBundle assetBundle = DefaultAssetBundle.of(context);

  String appDefLocation = 'assets/project/appDef.appDef';
  String xmlFileString = await assetBundle.loadString(appDefLocation);
  //get the document into a usable iterable
  final document = XmlDocument.parse(xmlFileString);

  Hive.registerAdapter(ParsedLineDBAdapter());
  Box<ParsedLineDB> versesBox =
      await Hive.openBox<ParsedLineDB>('parsedLineDB');
  Box userPrefsBox = await Hive.openBox('userPrefs');
  //hivedb does not work on web correctly so only do this if it's a standalone app
  if (!kIsWeb) {
    // ** Decide whether or not to rebuild
    //Get the two boxes we deal with here, all the verses and the vanilla userPrefs box
    //(vanilla in the sense that it does not have a typeadapter and is just a Map<String, String>)

    //Get the current appDef build number
    String appDefBuildNumber = document
        .getElement('app-definition')!
        .getElement('version')!
        .getAttribute('code')!;
    //Get the last seen build numbrer
    String? lastSeenBuildNumber = userPrefsBox.get('lastSeenBuildNumber');
    //Get the number of lines in the verses box
    var numLines = versesBox.length;
    print(numLines);
    //Get number of lines in last DB build
    var lastDbBuildLength = userPrefsBox.get('lastDbBuildLength');
    //Writing the whole table to disk takes quite a long time, so
    //check to make sure it finished by comparing the length of the two series
    bool dbMatchesLastBuild = lastDbBuildLength == numLines;

    if (numLines == 0 ||
        appDefBuildNumber != lastSeenBuildNumber ||
        !dbMatchesLastBuild) {
      shouldResetDB = true;
      versesBox.clear();
    } else {
      shouldResetDB = false;
    }

    //Store the current build number for later reference
    userPrefsBox.put('lastSeenBuildNumber', appDefBuildNumber);

    // ** End Decide whether or not to rebuild

    //This part rebuilds every time
    //Get the font information
  }

  String fontWeight = "";
  String fontStyle = "";

  // var xmlFontsSection = document.findElements('fonts');
  XmlElement? xmlFontsSection =
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

  //Get Changes
  Map<String, String> changes = {};
  Iterable<XmlElement> xmlChanges = document
      .getElement('app-definition')!
      .getElement('changes')!
      .findAllElements('change');

  for (var xmlChange in xmlChanges) {
    changes.addAll({
      xmlChange.getElement('find')!.innerText.toString():
          xmlChange.getElement('replace')!.innerText.toString()
    });
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
  //This is the part that is stored for later use
  if (shouldResetDB) {
    print('building local db');
    for (var collection in collections) {
      List<Book> books = collection.books;
      for (var book in books) {
        String url =
            'assets/project/data/books/${collection.id}/${book.filename}';
        String bookText = await assetBundle.loadString(url);

        //incorporate Changes from appDef
        for (var k in changes.keys) {
          //convert raw string to regular string
          String findString = k.replaceAll(r'\', '\\');
          bookText = bookText.replaceAll(RegExp(findString), changes[k]!);
        }

        //Greek NT changes

        //Remove all the extra \+fw
        bookText = bookText.replaceAll(RegExp(r'\\\+fw\s*'), '');

        // Remove \w | \*w - strong's numbers are too many in Greek NT
        var wMarkers = RegExp(r'(\\w\s)(.*?)(\|.*?\\w\*)');
        bookText = bookText.replaceAllMapped(wMarkers, (Match m) => '${m[2]}');

        //end Greek NT

        List<String> chapters = bookText.split(r"\c ");
        //Removes all the headers etc - this also removes files that have no content - something to look at later
        chapters.removeAt(0);

        //Before going to chapters, add an entry for the book title
        verses.add(ParsedLine(
            collectionid: collection.id,
            book: book.id,
            chapter: "1",
            verse: "",
            verseFragment: "",
            audioMarker: "",
            verseText: book.name,
            verseStyle: 'mt1'));

        for (var chapter in chapters) {
          RegExpMatch? match = RegExp(r'(\d+)(\s)').firstMatch(chapter);
          //ˆ: beginning of line; \d digit, + 1 or more; \s whitespace
          String? chapterNumber = match?.group(1);

          //split chapter on line break
          List<String> chapterByLineBreaks = chapter.split('\n');

          ///\r?\n|\r/g is all linebreaks
          //This juts gets rid of the chapter number
          chapterByLineBreaks.removeAt(0);
          //Print a bit
          if (collection.id == 'C06' &&
              book.id == 'MAT' &&
              chapterNumber == '1') {
            print('verseStyle');
          }

          //Set up variables for the chapters - having them here resets them each new chapter also
          String verseStyle = "";
          String verseNumber = "";
          String verseText = "";

          for (var line in chapterByLineBreaks) {
            // https://medium.com/flutter-community/extracting-text-from-a-string-with-regex-groups-in-dart-b6be604c8a69
            // This regex matches the initial style -
            //match is an iterable with an element for each matching group of the regexp
            RegExpMatch? match =
                RegExp(r'(\\)(\w+)(\s*)(.*)').firstMatch(line); // \s
            if (match != null) {
              if (match.group(2) != null) {
                verseStyle = match.group(2)!; //verseStyle
              }
              if (match.group(4) != null) {
                verseText = match.group(4)!; //verseText
                //?? = if_null operator: https://dart-lang.github.io/linter/lints/prefer_if_null_operators.html

              }

              //New Paragraph section

              //verse checking
              if (verseStyle == 'v') {
                RegExpMatch? match = RegExp(r'(\d+)(\s)(.*)').firstMatch(
                    verseText); //group 1 \d+ = digits, \s whitespace, group 3 .* is anything
                if (match != null) {
                  if (match.group(1) != null) verseNumber = match.group(1)!;
                  if (match.group(3) != null) verseText = match.group(3)!;
                }
              }
              // else {
              //   // verseNumber = "";
              // }

              //Now finally add the elements to the List<ParsedVerse>
              verses.add(
                ParsedLine(
                    collectionid: collection.id,
                    book: book.id,
                    chapter: chapterNumber!,
                    verse: verseNumber,
                    verseFragment: "",
                    audioMarker: "",
                    verseText: verseText,
                    verseStyle: verseStyle),
              );
            }
          }
        }
        // print('ending current book ${book.name}');
      }
      // print('ending current collection ${collection.id}');
    }

    //now save to local db
    if (!kIsWeb) saveToLocalDB(verses);
  } else {
    //use existing box
    print('using existing local db');
    for (var i = 0; i < versesBox.length; i++) {
      ParsedLineDB lineDB = versesBox.getAt(i)!;
      verses.add(ParsedLine(
          collectionid: lineDB.collectionid,
          book: lineDB.book,
          chapter: lineDB.chapter,
          verse: lineDB.verse,
          verseFragment: lineDB.verseFragment,
          audioMarker: lineDB.audioMarker,
          verseText: lineDB.verseText,
          verseStyle: lineDB.verseStyle));
    }
  }

  print(verses.length);
  print(versesBox.length);
  userPrefsBox.put('lastDbBuildLength', verses.length);

  AppInfo appInfo = AppInfo(collections: collections, verses: verses);

  print('finished buildDatabaseFromXML');
  return appInfo;
}
