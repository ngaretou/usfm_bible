// ignore_for_file: avoid_print

import 'package:fluent_ui/fluent_ui.dart';

import 'dart:core';
// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart' as material;

import '../models/database_builder.dart';
import 'package:flutter/gestures.dart';
// import '../providers/user_prefs.dart';
// import '../providers/column_manager.dart';

/* this class and associated verseComposer function is exposed as we have to use it several different places. 
It gets confusing but it is this way to avoid code duplication.
Sometimes we need the verses composed with footnotes for display - sometimes composed without for Copy and Share
functions. This processes a given range and gives us both the verses as a List of InLineSpans and as one String.
*/
class ComposedVerses {
  List<InlineSpan> versesAsSpans;
  String versesAsString;

  ComposedVerses({
    required this.versesAsSpans,
    required this.versesAsString,
  });
}

ComposedVerses verseComposer(
    {required ParsedLine line,
    TextStyle? computedTextStyle,
    required bool includeFootnotes,
    Function? tileOnTap,
    required BuildContext context}) {
  List<InlineSpan> spansToReturn = [];
  String textToReturn = '';

  int dealtWithSoFar = 0;
  String leftToDealWith = "";

  //The method for adding the text strings we're about to parse
  void addThisString(String thisString,
      {TextStyle? textStyle, Function? cleaningFunction}) {
    //The function to run when all USFM are accounted for
    stringIsCleanAddIt() {
      RegExpMatch? match = RegExp(r'(\\)').firstMatch(thisString);

      if (match != null) {
        print(
            'Problem: A slash is here but should not be at ${line.collectionid} ${line.book} ${line.chapter} ${line.verse} $thisString');
      }

      //if there is no function incoming
      if (tileOnTap == null) {
        spansToReturn.add(TextSpan(
          text: thisString,
          style: textStyle ?? computedTextStyle,
        ));
      } else {
        //if there is a function (this is usually the add verses to copy range from paragraph builder)
        spansToReturn.add(TextSpan(
            text: thisString,
            style: textStyle ?? computedTextStyle,
            mouseCursor: SystemMouseCursors.basic,
            recognizer: TapGestureRecognizer()..onTap = () => tileOnTap()));
      }
      textToReturn = '$textToReturn$thisString';
    }

    RegExpMatch? match = RegExp(r'(\\)').firstMatch(thisString);

    if (match != null) {
      if (cleaningFunction != null) cleaningFunction(thisString);
    } else {
      stringIsCleanAddIt();
    }
  } // addThisString end

  addFootnote(String footnoteText) {
    String composeFootnotes(String textToClean) {
      String cleanedText = "";
      RegExpMatch? footnoteText =
          RegExp(r'(.*?\\ft )(.*)').firstMatch(textToClean);
      if (footnoteText != null) {
        cleanedText = footnoteText.group(2)!;
      }

      //This just removes the rest of the USFM.
      //This is a hack as the message cannot be a list of inline spans (which we need to do character level formatting)
      //but just a string or one inline span (with one style).
      //Would need to extend ToolTip to alllow List<InlineSpan>, which I'm not up to right now.
      cleanedText = cleanedText.replaceAll(RegExp(r'\\\w+\*\s*'), '');
      cleanedText = cleanedText.replaceAll(RegExp(r'\\\w+\s*'), '');
      return cleanedText;
    }

    if (includeFootnotes) {
      spansToReturn.add(
        WidgetSpan(
          child: Transform.translate(
              offset: const Offset(0.0, -6.0),
              child: Tooltip(
                message: composeFootnotes(footnoteText),
                child: Text(
                  '*',
                  style: DefaultTextStyle.of(context)
                      .style
                      .copyWith(color: FluentTheme.of(context).accentColor),
                ),
              )),
        ),
      );
    }
  }

  void pairedUsfmFindingAndFormatting(String text) {
    //Here begins the character style searching
    Iterable<RegExpMatch>? allPairedUsfmMarkers =
        RegExp(r'(\\)(\w+)(.*?)(\\\w+\*)').allMatches(line.verseText);

    //first step - if no slashes, just add the whole line
    if (allPairedUsfmMarkers.isEmpty) {
      addThisString(line.verseText);
      dealtWithSoFar = line.verseText.length;
    } else {
      //dealthWithSofar is a little error checking and progress caching, making sure we're dealing with all the text

      //So we did find at least one set of paired USFM, for example the 'f' in \f....\f* or the 'add' in \add  ... \add*
      //We know how many paired usfm markers we found (allPairedUsfmMarkers is an Iterable of matches), so we can search for them one at a time.
      for (var i = 0; i < allPairedUsfmMarkers.length; i++) {
        //First let's not deal with the whole line, but what we've not dealt with so far - so 'first' becomes 'next' below
        String leftToDealWith = line.verseText.substring(dealtWithSoFar);

        //Now get the first bit of the string + pre-usfm pair -
        //note the \3 matches the third group, so this ensures we have a matched pair
        RegExpMatch? textPlusUsfmPair =
            //        1     2   3     4   5   6   7
            RegExp(r'(.*?)(\\)(\+?\w+)(.*?)(\\)(\3)(\*)')
                .firstMatch(leftToDealWith);

        if (textPlusUsfmPair != null) {
          addThisString(textPlusUsfmPair.group(1)!,
              cleaningFunction:
                  pairedUsfmFindingAndFormatting); //Pre-USFM pair text
          dealtWithSoFar = dealtWithSoFar + textPlusUsfmPair.group(1)!.length;

          //Note group(0) means all groups. group(1) means first group and so on.
          //Here match.group(2) is for example the 'f' in \f....\f* or the 'add' in \add  ... \add*
          //match.group(3) is the text inside those markers

          //\q1 «Yàlla du ko wallu!» \qs \+w Selaw|selaw:\+w*\qs*\f + \fr 3.3 \fk Selaw: \ft jàpp nañu ne ndigal la luy taxawloo jàngkat yi, te jombul xalam yi wéy ba tey. Waaye man naa nekk itam ndigal ngir xalam yeek jàngkat yi gëna xumbal.\f*.
          //    \qs \+w Selaw|selaw:\+w*\qs*

          //these are character styles
          switch (textPlusUsfmPair.group(3)) {
            case 'add':
            case 'qs':
              //take one char off the add b/c an extra space is there
              addThisString(textPlusUsfmPair.group(4)!.substring(1),
                  textStyle: computedTextStyle != null
                      ? computedTextStyle.copyWith(fontStyle: FontStyle.italic)
                      : const TextStyle());
              dealtWithSoFar = dealtWithSoFar +
                  textPlusUsfmPair.group(0)!.length -
                  textPlusUsfmPair.group(1)!.length;
              continue;
            case 'f':
            case 'ef':
              //Footnotes \f...\f* and \ef...\ef* contain other paired USFM markers so take care of the footnotes first.
              //Make sure this is getting the whole footnote
              if (textPlusUsfmPair.group(3)! == textPlusUsfmPair.group(6)!) {
                addFootnote(textPlusUsfmPair.group(4)!);
                dealtWithSoFar = dealtWithSoFar +
                    textPlusUsfmPair.group(0)!.length -
                    textPlusUsfmPair.group(1)!.length;
              } else {
                String? usfmToPair = textPlusUsfmPair.group(3)!;
                //Note this RegExp is not raw stringed - usually RegExp(r'...') so you have to double escape
                RegExpMatch? footnotePair =
                    //        1     2   3           4   5   6            7
                    RegExp("(.*?)(\\\\)($usfmToPair)(.*?)(\\\\)($usfmToPair)(\\*)")
                        .firstMatch(leftToDealWith);
                addFootnote(footnotePair!.group(4)!);
                dealtWithSoFar = dealtWithSoFar +
                    footnotePair.group(0)!.length -
                    footnotePair.group(1)!.length;
              }
              continue;
            case 'w':
              // case '+w':
              // example: \q1 Isaaxa jur °\w Yanqóoba|Yanqóoba:\w*;
              int endAt = textPlusUsfmPair.group(4)!.indexOf('|');

              addThisString(
                textPlusUsfmPair.group(4)!.substring(1, endAt),
              );
              dealtWithSoFar = dealtWithSoFar +
                  textPlusUsfmPair.group(0)!.length -
                  textPlusUsfmPair.group(1)!.length;
              continue;
            default:
              addThisString(textPlusUsfmPair.group(4)!);
              dealtWithSoFar = dealtWithSoFar +
                  textPlusUsfmPair.group(0)!.length -
                  textPlusUsfmPair.group(1)!.length;
          }
        } else {
          //No USFM pairs left
          addThisString(leftToDealWith,
              cleaningFunction: pairedUsfmFindingAndFormatting);
          dealtWithSoFar = dealtWithSoFar + leftToDealWith.length;
        }
      } //for loop

      //That's the paired usfm...the verse could end with a footnote or could end with more text.
      leftToDealWith = line.verseText.substring(dealtWithSoFar);
      RegExpMatch? match = RegExp(r'(.*)').firstMatch(leftToDealWith);

      if (match != null) {
        addThisString(match.group(0)!);
        dealtWithSoFar = dealtWithSoFar + match.group(0)!.length;
      }
    }
  }

  pairedUsfmFindingAndFormatting(line.verseText);

  ComposedVerses returnInfo = ComposedVerses(
      versesAsSpans: spansToReturn, versesAsString: textToReturn);
  if (dealtWithSoFar != line.verseText.length) {
    // throw "Problem with line parsing in paragraph builder at ${line.collectionid} ${line.book} ${line.chapter} ${line.verse} ${line.verseText}";
    print(
        "Problem with line parsing in paragraph builder at ${line.collectionid} ${line.book} ${line.chapter} ${line.verse} ${line.verseText}");
    print('$dealtWithSoFar dealtWithSoFar');
    print('${line.verseText.length} line.verseText.length');
  }
  return returnInfo;
}
//end verseComposer
////////////////////////////////

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
    // print('paragraph builder build method');
    bool header = false;
    bool poetry = false;

    List<InlineSpan> styledParagraphFragments = [];

    Color accentTextColor = FluentTheme.of(context).accentColor;

    mainTextStyle = TextStyle(
      fontFamily: 'font1',
      fontSize: widget.fontSize,
      color: DefaultTextStyle.of(context).style.color,
    );

    TextStyle underlineStyle =
        mainTextStyle.copyWith(decoration: TextDecoration.underline);

    TextStyle italicStyle = mainTextStyle.copyWith(fontStyle: FontStyle.italic);

    WidgetSpan verseNumber(String verseNumber) {
      return WidgetSpan(
        child: Transform.translate(
          offset: const Offset(0.0, -6.0),
          child: Text(
            ' $verseNumber ',
            style: mainTextStyle.copyWith(
                fontSize: widget.fontSize / 2,
                color: accentTextColor,
                decoration: TextDecoration.none),
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

      //Check to see if this is the simultaneous scroll group ref
      // BibleReference? ref =
      //     Provider.of<ColumnManager>(context, listen: false).getScrollGroupRef;

      //TODO this is where the fading highlight animation will go on nav

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
            fontSize: fontScaling == null
                ? widget.fontSize
                : widget.fontSize * fontScaling,
            fontStyle: italics == null ? FontStyle.normal : FontStyle.italic,
            color: DefaultTextStyle.of(context).style.color),
      );
    }

    for (var line in widget.paragraph) {
      //These are for paragraph styles
      switch (line.verseStyle) {
        case 'v':
          styledParagraphFragments.add(verseNumber(line.verse));
          styledParagraphFragments.addAll(normalVerseFragment(line));
          header = false;
          break;
        case 'm':
          styledParagraphFragments.add(verseNumber(line.verse));
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
          : const EdgeInsets.only(top: 8.0),
      child: RichText(
        text: TextSpan(
          children: styledParagraphFragments,
        ),
        textAlign: header ? TextAlign.center : TextAlign.left,
      ),
    );
  }
}
