// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:window_manager/window_manager.dart';
import 'package:context_menus/context_menus.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'screens/about.dart';
import 'screens/bible_view.dart';
import 'screens/settings.dart';

import 'theme.dart';
import 'logic/database_builder.dart';

import 'providers/user_prefs.dart';
import 'providers/column_manager.dart';

String appTitle = '';

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
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Keep native splash screen up until app is finished bootstrapping
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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
      // await windowManager.setSize(const Size(1400, 700));
      await windowManager.setMinimumSize(const Size(600, 600));
      // await windowManager.center();
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => UserPrefs(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ScrollGroup(),
        ),
        //This seems a bit hacky but there are two buttons in the navpane that are hard to reference so this provider helps there
        ChangeNotifierProvider(
          create: (ctx) => ColumnManager(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollbarThemeData scrollBarTheme = const ScrollbarThemeData(
      thickness: 6.0,
      hoveringThickness: 6.0,
      // backgroundColor: Color.fromARGB(204, 126, 126, 126),
      // scrollbarColor: Color.fromARGB(204, 37, 31, 125),
      // scrollbarPressingColor: Color.fromARGB(204, 18, 98, 54),
      // radius: const Radius.circular(100.0),
      // hoveringRadius: const Radius.circular(100.0),
      mainAxisMargin: 4.0, hoveringMainAxisMargin: 4.0,
      crossAxisMargin: 2.0, hoveringCrossAxisMargin: 2.0,
      minThumbLength: 48.0,
      trackBorderColor: Color.fromARGB(85, 126, 126, 126),
      hoveringTrackBorderColor: Color.fromARGB(85, 126, 126, 126),
      padding: EdgeInsets.all(0),
      hoveringPadding: EdgeInsets.all(0),
    );

    Future<String> getAppTitle() async {
      var response = await asyncGetProjectName(context);
      return response;
    }

    late Future<String> initAppInfo = getAppTitle();

    return ChangeNotifierProvider(
      create: (_) => AppTheme(),
      builder: (context, _) {
        final appTheme = context.watch<AppTheme>();

        return FutureBuilder(
            future: initAppInfo,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Container(
                  color: Colors.blue,
                ));
              } else {
                appTitle = snapshot.data.toString();
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
                    scrollbarTheme: scrollBarTheme,
                  ),
                  theme: ThemeData(
                    accentColor: appTheme.color,
                    visualDensity: VisualDensity.standard,
                    focusTheme: FocusThemeData(
                      glowFactor: is10footScreen() ? 2.0 : 0.0,
                    ),
                    scrollbarTheme: scrollBarTheme,
                  ),
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
              }
            });
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
  int index = 0;

  final settingsController = ScrollController();
  final viewKey = GlobalKey();

  Future<AppInfo> callInititalization() async {
    // String response = await asyncGetProjectName(context);
    // appTitle = response;

    AppInfo appInfo = await buildDatabaseFromXML(context);
    await Provider.of<UserPrefs>(context, listen: false).loadUserPrefs(appInfo);

    return appInfo;
  }

  Future<void> callInterfaceInitialization() async {
    await asyncGetTranslations(context);
  }

  late Future<AppInfo> initAppInfo = callInititalization();
  late Future<void> initInterface = callInterfaceInitialization();

  @override
  void dispose() {
    windowManager.removeListener(this);
    settingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();

    return FutureBuilder(
      future: initInterface,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: ProgressRing());
        } else {
          return ContextMenuOverlay(
            buttonStyle: ContextMenuButtonStyle(
              fgColor: DefaultTextStyle.of(context).style.color,
              hoverFgColor: DefaultTextStyle.of(context).style.color,
            ),
            cardBuilder: (_, children) => Container(
                decoration: BoxDecoration(
                  color: FluentTheme.of(context)
                      .acrylicBackgroundColor
                      .lerpWith(DefaultTextStyle.of(context).style.color!, .1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, //New
                        blurRadius: 25.0,
                        offset: Offset(0, 10))
                  ],
                ),
                width: 200,
                padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 6),
                // color: Colors.purple,
                child: Column(children: children)),
            child: NavigationView(
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
              //Main big row that holds the text columns
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
                  PaneItem(
                    icon: const Icon(FluentIcons.reading_mode),
                    title: Text(appTitle),
                  ),
                ],
                footerItems: [
                  //Actions label?
                  // PaneItemHeader(
                  //   header: Text('paneitemheader'),
                  // ),
                  PaneItemSeparator(),
                  RunFunctionPaneItemAction(
                      title: Text(Provider.of<UserPrefs>(context, listen: true)
                          .currentTranslation
                          .search),
                      icon: const Icon(FluentIcons.search),
                      functionToRun:
                          Provider.of<ColumnManager>(context, listen: false)
                              .openSearch),
                  RunFunctionPaneItemAction(
                      title: Text(Provider.of<UserPrefs>(context, listen: true)
                          .currentTranslation
                          .addColumn),
                      icon: const Icon(FluentIcons.calculator_addition),
                      functionToRun:
                          Provider.of<ColumnManager>(context, listen: false)
                              .addColumn),
                  LightDarkModePaneItemAction(
                    icon: FluentTheme.of(context).brightness.isDark
                        ? const Icon(FluentIcons.sunny)
                        : const Icon(FluentIcons.clear_night),
                    title: FluentTheme.of(context).brightness.isDark
                        ? Text(Provider.of<UserPrefs>(context, listen: true)
                            .currentTranslation
                            .lightTheme)
                        : Text(Provider.of<UserPrefs>(context, listen: true)
                            .currentTranslation
                            .darkTheme),
                    appTheme: appTheme,
                  ),

                  PaneItemSeparator(),
                  PaneItem(
                      icon: const Icon(FluentIcons.info),
                      title: Text(Provider.of<UserPrefs>(context, listen: true)
                          .currentTranslation
                          .about)),
                  PaneItem(
                    icon: const Icon(FluentIcons.settings),
                    title: Text(Provider.of<UserPrefs>(context, listen: true)
                        .currentTranslation
                        .settings),
                  ),
                  // _LinkPaneItemAction(
                  //   icon: const Icon(FluentIcons.open_source),
                  //   title: const Text('Source code'),
                  //   link: 'https://github.com/ngaretou/usfm_bible',
                  // ),
                ],
              ),
              content: FutureBuilder(
                future: initAppInfo,
                builder: (ctx, snapshot) {
                  // Remove splash screen when bootstrap is complete
                  FlutterNativeSplash.remove();
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: ProgressRing());
                  }
                  //Main row that holds the text columns
                  else {
                    AppInfo appInfo = snapshot.data as AppInfo;
                    late String comboBoxFont;
                    bool anyRTL = collections
                        .any((element) => element.textDirection != 'LTR');

                    if (anyRTL) {
                      String font = collections
                          .firstWhere(
                              (element) => element.textDirection == 'RTL')
                          .fonts
                          .first
                          .fontFamily;
                      comboBoxFont = font;
                    }

                    return NavigationBody(index: index, children: [
                      BibleView(
                          appInfo: appInfo,
                          comboBoxFont: comboBoxFont), //main view

                      //must include dummy destination here for each custom action, apparently

                      const About(), //taking place of Search

                      const About(), //taking place of add a pane

                      const About(), //taking place of toggle light/dark mode

                      const About(),

                      Settings(controller: settingsController),
                    ]);
                  }
                },
              ),
            ),
          );
        }
      },
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

// class _LinkPaneItemAction extends PaneItem {
//   _LinkPaneItemAction({
//     required Widget icon,
//     required this.link,
//     title,
//     infoBadge,
//     focusNode,
//     autofocus = false,
//   }) : super(
//           icon: icon,
//           title: title,
//           infoBadge: infoBadge,
//           focusNode: focusNode,
//           autofocus: autofocus,
//         );

//   final String link;

//   @override
//   Widget build(
//     BuildContext context,
//     bool selected,
//     VoidCallback? onPressed, {
//     PaneDisplayMode? displayMode,
//     bool showTextOnTop = true,
//     bool? autofocus,
//   }) {
//     return Link(
//       uri: Uri.parse(link),
//       builder: (context, followLink) => super.build(
//         context,
//         selected,
//         followLink,
//         displayMode: displayMode,
//         showTextOnTop: showTextOnTop,
//         autofocus: autofocus,
//       ),
//     );
//   }
// }
