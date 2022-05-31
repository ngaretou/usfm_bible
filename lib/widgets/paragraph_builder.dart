import 'package:fluent_ui/fluent_ui.dart';
import '../models/database_builder.dart';

class ParagraphBuilder extends StatelessWidget {
  // final List<ParsedLine> lines;
  final ParsedLine paragraphFragment;

  const ParagraphBuilder({Key? key, required this.paragraphFragment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int baseFontSize = 20;

    List<InlineSpan> styledParagraphFragments = [];

    WidgetSpan verseNumber(String verseNumber) {
      return WidgetSpan(
        child: Transform.translate(
            offset: const Offset(0.0, -4.0),
            child: Text(
              '${paragraphFragment.verse} ',
              style: TextStyle(
                fontSize: baseFontSize / 2,
                color: FluentTheme.of(context).accentColor,
              ),
            )),
      );
    }

    TextSpan normalVerseFragment(String paragraphFragment) {
      return TextSpan(
          text: paragraphFragment, style: DefaultTextStyle.of(context).style);
    }

    switch (paragraphFragment.verseStyle) {
      case 'v':
        styledParagraphFragments.add(verseNumber(paragraphFragment.verse));
        styledParagraphFragments
            .add(normalVerseFragment(paragraphFragment.verseText));
        break;
      case 'p':
        styledParagraphFragments
            .add(normalVerseFragment(paragraphFragment.verseText));
        break;
      default:
        styledParagraphFragments
            .add(normalVerseFragment(paragraphFragment.verseText));
    }

    return RichText(
      text: TextSpan(
        children: styledParagraphFragments,
      ),
    );
  }
}
