// ignore_for_file: avoid_print

import 'package:fluent_ui/fluent_ui.dart';

import '../models/database_builder.dart';
import 'package:flutter/gestures.dart';
// import 'package:google_fonts/google_fonts.dart';

class ParagraphBuilder extends StatefulWidget {
  // final List<ParsedLine> lines;

  final List<ParsedLine> paragraph;

  const ParagraphBuilder({Key? key, required this.paragraph}) : super(key: key);

  @override
  State<ParagraphBuilder> createState() => _ParagraphBuilderState();
}

class _ParagraphBuilderState extends State<ParagraphBuilder> {
  double baseFontSize = 20;
  late TextStyle mainTextStyle;
  bool underlined = false;
  String? fontFromAssets;

  // @override
  // void initState() {
  //   // style = TextStyle(fontSize: baseFontSize);

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    bool header = false;

    List<InlineSpan> styledParagraphFragments = [];

    //font experimentation

    mainTextStyle = TextStyle(
      fontFamily: 'font1',
      fontSize: baseFontSize,
      color: DefaultTextStyle.of(context).style.color,
    );
    // mainTextStyle = TextStyle(
    //   fontFamily: Charis,
    //   package:
    // )

//font experimentation

    TextStyle underlineStyle =
        mainTextStyle.copyWith(decoration: TextDecoration.underline);

    WidgetSpan verseNumber(String verseNumber) {
      return WidgetSpan(
        child: Transform.translate(
          offset: const Offset(0.0, -4.0),
          child: Text('$verseNumber ',
              style: mainTextStyle.copyWith(
                  fontSize: baseFontSize / 2,
                  color: FluentTheme.of(context).accentColor)),
        ),
      );
    }

    TextSpan normalVerseFragment(ParsedLine line) {
      return TextSpan(
          text: '${line.verseText} ',
          style: underlined ? underlineStyle : mainTextStyle,
          mouseCursor: SystemMouseCursors.basic,

          //Note here that right click gets overridden on web by the browser's right click menu -
          //maybe just have a popout menu on click and no right click if can not override browser menu
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              print(
                  '${line.collectionid} ${line.book} ${line.chapter} ${line.verse}');
              setState(() {
                underlined = !underlined;
              });
            }
            ..onSecondaryTap = () {
              print(
                  'right click on ${line.collectionid} ${line.book} ${line.chapter} ${line.verse}');
            });
    }

    TextSpan s(String paragraphFragment) {
      return TextSpan(
        text: paragraphFragment,
        style: mainTextStyle.copyWith(
            fontSize: baseFontSize + 5,
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
