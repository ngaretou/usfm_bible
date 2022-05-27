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

String appTitle = "appTitle";

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
  bool value = false;
  late Future init;
  int index = 0;

  final settingsController = ScrollController();
  final viewKey = GlobalKey();

  @override
  void initState() {
    windowManager.addListener(this);
    init = callInititalization();
    super.initState();
  }

  Future<void> callInititalization() async {
    appTitle = await asyncGetProjectName(context);
    //This gives the flutter UI a second to complete these above initialization processes
    //These should wait and this be unnecessary but the build happens before all these inits finish,
    //so this is a hack that helps
    // await Future.delayed(Duration(milliseconds: 3000));
    print('returning future from initialization');
    return;
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    settingsController.dispose();
    super.dispose();
  }

  Widget delayedAppTitle() {
    return FutureBuilder(
        future: init,
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: ProgressBar())
                : Text(appTitle));
  }

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

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();
    return NavigationView(
      key: viewKey,
      //appBar is across top of the screen in place of normal title bar.
      // appBar: NavigationAppBar(
      //   automaticallyImplyLeading: false,
      // title: () {
      //   if (kIsWeb) return delayedAppTitle();
      //   return DragToMoveArea(
      //     child: Row(
      //       children: [
      //         const SizedBox(width: 15),
      //         Align(
      //           alignment: AlignmentDirectional.centerStart,
      //           child: delayedAppTitle(),
      //         ),
      //       ],
      //     ),
      //   );
      // }(),
      // actions: Row(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: const [
      //     // Spacer(),

      //     // ToggleSwitch(
      //     //   content: const Text('Dark Mode'),
      //     //   checked: FluentTheme.of(context).brightness.isDark,
      //     //   onChanged: (v) {
      //     //     if (v) {
      //     //       appTheme.mode = ThemeMode.dark;
      //     //     } else {
      //     //       appTheme.mode = ThemeMode.light;
      //     //     }
      //     //   },
      //     // ),
      //     if (!kIsWeb) WindowButtons(),
      //   ],
      // ),
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
            title: const Text('Bible View'),
          ),
          // PaneItem(
          //   icon: const Icon(FluentIcons.text_field),
          //   title: const Text('Forms'),
          // ),
          // PaneItemSeparator(),
          // PaneItem(
          //   icon: const Icon(FluentIcons.color),
          //   title: const Text('Colors'),
          // ),
          // PaneItem(
          //   icon: const Icon(FluentIcons.icon_sets_flag),
          //   title: const Text('Icons'),
          // ),
          // PaneItem(
          //   icon: const Icon(FluentIcons.plain_text),
          //   title: const Text('Typography'),
          // ),
          // PaneItem(
          //   icon: const Icon(FluentIcons.cell_phone),
          //   title: const Text('Mobile'),
          // ),
          // PaneItem(
          //   icon: const Icon(FluentIcons.toolbox),
          //   title: const Text('Command bars'),
          // ),
          // PaneItem(
          //   icon: const Icon(FluentIcons.pop_expand),
          //   title: const Text('Flyouts'),
          // ),
          // PaneItem(
          //   icon: const Icon(FluentIcons.info),
          //   title: const Text('InfoBar'),
          // ),
          // PaneItem(
          //   icon: Icon(
          //     appTheme.displayMode == PaneDisplayMode.top
          //         ? FluentIcons.more
          //         : FluentIcons.more_vertical,
          //   ),
          //   title: const Text('Others'),
          //   infoBadge: const InfoBadge(
          //     source: Text('9'),
          //   ),
          // ),
        ],
        // autoSuggestBox: AutoSuggestBox(
        //   controller: TextEditingController(),
        //   items: const ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
        // ),
        // autoSuggestBoxReplacement: const Icon(FluentIcons.search),

        footerItems: [
          //Actions label?
          // PaneItemHeader(),
          PaneItemSeparator(),
          LightDarkModePaneItemAction(
            icon: FluentTheme.of(context).brightness.isDark
                ? const Icon(FluentIcons.clear_night)
                : const Icon(FluentIcons.clear_night),
            title: const Text('Light/Dark Toggle'),
            appTheme: appTheme,
          ),
          // PaneItem(
          //   icon: const Icon(FluentIcons.accessibilty_checker),
          //   title: const Text('Add new column'),
          // ),
          // CustomPaneItemAction(
          //   icon: const Icon(FluentIcons.calculator_addition),
          //   title: const Text('My new item'),
          // ),

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
      content: NavigationBody(index: index, children: [
        const BibleView(), //main view
        //must include dummy destination here for each custom action it seems
        const BibleView(), //toggle light

        Settings(controller: settingsController),
      ]),
    );
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
    final ThemeData theme = FluentTheme.of(context);

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

class CustomPaneItemAction extends PaneItem {
  CustomPaneItemAction({
    required Widget icon,
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

  @override
  Widget build(BuildContext context, bool selected, VoidCallback? onPressed,
      {PaneDisplayMode? displayMode,
      bool showTextOnTop = true,
      bool? autofocus}) {
    //Runs this function
    testingFunction() {
      print('testingFunction');
    }

    return super.build(context, selected, testingFunction);
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
      print('switchThemeMode ${appTheme.mode}');
      print('switchThemeMode ${appTheme.mode}');
      var brightness = MediaQuery.of(context).platformBrightness;
      print(brightness);

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
      }

      // Case the mode is explicitly set - change to opposite

      // if (appTheme.mode == ThemeMode.dark) {
      //   appTheme.mode = ThemeMode.light;
      // } else {
      //   appTheme.mode = ThemeMode.dark;
      // }

      // // Case the mode not set -- this will only
      // if (appTheme.mode == ThemeMode.system) {
      //   bool dark =
      //       (MediaQuery.of(context).platformBrightness == Brightness.dark);
      //   if (dark) {
      //     appTheme.mode = ThemeMode.light;
      //   } else {
      //     appTheme.mode = ThemeMode.dark;
      //   }
      // }
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
