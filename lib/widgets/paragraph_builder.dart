import 'package:fluent_ui/fluent_ui.dart';
import '../models/database_builder.dart';

class ParagraphBuilder extends StatelessWidget {
  // final List<ParsedLine> lines;

  final List<ParsedLine> paragraph;

  const ParagraphBuilder({Key? key, required this.paragraph}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool header = false;
    int baseFontSize = 20;

    List<InlineSpan> styledParagraphFragments = [];

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

    TextSpan normalVerseFragment(String paragraphFragment) {
      return TextSpan(
          text: '$paragraphFragment ',
          style: DefaultTextStyle.of(context).style);
    }

    TextSpan s(String paragraphFragment) {
      return TextSpan(
        text: paragraphFragment,
        style: TextStyle(
            fontSize: baseFontSize + 5,
            color: DefaultTextStyle.of(context).style.color),
      );
    }

    for (var line in paragraph) {
      switch (line.verseStyle) {
        case 'v':
          styledParagraphFragments.add(verseNumber(line.verse));
          styledParagraphFragments.add(normalVerseFragment(line.verseText));
          break;
        case 's':
        case 's1':
        case 's2':
          styledParagraphFragments.add(s(line.verseText));
          header = true;
          break;
        default:
          styledParagraphFragments.add(normalVerseFragment(line.verseText));
      }
    }

    //indentation hack for paragraphs
    if (styledParagraphFragments.length > 1) {
      styledParagraphFragments.insert(0, normalVerseFragment("\t\t"));
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
