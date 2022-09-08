// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usfm_bible/models/database_builder.dart';
import 'package:xml/xml.dart';
import '../providers/user_prefs.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    //Get collection copyright strings from the appdef
    Future<Map<String, String>> getCollectionCopyrights(
        BuildContext context) async {
      AssetBundle assetBundle = DefaultAssetBundle.of(context);
      Map<String, String> results = {};

      //get the appDef xml from outside the flutter project
      String appDefLocation = 'assets/project/appDef.appDef';
      String xmlFileString = await assetBundle.loadString(appDefLocation);
      //get the document into a usable iterable
      final document = XmlDocument.parse(xmlFileString);
      //This is the info for all collections
      Iterable<XmlElement> xmlCollections =
          document.getElement('app-definition')!.findAllElements('books');

      for (XmlElement xmlCollection in xmlCollections) {
        String id = xmlCollection.getAttribute('id').toString();

        Iterable<XmlElement>? xmlMetadata =
            xmlCollection.getElement('metadata')?.findAllElements('meta');

        if (xmlMetadata != null) {
          for (XmlElement xmlMeta in xmlMetadata) {
            if (xmlMeta.getAttribute('name') == 'copyright-text') {
              results.addAll({id: xmlMeta.getAttribute('content').toString()});
            }
          }
        }
      }

      return results;
    }

    Future<String> getHtml() async {
      //First get the copyrights from the appdef
      Map<String, String> copyrights = await getCollectionCopyrights(context);

      //Get the main about page html
      String aboutPageHtml = await DefaultAssetBundle.of(context)
          .loadString("assets/project/data/about/about.txt");

      //Now for each of the copyright texts we have, check to see if the appbuilder wants that text in the about page
      for (var k in copyrights.keys) {
        //check to see if the corresponding variable is present: e.g. %copyright-all:C01%
        RegExpMatch? match =
            RegExp('%copyright-all:$k%').firstMatch(aboutPageHtml);

        //If present, replace variable with copyright text
        if (match != null) {
          String composedCopyrightStatement =
              '<hr><br><h2>${collections.where((element) => element.id == k).first.name}</h2><br>${copyrights[k]}<br>';

          aboutPageHtml = aboutPageHtml.replaceAll(
              RegExp('%copyright-all:$k%'), composedCopyrightStatement);
        }
      }

      //Now all html is in
      //Clean up other variables
      aboutPageHtml = aboutPageHtml.replaceAll(RegExp(r'%version-name%'), '');

      //Replace any \n line breaks with html breaks
      aboutPageHtml = aboutPageHtml.replaceAll(RegExp(r'\\n'), '<br>');

      //Clean up any variables for collections that have them but there is no text for them
      aboutPageHtml =
          aboutPageHtml.replaceAll(RegExp('%copyright-all:C0\\d%'), '');

      return aboutPageHtml;
    }

    Future<String> htmlToRender = getHtml();

    Widget htmlToDisplay() {
      return FutureBuilder(
        future: htmlToRender,
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            //this is actually where the business happens; HTML just takes the data and renders it
            //SelectableHtml makes it selectable but you lose some formatting
            : Html(
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
        children: [htmlToDisplay()]);
  }
}
