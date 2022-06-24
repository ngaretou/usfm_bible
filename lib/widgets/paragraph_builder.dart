// ignore_for_file: avoid_print

import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import '../models/database_builder.dart';
import 'package:flutter/gestures.dart';
import '../providers/user_prefs.dart';
import '../providers/column_manager.dart';

class ParagraphBuilder extends StatefulWidget {
  final List<ParsedLine> paragraph;
  final double fontSize;
  final List<ParsedLine> rangeOfVersesToCopy;
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
  Widget build(BuildContext context) {
    print('paragraph builder build method');
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
          offset: const Offset(0.0, -6.0),
          child: Text(
            ' $verseNumber ',
            style: mainTextStyle.copyWith(
                fontSize: widget.fontSize / 2,
                color: FluentTheme.of(context).accentColor,
                decoration: TextDecoration.none),
          ),
        ),
      );
    }

    TextSpan normalVerseFragment(ParsedLine line) {
      bool? textSpanUnderline = widget.rangeOfVersesToCopy.any(
          (ParsedLine element) =>
              element.book == line.book &&
              element.chapter == line.chapter &&
              element.verse == line.verse);

      late TextStyle computedTextStyle;
      BibleReference? ref =
          Provider.of<ColumnManager>(context, listen: false).getScrollGroupRef;
// bool test = (

      if (textSpanUnderline) {
        computedTextStyle = underlineStyle;
      } else {
        computedTextStyle = mainTextStyle;
      }

      return TextSpan(
          text: line.verseText,
          // style: textSpanUnderline ? underlineStyle : mainTextStyle,
          style: computedTextStyle,
          mouseCursor: SystemMouseCursors.basic,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // print(
              //     '${line.collectionid} ${line.book} ${line.chapter} ${line.verse}');
              widget.addVerseToCopyRange(line);

              setState(() {});
            }
          //Just keeping this here for the syntax but the ContextMenuArea takes the right click
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
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(decoration: TextDecoration.none),
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
