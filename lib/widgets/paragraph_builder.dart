import 'package:fluent_ui/fluent_ui.dart';
import 'dart:ui' as ui;
import 'dart:core';
import '../logic/database_builder.dart';
import '../logic/verse_composer.dart';

class ParagraphBuilder extends StatefulWidget {
  final List<ParsedLine> paragraph;
  final String fontName;
  final ui.TextDirection textDirection;
  final double fontSize;
  final List<ParsedLine> rangeOfVersesToCopy;
  final Function addVerseToCopyRange;

  const ParagraphBuilder(
      {super.key,
      required this.paragraph,
      required this.fontName,
      required this.textDirection,
      required this.fontSize,
      required this.rangeOfVersesToCopy,
      required this.addVerseToCopyRange});

  @override
  State<ParagraphBuilder> createState() => _ParagraphBuilderState();
}

class _ParagraphBuilderState extends State<ParagraphBuilder> {
  @override
  Widget build(BuildContext context) {
    // // print('paragraph builder build method');
    bool ltrText = widget.textDirection == ui.TextDirection.ltr;
    TextAlign paraAlignment = ltrText ? TextAlign.left : TextAlign.right;

    bool header = false;
    bool poetry = false;

    List<InlineSpan> styledParagraphFragments = [];

    Color accentTextColor = FluentTheme.of(context).accentColor;

    double fontSize = ltrText ? widget.fontSize : widget.fontSize + 7;

    TextStyle mainTextStyle = TextStyle(
      fontFamily: widget.fontName,
      fontSize: fontSize,
      color: DefaultTextStyle.of(context).style.color,
    );

    TextStyle underlineStyle =
        mainTextStyle.copyWith(decoration: TextDecoration.underline);

    TextStyle italicStyle = mainTextStyle.copyWith(fontStyle: FontStyle.italic);

    //AS verseNumber - the WidgetSpan doesn't work for RTL, gets confused somehow.
    //This is a ready replacement that doesn't look bad.
    TextSpan verseNumberRTL(String verseNumber) {
      return TextSpan(
        text: ' $verseNumber ',
        style: mainTextStyle.copyWith(
          // height: 5,
          textBaseline: TextBaseline.ideographic,
          fontSize: fontSize / 2,
          color: accentTextColor,
          decoration: TextDecoration.none,
        ),
      );
    }

    //Normal LTR text versenumber with transform for elevation
    WidgetSpan verseNumberLTR(String verseNumber) {
      return WidgetSpan(
        child: Transform.translate(
          offset: const Offset(0.0, -6.0),
          child: Text(
            ' $verseNumber ',
            style: mainTextStyle.copyWith(
                fontSize: fontSize / 2,
                color: accentTextColor,
                decoration: TextDecoration.none),
            textDirection: widget.textDirection,
          ),
        ),
      );
    }

//\v 50 Adoña nag ragal Suleymaan, daldi dem jàpp ca béjjén ya ca cati °\w sarxalukaay|sarxalukaay b-:\w* ba, ngir rawale bakkanam\f + \fr 1.50 \ft Jàpp ca sarxalukaay ba ca kër Yàlla ga, nit daan na ko def, di ko sàkkoo rawale bakkanam. Seetal ci \bk Mucc ga\bk* 21.14.\f*.
//1Ki 1.50 - see paired usfm inside \f...\f* ndeysaan

    List<InlineSpan> normalVerseFragment(ParsedLine line,
        {TextStyle? paraStyle}) {
      late TextStyle computedTextStyle;

      //Check to see if this text belongs to the range of verses to copy
      bool? textSpanUnderline = widget.rangeOfVersesToCopy.any(
          (ParsedLine element) =>
              element.book == line.book &&
              element.chapter == line.chapter &&
              element.verse == line.verse);

      //TO DO this is where the fading highlight animation will go on nav

      //Compute the style
      if (textSpanUnderline) {
        computedTextStyle = underlineStyle;
      } else if (paraStyle != null) {
        computedTextStyle = paraStyle;
      } else {
        computedTextStyle = mainTextStyle;
      }

      void tileOnTap() {
        widget.addVerseToCopyRange(line);
        setState(() {});
      }

      return verseComposer(
              line: line,
              computedTextStyle: computedTextStyle,
              includeFootnotes: true,
              context: context,
              tileOnTap: tileOnTap)
          .versesAsSpans;
    }

    TextSpan s(String paragraphFragment, {num? fontScaling, bool? italics}) {
      return TextSpan(
        text: paragraphFragment,
        style: mainTextStyle.copyWith(
            fontSize: fontScaling == null ? fontSize : fontSize * fontScaling,
            fontStyle: italics == null ? FontStyle.normal : FontStyle.italic,
            color: DefaultTextStyle.of(context).style.color),
      );
    }

    for (var line in widget.paragraph) {
      //These are for paragraph styles
      switch (line.verseStyle) {
        case 'v':
          if (widget.textDirection == ui.TextDirection.ltr) {
            styledParagraphFragments.add(verseNumberLTR(line.verse));
          } else {
            styledParagraphFragments.add(verseNumberRTL(line.verse));
          }

          styledParagraphFragments.addAll(normalVerseFragment(line));
          header = false;
          break;
        /*Continuation (margin) paragraph.
        No first line indent.
        Followed immediately by a space and paragraph text, or by a new line and a verse marker.*/
        case 'm':
          styledParagraphFragments.addAll(normalVerseFragment(line));
          header = false;
          break;
        case 's':
          styledParagraphFragments.add(s(line.verseText, fontScaling: 1.2));
          header = true;
          break;
        case 's1':
          styledParagraphFragments.add(s(line.verseText, fontScaling: 1.2));
          header = true;
          break;
        case 's2':
          styledParagraphFragments.add(s(line.verseText, fontScaling: 1.1));
          header = true;
          break;
        case 'mt1':
          styledParagraphFragments.add(s(line.verseText, fontScaling: 1.5));
          header = true;
          break;
        case 'mr':
          styledParagraphFragments
              .add(s(line.verseText, fontScaling: .9, italics: true));
          header = true;
          break;
        case 'ms':
        case 'ms1':
        case 'ms2':
          styledParagraphFragments.add(s(line.verseText, fontScaling: 1));
          header = true;
          break;
        case 'q':
        case 'q1':
        case 'q2':
          styledParagraphFragments.addAll(normalVerseFragment(line));
          poetry = true;
          break;
        case 'd':
        case 'r':
          styledParagraphFragments
              .addAll(normalVerseFragment(line, paraStyle: italicStyle));
          // styledParagraphFragments.add(s(line.verseText, fontScaling: .7));
          break;
        default:
          styledParagraphFragments.addAll(normalVerseFragment(line));
      }
    }

    //indentation hack for paragraphs
    if (styledParagraphFragments.length > 1 && !poetry) {
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
      padding: poetry
          ? const EdgeInsets.only(left: 20, bottom: 0.0)
          : const EdgeInsets.only(top: 8.0, left: 12, right: 12),
      child: RichText(
        text: TextSpan(
          children: styledParagraphFragments,
        ),
        textAlign: header ? TextAlign.center : paraAlignment,
        textDirection: widget.textDirection,
      ),
    );
  }
}
