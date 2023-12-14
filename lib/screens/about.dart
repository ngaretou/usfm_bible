import 'package:flutter/material.dart' as material;
import 'package:provider/provider.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usfm_bible/logic/database_builder.dart';
import 'package:xml/xml.dart';

import '../main.dart';

import '../providers/user_prefs.dart';

import '../widgets/onboarding_panel.dart';

class About extends StatelessWidget {
  // const About({super.key});
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    // // print('about page build');
    // appDef info
    String appName = '';
    String versionName = '';
    String programType = '';
    String programVersion = '';

    AssetBundle assetBundle = DefaultAssetBundle.of(context);

    //Get collection copyright strings from the appdef
    Future<Map<String, String>> getCollectionCopyrights() async {
      Map<String, String> results = {};

      //get the appDef xml from outside the flutter project
      String appDefLocation = 'assets/project/appDef.appDef';
      String xmlFileString = await assetBundle.loadString(appDefLocation);
      //get the document into a usable iterable
      final document = XmlDocument.parse(xmlFileString);
      //This is the info for all collectionsp
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

    Future<void> getVariables() async {
      //get the appDef xml from outside the flutter project
      String appDefLocation = 'assets/project/appDef.appDef';
      String xmlFileString = await assetBundle.loadString(appDefLocation);
      //get the document into a usable iterable
      final document = XmlDocument.parse(xmlFileString);

      appName = document
          .getElement('app-definition')!
          .getElement('app-name')!
          .innerText
          .toString(); // e.g. Kaddug Yalla
      versionName = document
          .getElement('app-definition')!
          .getElement('version')!
          .getAttribute('name')
          .toString(); // e.g. 1.0
      programType = document
          .getElement('app-definition')!
          .getAttribute('type')
          .toString(); // e.g. SAB
      programVersion = document
          .getElement('app-definition')!
          .getAttribute('program-version')
          .toString(); // e.g. 9.3
    }

    Future<String> getHtml() async {
      await getVariables();
      //First get the copyrights from the appdef
      Map<String, String> copyrights = await getCollectionCopyrights();

      //Get the main about page html

      String aboutPageHtml =
          await assetBundle.loadString("assets/project/data/about/about.txt");

      //Now for each of the copyright texts we have, check to see if the appbuilder wants that text in the about page
      for (var k in copyrights.keys) {
        //check to see if the corresponding variable is present: e.g. %copyright-all:C01%
        RegExpMatch? match =
            RegExp('%copyright-all:$k%').firstMatch(aboutPageHtml);

        //If present, replace variable with copyright text
        if (match != null) {
          String composedCopyrightStatement =
              '<br><hr style="margin-top:0em"><h2>${collections.where((element) => element.id == k).first.name}</h2><br>${copyrights[k]}<br>';

          aboutPageHtml = aboutPageHtml.replaceAll(
              RegExp('%copyright-all:$k%'), composedCopyrightStatement);
        }
      }

      //Now all html is in
      //Clean up other variables
      aboutPageHtml = aboutPageHtml.replaceAll(RegExp(r'%app-name%'), appName);
      aboutPageHtml =
          aboutPageHtml.replaceAll(RegExp(r'%version-name%'), versionName);
      aboutPageHtml =
          aboutPageHtml.replaceAll(RegExp(r'%program-type%'), programType);
      aboutPageHtml = aboutPageHtml.replaceAll(
          RegExp(r'%program-version%'), programVersion);

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
            ? const Center(child: ProgressRing())
            //this is actually where the business happens; HTML just takes the data and renders it
            //SelectableHtml makes it selectable but you lose some formatting
            : Html(
                data: snapshot.data.toString(),
                onLinkTap: (String? url, Map<String, String> attributes,
                    element) async {
                  if (url != null) {
                    await canLaunchUrl(Uri.parse(url))
                        ? await launchUrl(Uri.parse(url))
                        : throw 'Could not launch $url';
                  }
                }),
      );
    }

    late PackageInfo packageInfo;

    getPackageInfo() async {
      packageInfo = await PackageInfo.fromPlatform();
    }

    List<Widget> pageContent = [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FutureBuilder(
              future: getPackageInfo(),
              builder: (ctx, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? const Center(child: ProgressBar())
                  : Text(
                      '${packageInfo.version} (${packageInfo.buildNumber})')),
          const SizedBox(width: 20),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const Center(child: OnboardingPanel());
                    });
              },
              icon: const Icon(FluentIcons.onboarding))
        ],
      ),
      htmlToDisplay(),
      Button(
          onPressed: () {
            //Here we're transforming the saved theme to the Material theme just by grabbing
            //the brightness and seed color
            String themeMode =
                userPrefsBox.get('themeMode') ?? 'ThemeMode.dark';
            Color colorToReturn = Colors.teal;
            int? savedColorIndex = userPrefsBox.get('colorIndex');
            if (savedColorIndex != null) {
              colorToReturn = Colors.accentColors[savedColorIndex];
            }

            void showLicensePage({
              required BuildContext context,
              String? applicationName,
              String? applicationVersion,
              Widget? applicationIcon,
              String? applicationLegalese,
              bool useRootNavigator = false,
            }) {
              // assert(context != null);
              // assert(useRootNavigator != null);
              Navigator.of(context, rootNavigator: useRootNavigator)
                  .push(material.MaterialPageRoute<void>(
                builder: (BuildContext licenseContext) => material.Theme(
                  //Here after Flutter 3 the theming wouldn't work right -
                  //wrap the License Page in its own Material theme,
                  //getting the imporant components from the saved theme
                  data: material.ThemeData(
                      useMaterial3: true, //important!
                      colorSchemeSeed: colorToReturn,
                      brightness: themeMode == 'ThemeMode.dark'
                          ? Brightness.dark
                          : Brightness.light),
                  child: material.LicensePage(
                    applicationName: applicationName,
                    applicationVersion: applicationVersion,
                    applicationIcon: applicationIcon,
                    applicationLegalese: applicationLegalese,
                  ),
                ),
              ));
            }

            showLicensePage(
                context: context,
                applicationName: 'usfm_bible',
                useRootNavigator: false);
          },
          child: const Text('Licenses')),
    ];

    return ScaffoldPage.scrollable(
        header: PageHeader(
          title: Text(Provider.of<UserPrefs>(context, listen: false)
              .currentTranslation
              .about),
        ),
        children: pageContent);
  }
}
