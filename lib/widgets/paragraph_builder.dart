// ignore_for_file: avoid_print

import 'package:fluent_ui/fluent_ui.dart';
import '../models/database_builder.dart';
import 'package:flutter/gestures.dart';

class ParagraphBuilder extends StatefulWidget {
  // final List<ParsedLine> lines;

  final List<ParsedLine> paragraph;

  const ParagraphBuilder({Key? key, required this.paragraph}) : super(key: key);

  @override
  State<ParagraphBuilder> createState() => _ParagraphBuilderState();
}

class _ParagraphBuilderState extends State<ParagraphBuilder> {
  double baseFontSize = 14;
  late TextStyle style;
  bool underlined = false;
  @override
  void initState() {
    // style = TextStyle(fontSize: baseFontSize);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool header = false;

    List<InlineSpan> styledParagraphFragments = [];
    style = DefaultTextStyle.of(context).style;
    TextStyle underlineStyle = DefaultTextStyle.of(context)
        .style
        .copyWith(decoration: TextDecoration.underline);
    // decoration: TextDecoration.underline

    WidgetSpan verseNumber(String verseNumber) {
      return WidgetSpan(
        child: Transform.translate(
          offset: const Offset(0.0, -4.0),
          child: Text(
            '$verseNumber ',
            style: TextStyle(
              fontSize: baseFontSize / 2,
              color: FluentTheme.of(context).accentColor,
            ),
          ),
        ),
      );
    }

    TextSpan normalVerseFragment(ParsedLine line) {
      print(DefaultTextStyle.of(context).style.fontSize.toString());
      return TextSpan(
          text: '${line.verseText} ',
          style: underlined ? underlineStyle : style,
          mouseCursor: SystemMouseCursors.basic,

          //Note here that right click gets overridden on web by the browser's right click menu - maybe just have a popout menu on click and no right click
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
        style: TextStyle(
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
