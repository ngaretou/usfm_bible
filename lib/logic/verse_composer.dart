import 'package:fluent_ui/fluent_ui.dart';
import 'dart:core';
import 'database_builder.dart';
import 'package:flutter/gestures.dart';

/* this class and associated verseComposer function is exposed as we have to use it several different places. 
It gets confusing but it is this way to avoid code duplication. Sometimes we need the verses composed 
with footnotes for display - sometimes composed without for Copy and Share
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
  // int totalCharacters = 0;

  //The method for adding the text strings we're about to parse
  void addThisString(String thisString,
      {TextStyle? textStyle, Function? cleaningFunction}) {
    //The function to run when all USFM are accounted for
    stringIsCleanAddIt() {
      RegExpMatch? match = RegExp(r'(\\)').firstMatch(thisString);

      if (match != null) {
        debugPrint(
            'Problem: A slash is here but should not be at ${line.collectionid} ${line.book} ${line.chapter} ${line.verse} $thisString');
      }

      //if there is no function incoming - a heading etc
      if (tileOnTap == null) {
        spansToReturn.add(TextSpan(
          text: thisString,
          style: textStyle ?? computedTextStyle,
        ));
      } else {
        //TO DO can we split paragraphs?
        //if there is a function (this is when there is a verse you can copy)
        // totalCharacters = totalCharacters + thisString.length;
        // if (totalCharacters > 75 && thisString.endsWith('.')) {
        //   thisString = '$thisString \n';
        // }
        spansToReturn.add(TextSpan(
            text: thisString,
            style: textStyle ?? computedTextStyle,
            mouseCursor: SystemMouseCursors.basic,
            recognizer: TapGestureRecognizer()..onTap = () => tileOnTap()));
      }
      textToReturn = '$textToReturn$thisString';
    } //end stringIsCleanAddIt

    //This gets things started
    RegExpMatch? match = RegExp(r'(\\)').firstMatch(thisString);

    if (match != null) {
      /*This is to loop back through pairedUsfmFindingAndFormatting below - 
      we have to bring it with here because we're looping back and forth and this is neededy by that 
      and that by this function, and so this makes the function declared below accessible here at the top*/
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
        //here just grab the text between \ft and \ft*
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

    //if includeFootnotes is true, this is for screen display (not string copy) so add it to the spans to return.
    //Otherwise the footnotes are thrown away as there's no else
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

      //Is there something?
      if (match != null) {
        //If so just add it
        addThisString(match.group(0)!);
        dealtWithSoFar = dealtWithSoFar + match.group(0)!.length;
      }
    }
  }

  //This is what kicks it all off
  pairedUsfmFindingAndFormatting(line.verseText);

  //Then after all is accounted for it falls back down here
  ComposedVerses returnInfo = ComposedVerses(
      versesAsSpans: spansToReturn, versesAsString: textToReturn);
  // if (dealtWithSoFar != line.verseText.length) {
    // throw "Problem with line parsing in paragraph builder at ${line.collectionid} ${line.book} ${line.chapter} ${line.verse} ${line.verseText}";
    // print(
    // "Problem with line parsing in paragraph builder at ${line.collectionid} ${line.book} ${line.chapter} ${line.verse} ${line.verseText}");
    // print('$dealtWithSoFar dealtWithSoFar');
    // print('${line.verseText.length} line.verseText.length');
  // }
  return returnInfo;
}
//end verseComposer
