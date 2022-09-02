import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/user_prefs.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    Widget htmlSection(String url) {
      //This is where we grab the HTML from the asset folder
      Future<String?> fetchHtmlSection(String url) async {
        String htmlSection =
            await DefaultAssetBundle.of(context).loadString(url);
        return htmlSection;
      }

      return FutureBuilder(
        future: fetchHtmlSection(url),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            //this is actually where the business happens; HTML just takes the data and renders it
            : SelectableHtml(
                data: snapshot.data.toString(),
                onLinkTap: (String? url, RenderContext context,
                    Map<String, String> attributes, element) async {
                  if (url != null) {
                    await canLaunchUrl(Uri.parse(url))
                        ? await launchUrl(Uri.parse(url))
                        : throw 'Could not launch $url';
                  }
                }),
      );
    }

    return ScaffoldPage.scrollable(
        header: PageHeader(
          title: Text(Provider.of<UserPrefs>(context, listen: true)
              .currentTranslation
              .about),
        ),
        children: [
          htmlSection("assets/project/data/about/about.txt"),
        ]);
  }
}
