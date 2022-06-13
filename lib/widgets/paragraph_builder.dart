// ignore_for_file: avoid_print

import 'package:fluent_ui/fluent_ui.dart';
import 'package:usfm_bible/providers/user_prefs.dart';

import '../models/database_builder.dart';
import 'package:flutter/gestures.dart';

class ParagraphBuilder extends StatefulWidget {
  final List<ParsedLine> paragraph;
  final double fontSize;
  final List<BibleReference> rangeOfVersesToCopy;
  final Function addVerseToCopyRange;

  const ParagraphBuilder(
      {Key? key,
      required this.paragraph,
      required this.fontSize,
      required this.rangeOfVersesToCopy,
      required this.addVerseToCopyRange})
      : super(key: key);

  @override
  State<ParagraphBuilder> createState() => _ParagraphBuilderState();
}

class _ParagraphBuilderState extends State<ParagraphBuilder> {
  late TextStyle mainTextStyle;
  String? fontFromAssets;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool header = false;

    List<InlineSpan> styledParagraphFragments = [];

    mainTextStyle = TextStyle(
      fontFamily: 'font1',
      fontSize: widget.fontSize,
      color: DefaultTextStyle.of(context).style.color,
    );

    TextStyle underlineStyle =
        mainTextStyle.copyWith(decoration: TextDecoration.underline);

    WidgetSpan verseNumber(String verseNumber) {
      return WidgetSpan(
        child: Transform.translate(
          offset: const Offset(0.0, -4.0),
          child: Text('$verseNumber ',
              style: mainTextStyle.copyWith(
                  fontSize: widget.fontSize / 2,
                  color: FluentTheme.of(context).accentColor)),
        ),
      );
    }
    //verse number is a WidgetSpan rather than TextSpan - this vanilla TextSpan version is for testing
    // TextSpan verseNumber(String verseNumber) {
    //   return TextSpan(
    //       text: ('$verseNumber '),
    //       style: mainTextStyle.copyWith(
    //           fontSize: fontSize / 2,
    //           color: FluentTheme.of(context).accentColor));
    // }

    TextSpan normalVerseFragment(ParsedLine line) {
      //Rearrange the incoming data
      BibleReference ref = BibleReference(
          key: UniqueKey(),
          partOfScrollGroup: true,
          collectionID: line.collectionid,
          bookID: line.book,
          chapter: line.chapter,
          verse: line.verse);

      // bool textSpanUnderline = widget.rangeOfVersesToCopy.contains((element) =>
      //     element.book == ref.bookID &&
      //     element.chapter == ref.chapter &&
      //     element.verse == ref.verse);
      bool? textSpanUnderline = widget.rangeOfVersesToCopy.any(
          (BibleReference element) =>
              element.bookID == ref.bookID &&
              element.chapter == ref.chapter &&
              element.verse == ref.verse);

      return TextSpan(
          text: '${line.verseText} ',
          style: textSpanUnderline ? underlineStyle : mainTextStyle,
          mouseCursor: SystemMouseCursors.basic,

          //Note here that right click gets overridden on web by the browser's right click menu -
          //maybe just have a popout menu on click and no right click if can not override browser menu
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              print(
                  '${line.collectionid} ${line.book} ${line.chapter} ${line.verse}');
              widget.addVerseToCopyRange(BibleReference(
                  key: UniqueKey(),
                  partOfScrollGroup: true,
                  collectionID: line.collectionid,
                  bookID: line.book,
                  chapter: line.chapter,
                  verse: line.verse));

              setState(() {});
            }
          //Just keeping this here for the format but the ContextMenuArea takes the right click
          // ..onSecondaryTap = () {
          //   // showContextMenu(
          //   // details.globalPosition, context, items, verticalPadding, width),
          //   print(
          //       'right click on ${line.collectionid} ${line.book} ${line.chapter} ${line.verse}');
          // },
          );
    }

    TextSpan s(String paragraphFragment) {
      return TextSpan(
        text: paragraphFragment,
        style: mainTextStyle.copyWith(
            fontSize: widget.fontSize + 5,
            color: DefaultTextStyle.of(context).style.color),
      );
    }

    for (var line in widget.paragraph) {
      switch (line.verseStyle) {
        case 'v':
          styledParagraphFragments.add(verseNumber(line.verse));
          styledParagraphFragments.add(normalVerseFragment(line));
          break;
        case 's':
        case 's1':
        case 's2':
        case 'mt1':
        case 'mr':
        case 'ms':
          styledParagraphFragments.add(s(line.verseText));
          header = true;
          break;
        default:
          styledParagraphFragments.add(normalVerseFragment(line));
      }
    }

    //indentation hack for paragraphs
    if (styledParagraphFragments.length > 1) {
      styledParagraphFragments.insert(
          0,
          TextSpan(
            text: '    ',
            style: DefaultTextStyle.of(context).style,
          ));
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          children: styledParagraphFragments,
        ),
        textAlign: header ? TextAlign.center : TextAlign.left,
      ),
    );
  }
}
