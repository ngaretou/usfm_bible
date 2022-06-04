// ignore_for_file: avoid_print

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';
import 'package:url_launcher/link.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:window_manager/window_manager.dart';

import 'screens/bible_view.dart';
import 'screens/settings.dart';
import 'theme.dart';
import 'models/database_builder.dart';

String appTitle = "Placeholder App Title";

/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // if it's on the web, windows or android, load the accent color
  if (kIsWeb ||
      [TargetPlatform.windows, TargetPlatform.android]
          .contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }

  setPathUrlStrategy();

  if (isDesktop) {
    await flutter_acrylic.Window.initialize();
    await WindowManager.instance.ensureInitialized();

    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.normal,
        windowButtonVisibility: true,
      );
      await windowManager.setSize(const Size(1400, 700));
      await windowManager.setMinimumSize(const Size(600, 600));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppTheme(),
      builder: (context, _) {
        final appTheme = context.watch<AppTheme>();
        return FluentApp(
          title: appTitle,

          themeMode: appTheme.mode,
          debugShowCheckedModeBanner: false,
          home: const MyHomePage(),
          color: appTheme.color,
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen() ? 2.0 : 0.0,
            ),
          ),
          theme: ThemeData(
            fontFamily: 'font1',
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen() ? 2.0 : 0.0,
            ),
          ),
          //Local
          // localizationsDelegates: const [
          //   // AppLocalizations.delegate,

          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          // supportedLocales: const [
          //   Locale('en', ''),
          //   Locale('fr', 'FR'),
          //   // Unfortunately there is a ton of setup to add a new language
          //   // to Flutter post version 2.0 and intl 0.17.
          //   // The most doable way to stick with the official Flutter l10n method
          //   // is to use Swiss French as the main source for the translations
          //   // and add in the Wolof to the app_fr_ch.arb in the l10n folder.
          //   // So when we switch locale to fr_CH, that's Wolof.
          //   Locale('fr', 'CH'),
          // ],
          // locale: appTheme.locale,
          builder: (context, child) {
            return Directionality(
              textDirection: appTheme.textDirection,
              child: NavigationPaneTheme(
                data: NavigationPaneThemeData(
                  backgroundColor: appTheme.windowEffect !=
                          flutter_acrylic.WindowEffect.disabled
                      ? Colors.transparent
                      : null,
                ),
                child: child!,
              ),
            );
          },
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with WindowListener {
  int numberOfColumns = 2;
  bool addPane = false;
  late Future<AppInfo> init = callInititalization();

  int index = 0;

  final settingsController = ScrollController();
  final viewKey = GlobalKey();

  @override
  void initState() {
    windowManager.addListener(this);
    callInititalizationAppName();
    super.initState();
  }

  Future<AppInfo> callInititalization() async {
    var response = await buildDatabaseFromXML(context);

    //How many columns should we initially open?
    switch (response.collections.length) {
      case 1:
        numberOfColumns = 2; //if one collection, open two views
        break;
      case 2:
        numberOfColumns = 2;
        break;
      case 3:
        numberOfColumns = 3;
        break;
      case 4:
        numberOfColumns = 4;
        break;

      default:
        2;
    }
    print('returning future from initialization');
    return response;
  }

  Future<void> callInititalizationAppName() async {
    String response = await asyncGetProjectName(context);
    print('returning future from asyncGetProjectName');
    print(response);
    setState(() {
      appTitle = response;
    });
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    settingsController.dispose();
    super.dispose();
  }

  // Widget delayedAppTitle() {
  //   return FutureBuilder(
  //       future: initAppName,
  //       builder: (ctx, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Center(child: ProgressBar());
  //           // return Text('still waiting');
  //         } else {
  //           print('delayedAppTitle $appTitle');
  //           return Text(snapshot.data.toString());
  //         }
  //       });
  // }

  informationalDialog() {
    ContentDialog(
      title: const Text('No WiFi connection'),
      content: const Text('Check your connection and try again'),
      actions: [
        Button(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }

  void changeNumberColumns({bool? add, int? columnToRemove}) {
    print('changeNumberColumns');
    if (add == true) {
      if (numberOfColumns <= 3) numberOfColumns++; //keep to four columns
    } else {
      numberOfColumns--;
    }
    setState(() {});
  }

  void addColumn() {
    print('adding a column');
    if (numberOfColumns <= 3) {
      numberOfColumns++;
      setState(() {});
    }
  }

  void deleteColumn(int indextoDelete) {
    print('deleting column $indextoDelete');
    numberOfColumns--;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();
    return NavigationView(
        key: viewKey,
        //appBar is across top of the screen in place of normal OS specific title bar.
        // appBar: NavigationAppBar(
        //   automaticallyImplyLeading: false,
        //   title: () {
        //     if (kIsWeb) return Text(appTitle);
        //     return DragToMoveArea(
        //       child: Row(
        //         children: [
        //           const SizedBox(width: 15),
        //           Align(
        //             alignment: AlignmentDirectional.centerStart,
        //             child: Text(appTitle),
        //           ),
        //         ],
        //       ),
        //     );
        //   }(),
        //   actions: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       IconButton(
        //           icon: const Icon(FluentIcons.add),
        //           onPressed: () {
        //             numberOfColumns <= 3 //keep it to four columns
        //                 ? changeNumberColumns(add: true)
        //                 : null;

        //             print(numberOfColumns);
        //             // setState(() {});
        //           }),

        //       // Spacer(),

        //       // ToggleSwitch(
        //       //   content: const Text('Dark Mode'),
        //       //   checked: FluentTheme.of(context).brightness.isDark,
        //       //   onChanged: (v) {
        //       //     if (v) {
        //       //       appTheme.mode = ThemeMode.dark;
        //       //     } else {
        //       //       appTheme.mode = ThemeMode.light;
        //       //     }
        //       //   },
        //       // ),
        //       // if (!kIsWeb) WindowButtons(),
        //     ],
        //   ),
        // ),
        pane: NavigationPane(
          selected: index,
          onChanged: (i) => setState(() => index = i),
          size: const NavigationPaneSize(
            openMinWidth: 250.0,
            openMaxWidth: 320.0,
          ),
          header: Container(
            height: kOneLineTileHeight,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),

            // child: Align(
            //   alignment: Alignment.centerLeft,
            //   child: FlutterLogo(
            //     style: appTheme.displayMode == PaneDisplayMode.top
            //         ? FlutterLogoStyle.markOnly
            //         : FlutterLogoStyle.horizontal,
            //     size: appTheme.displayMode == PaneDisplayMode.top ? 24 : 100.0,
            //   ),
            // ),
          ),
          displayMode: appTheme.displayMode,
          indicator: () {
            switch (appTheme.indicator) {
              case NavigationIndicators.end:
                return const EndNavigationIndicator();
              case NavigationIndicators.sticky:
              default:
                return const StickyNavigationIndicator();
            }
          }(),
          items: [
            // It doesn't look good when resizing from compact to open
            // PaneItemHeader(header: Text('User Interaction')),
            PaneItem(
                icon: const Icon(FluentIcons.reading_mode),
                title: Text(appTitle)),
          ],
          footerItems: [
            //Actions label?
            // PaneItemHeader(
            //   header: Text('paneitemheader'),
            // ),
            PaneItemSeparator(),
            RunFunctionPaneItemAction(
                icon: const Icon(FluentIcons.search),
                functionToRun: deleteColumn),
            RunFunctionPaneItemAction(
                icon: const Icon(FluentIcons.calculator_addition),
                functionToRun: addColumn),
            LightDarkModePaneItemAction(
              icon: FluentTheme.of(context).brightness.isDark
                  ? const Icon(FluentIcons.sunny)
                  : const Icon(FluentIcons.clear_night),
              title: const Text('Light/Dark Toggle'),
              appTheme: appTheme,
            ),

            PaneItemSeparator(),
            PaneItem(
              icon: const Icon(FluentIcons.settings),
              title: const Text('Settings'),
            ),
            _LinkPaneItemAction(
              icon: const Icon(FluentIcons.open_source),
              title: const Text('Source code'),
              link: 'https://github.com/bdlukaa/fluent_ui',
            ),
          ],
        ),
        content: FutureBuilder(
            future: init,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: ProgressRing());
              }
              //Main row that holds the text columns
              else {
                AppInfo appInfo = snapshot.data as AppInfo;

                return NavigationBody(index: index, children: [
                  BibleView(
                    appInfo: appInfo,
                    numberOfColumns: numberOfColumns,
                    deleteColumn: deleteColumn,
                  ), //main view
                  //must include dummy destination here for each custom action, apparently

                  BibleView(
                    appInfo: snapshot.data as AppInfo,
                    numberOfColumns: numberOfColumns,
                    deleteColumn: deleteColumn,
                  ), //taking place of Search BibleView

                  BibleView(
                    appInfo: snapshot.data as AppInfo,
                    numberOfColumns: numberOfColumns,
                    deleteColumn: deleteColumn,
                  ), //taking place of add a pane

                  BibleView(
                    appInfo: snapshot.data as AppInfo,
                    numberOfColumns: numberOfColumns,
                    deleteColumn: deleteColumn,
                  ), //taking place of toggle light/dark mode

                  Settings(controller: settingsController),
                ]);
              }
            }));
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('Confirm close'),
            content: const Text('Are you sure you want to close this window?'),
            actions: [
              FilledButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              Button(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = FluentTheme.of(context).copyWith();

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

class RunFunctionPaneItemAction extends PaneItem {
  RunFunctionPaneItemAction({
    required Widget icon,
    required this.functionToRun, //pass in the function
    title,
    infoBadge,
    focusNode,
    autofocus = false,
  }) : super(
          icon: icon,
          title: title,
          infoBadge: infoBadge,
          focusNode: focusNode,
          autofocus: autofocus,
        );
  Function functionToRun;
  @override
  Widget build(BuildContext context, bool selected, VoidCallback? onPressed,
      {PaneDisplayMode? displayMode,
      bool showTextOnTop = true,
      bool? autofocus}) {
    // Runs this function - referencing the function passed in above
    internalCaller() {
      functionToRun();
    }

    return super.build(context, selected, internalCaller);
  }
}

class LightDarkModePaneItemAction extends PaneItem {
  LightDarkModePaneItemAction({
    required Widget icon,
    required this.appTheme,
    title,
    infoBadge,
    focusNode,
    autofocus = false,
  }) : super(
          icon: icon,
          title: title,
          infoBadge: infoBadge,
          focusNode: focusNode,
          autofocus: autofocus,
        );
  final AppTheme appTheme;
  @override
  Widget build(BuildContext context, bool selected, VoidCallback? onPressed,
      {PaneDisplayMode? displayMode,
      bool showTextOnTop = true,
      bool? autofocus}) {
    //Runs this function
    switchThemeMode() {
      /*Couple of cases here - by default it's set to user theme mode, but we want 
      to offer a way to change that easily. So account for whether the system theme
      mode is dark or light, and switch to an expressly declared light or dark*/
      switch (appTheme.mode) {
        case ThemeMode.system:
          bool dark =
              (MediaQuery.of(context).platformBrightness == Brightness.dark);
          if (dark) {
            appTheme.mode = ThemeMode.light;
          } else {
            appTheme.mode = ThemeMode.dark;
          }
          break;
        case ThemeMode.dark:
          appTheme.mode = ThemeMode.light;
          break;
        case ThemeMode.light:
          appTheme.mode = ThemeMode.dark;
          break;
        default:
          appTheme.mode = ThemeMode.dark;
      }
    }

    return super.build(context, selected, switchThemeMode);
  }
}

class _LinkPaneItemAction extends PaneItem {
  _LinkPaneItemAction({
    required Widget icon,
    required this.link,
    title,
    infoBadge,
    focusNode,
    autofocus = false,
  }) : super(
          icon: icon,
          title: title,
          infoBadge: infoBadge,
          focusNode: focusNode,
          autofocus: autofocus,
        );

  final String link;

  @override
  Widget build(
    BuildContext context,
    bool selected,
    VoidCallback? onPressed, {
    PaneDisplayMode? displayMode,
    bool showTextOnTop = true,
    bool? autofocus,
  }) {
    return Link(
      uri: Uri.parse(link),
      builder: (context, followLink) => super.build(
        context,
        selected,
        followLink,
        displayMode: displayMode,
        showTextOnTop: showTextOnTop,
        autofocus: autofocus,
      ),
    );
  }
}
