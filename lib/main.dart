import 'dart:async';

// import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';

import 'package:url_strategy/url_strategy.dart';
import 'package:url_launcher/link.dart';
import 'package:window_manager/window_manager.dart';
import 'package:context_menus/context_menus.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pwa_install/pwa_install.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/about.dart';
import 'screens/bible_view.dart';
import 'screens/settings.dart';

import 'widgets/onboarding_panel.dart';

import 'theme.dart';
import 'logic/database_builder.dart';

import 'providers/user_prefs.dart';
import 'providers/column_manager.dart';

import '../hive/user_columns_db.dart';

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

late Box<UserColumnsDB> userColumnsBox;
late Box userPrefsBox;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Keep native splash screen up until app is finished bootstrapping
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  PWAInstall().setup(
      //   installCallback: () {
      //   debugPrint('APP INSTALLED!');
      // }
      );

// Hive stores its files in ApplicationDocumentsDirectory - for most platforms this works great, but Windows it stores these three files in the Documents directory. Yuck.
// We've changed that now wtih await Hive.initFlutter('KaddugYalla'); but clean it up if a user has that old version.

  if (!kIsWeb && Platform.isWindows) {
    List<String> filesToMove = [
      'parsedlinedb.hive',
      'parsedlinedb.lock',
      'usercolumnsdb.hive',
      'usercolumnsdb.lock',
      'userprefs.hive',
      'userprefs.lock'
    ];

    String dir = (await getApplicationDocumentsDirectory()).path;

    for (var file in filesToMove) {
      String oldPath = '$dir/$file';
      String newPath = '$dir/KaddugYalla/$file';
      try {
        bool fileExists = await File(oldPath).exists();
        if (fileExists) {
          bool fileExistsInSubfolder = await File(newPath).exists();
          if (!fileExistsInSubfolder) {
            File(oldPath).copy(newPath).then((_) => File(oldPath).delete());
          } else {
            File(oldPath).delete();
          }
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  await Hive.initFlutter('KaddugYalla');
  Hive.registerAdapter(UserColumnsDBAdapter());

  userColumnsBox = await Hive.openBox<UserColumnsDB>('userColumnsDB');

  userPrefsBox = await Hive.openBox('userPrefs');

  // if it's not on the web, windows or android, load the accent color
  if (!kIsWeb &&
      [
        TargetPlatform.windows,
        TargetPlatform.android,
      ].contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }

  setPathUrlStrategy();
// No firebase for Windows yet so don't initialize it in that case, but do in other cases
  if (kIsWeb || !Platform.isWindows) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  if (isDesktop) {
    await flutter_acrylic.Window.initialize();
    await WindowManager.instance.ensureInitialized();

    windowManager.waitUntilReadyToShow().then((_) async {
      if (Platform.isWindows) {
        await windowManager.setTitleBarStyle(
          TitleBarStyle.hidden,
          // windowButtonVisibility: true,
        );
      } else {
        await windowManager.setTitleBarStyle(
          TitleBarStyle.normal,
          windowButtonVisibility: true,
        );
      }

      double? windowWidth = userPrefsBox.get('windowWidth');
      double? windowHeight = userPrefsBox.get('windowHeight');
      if (windowHeight == null || windowWidth == null) {
        windowWidth = 1000;
        windowHeight = 650;
      }

      await windowManager.setSize(Size(windowWidth, windowHeight));
      await windowManager.setMinimumSize(const Size(600, 650));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setPreventClose(false);
      await windowManager.setSkipTaskbar(false);
    });
  }

  // print('runApp');
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

final _appTheme = AppTheme();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // print('myapp build');
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
      // trackBorderColor: Color.fromARGB(85, 126, 126, 126),
      // hoveringTrackBorderColor: Color.fromARGB(85, 126, 126, 126),
      padding: EdgeInsets.all(0),
      hoveringPadding: EdgeInsets.all(0),
    );

    Future<String> getAppTitle() async {
      var response = await asyncGetProjectName(context);
      return response;
    }

    late Future<String> initAppInfo = getAppTitle();
    // print('initAppInfo');
    return ChangeNotifierProvider.value(
      value: _appTheme,
      builder: (context, _) {
        final appTheme = context.watch<AppTheme>();

        late SystemUiOverlayStyle style;
        if (appTheme.mode == ThemeMode.dark) {
          style = SystemUiOverlayStyle.light;
        } else {
          style = SystemUiOverlayStyle.dark;
        }

        SystemChrome.setSystemUIOverlayStyle(style);
        // print('about to hit FutureBuilder line 191');
        return FutureBuilder(
            future: initAppInfo,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const material.Center(
                    child: material.CircularProgressIndicator());
              } else {
                // print(appTheme.color.toString());
                appTitle = snapshot.data.toString();
                return FluentApp(
                  title: appTitle,
                  themeMode: appTheme.mode,
                  debugShowCheckedModeBanner: false,
                  home: MyHomePage(
                    appTheme: appTheme,
                  ),
                  color: appTheme.color,
                  // color: Colors.black,
                  darkTheme: FluentThemeData(
                    brightness: Brightness.dark,
                    accentColor: appTheme.color,
                    visualDensity: VisualDensity.standard,
                    // focusTheme: FocusThemeData(
                    //   glowFactor: is10footScreen() ? 2.0 : 0.0,
                    // ),
                    scrollbarTheme: scrollBarTheme,
                  ),
                  theme: FluentThemeData(
                    accentColor: appTheme.color,

                    visualDensity: VisualDensity.standard,
                    // focusTheme: FocusThemeData(
                    //   glowFactor: is10footScreen() ? 2.0 : 0.0,
                    // ),
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
  final AppTheme appTheme;

  const MyHomePage({super.key, required this.appTheme});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with WindowListener {
  int index = 0;

  final settingsController = ScrollController();
  final viewKey = GlobalKey();
  // Size windowSize = const Size(500, 500);
  // late bool isFullScreen;
  ValueNotifier<double> myProgress = ValueNotifier(0);

  void updateProgress(double progress) {
    // // print(progress);

    myProgress.value = progress;
  }

  Future<AppInfo> callInititalization() async {
    // String response = await asyncGetProjectName(context);
    // appTitle = response;
    UserPrefs userPrefs = Provider.of<UserPrefs>(context, listen: false);
    AppInfo appInfo = await buildDatabaseFromXML(context, updateProgress);
    await userPrefs.loadUserPrefs(appInfo);

    return appInfo;
  }

  Future<void> callInterfaceInitialization() async {
    await asyncGetTranslations(context);
  }

  late Future<AppInfo> initAppInfo = callInititalization();
  late Future<void> initInterface = callInterfaceInitialization();

  @override
  void initState() {
    // print('MyHomePageState initState');
    windowManager.addListener(this);

    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    settingsController.dispose();
    super.dispose();
  }

  Future<void> saveWindowSize() async {
    Size media = await windowManager.getSize();
    userPrefsBox.put('windowHeight', media.height);
    userPrefsBox.put('windowWidth', media.width);
  }

  @override
  void onWindowResize() {
    if (isDesktop) {
      saveWindowSize();
    }
  }

  //This works as far as it goes - the problem is that it can't detect when we are already in full screen.
  // void goFullScreen() {
  //   html.document.documentElement?.requestFullscreen();
  // }

  // void exitFullScreen() {
  //   html.document.exitFullscreen();
  // }

  // void toggleFullScreen() {
  //   if (isFullScreen) {
  //     html.document.exitFullscreen();
  //   } else {
  //     html.document.documentElement?.requestFullscreen();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // print('MyHomePageState build');
    bool? hasSeenOnboarding = userPrefsBox.get('hasSeenOnboarding');

    if (hasSeenOnboarding == null && appTitle == "Kàddug Yàlla") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // If Wolof ...

        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return const Center(child: OnboardingPanel());
            });
        //save that the user has seen the onboarding
        userPrefsBox.put('hasSeenOnboarding', true);
      });
    }

    return FutureBuilder(
      future: initInterface,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: ProgressRing());
        } else {
          List<NavigationPaneItem> finalNavPaneItems = [];

          //For Wolof only and on web only on biblewolof.com
          List<NavigationPaneItem> wolofWebOnlyNavPaneItems = [
            if (kIsWeb)
              PaneItemAction(
                  icon: const Icon(FluentIcons.download),
                  title: const Text('Yebal appli bi ci sa ordinatër'),
                  onTap: () {
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) {
                          return const Center(
                              child: OnboardingPanel(
                            appDownloadOnly: true,
                          ));
                        });
                  }),

            //More apps
            _LinkPaneItemAction(
              icon: const Icon(FluentIcons.app_icon_default),
              title: const Text('Yeneen appli'),
              link: 'https://sng.al/app',
              body: const SizedBox.shrink(),
            ),
            //Contact

            _LinkPaneItemAction(
              icon: const Icon(FluentIcons.mail),
              title: const Text('Bind nu'),
              link:
                  'http://currah.download/pages/wolof/bible/contact/index.html',
              body: const SizedBox.shrink(),
            ),
            //Listen
            _LinkPaneItemAction(
              icon: const Icon(FluentIcons.play),
              // FluentIcons.m_s_n_videos_solid
              // FluentIcons.play_solid
              // FluentIcons.read_out_loud
              title: const Text('Dégglul Kàddu gi'),
              link:
                  'http://currah.download/pages/wolof/bible/html/deglu_kaddu_gi.html',
              body: const SizedBox.shrink(),
            ),
            //Download
            _LinkPaneItemAction(
              icon: const Icon(FluentIcons.cloud_download),
              title: const Text('Yebal téerey Kàddu gi'),
              link:
                  'http://currah.download/pages/wolof/bible/html/biblewolof.html',
              body: const SizedBox.shrink(),
            ),
            //More

            _LinkPaneItemAction(
              icon: const Icon(FluentIcons.developer_tools),
              title: const Text('Téere baati wolof'),
              link: 'http://currah.download/pages/dictionnairewolof/',
              body: const SizedBox.shrink(),
            ),

            _LinkPaneItemAction(
              icon: const Icon(FluentIcons.toolbox),
              title: const Text('Jumtukaay wolofal'),
              link: 'http://currah.download/pages/ajamisenegal/index.html',
              body: const SizedBox.shrink(),
            ),
          ];

          //Normal pane items we always use
          List<NavigationPaneItem> normalNavPaneItems = [
            PaneItemSeparator(),
            //Search

            RunFunctionPaneItemAction(
                body: const About(),
                title: Text(Provider.of<UserPrefs>(context, listen: true)
                    .currentTranslation
                    .search),
                icon: const Icon(FluentIcons.search),
                functionToRun:
                    Provider.of<ColumnManager>(context, listen: false)
                        .toggleSearch),
            //Add Column
            RunFunctionPaneItemAction(
                body: const About(),
                title: Text(Provider.of<UserPrefs>(context, listen: true)
                    .currentTranslation
                    .addColumn),
                icon: const Icon(FluentIcons.calculator_addition),
                functionToRun:
                    Provider.of<ColumnManager>(context, listen: false)
                        .addColumn),
            //Light Dark Toggle
            PaneItemAction(
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
              onTap: () {
                Future<void> saveThemeMode(String themeMode) async {
                  Box userPrefsBox = await Hive.openBox('userPrefs');
                  userPrefsBox.put('themeMode', themeMode);
                  // userPrefsBox.close();
                }

                /*Couple of cases here - by default it's set to user theme mode, but we want 
                to offer a way to change that easily. So account for whether the system theme
                mode is dark or light, and switch to an expressly declared light or dark*/
                switch (widget.appTheme.mode) {
                  case ThemeMode.system:
                    bool dark = (MediaQuery.of(context).platformBrightness ==
                        Brightness.dark);
                    if (dark) {
                      widget.appTheme.mode = ThemeMode.light;
                    } else {
                      widget.appTheme.mode = ThemeMode.dark;
                    }
                    break;
                  case ThemeMode.dark:
                    widget.appTheme.mode = ThemeMode.light;
                    break;
                  case ThemeMode.light:
                    widget.appTheme.mode = ThemeMode.dark;
                    break;
                  default:
                    widget.appTheme.mode = ThemeMode.dark;
                }
                saveThemeMode(widget.appTheme.mode.toString());
              },
            ),

            PaneItemSeparator(),
            //About
            PaneItem(
                body: const About(),
                icon: const Icon(FluentIcons.info),
                title: Text(Provider.of<UserPrefs>(context, listen: true)
                    .currentTranslation
                    .about)),
            PaneItem(
              body: Settings(controller: settingsController),
              icon: const Icon(FluentIcons.settings),
              title: Text(Provider.of<UserPrefs>(context, listen: true)
                  .currentTranslation
                  .settings),
            ),
          ];

          //Set up the navPaneItems - note that if the name of the wolof app gets changed by one char it will not work
          if (appTitle == "Kàddug Yàlla") {
            finalNavPaneItems.addAll(wolofWebOnlyNavPaneItems);
            finalNavPaneItems.addAll(normalNavPaneItems);
          } else {
            finalNavPaneItems.addAll(normalNavPaneItems);
          }

          return ContextMenuOverlay(
            buttonStyle: ContextMenuButtonStyle(
              fgColor: DefaultTextStyle.of(context).style.color,
              hoverFgColor: DefaultTextStyle.of(context).style.color,
            ),
            cardBuilder: (_, children) => Container(
                decoration: BoxDecoration(
                  backgroundBlendMode: BlendMode.srcOver,
                  color: FluentTheme.of(context).menuColor,
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

              appBar: !kIsWeb && Platform.isWindows
                  ? NavigationAppBar(
                      height: 30,
                      automaticallyImplyLeading: false,
                      title: () {
                        if (kIsWeb) return Text(appTitle);
                        return DragToMoveArea(
                          child: Row(
                            children: [
                              const SizedBox(width: 15),
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(appTitle),
                              ),
                            ],
                          ),
                        );
                      }(),
                      actions: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //     IconButton(
                          //         icon: const Icon(FluentIcons.add),
                          //         onPressed: () {
                          //           numberOfColumns <= 3 //keep it to four columns
                          //               ? changeNumberColumns(add: true)
                          //               : null;

                          //           // setState(() {});
                          //         }),

                          //     // Spacer(),

                          WindowButtons()
                        ],
                      ),
                    )
                  : const NavigationAppBar(
                      automaticallyImplyLeading: false, height: 4),
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
                  displayMode: widget.appTheme.displayMode,
                  indicator: () {
                    switch (widget.appTheme.indicator) {
                      case NavigationIndicators.end:
                        return const EndNavigationIndicator();
                      case NavigationIndicators.sticky:
                      default:
                        return const StickyNavigationIndicator();
                    }
                  }(),
                  items: [
                    PaneItem(
                      body: FutureBuilder(
                        future: initAppInfo,
                        builder: (ctx, snapshot) {
                          // Remove splash screen when bootstrap is complete
                          FlutterNativeSplash.remove();

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return ValueListenableBuilder<double>(
                                valueListenable: myProgress,
                                builder: (context, val, child) {
                                  if (val == 0) {
                                    return const Center(child: ProgressRing());
                                  } else {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            ProgressRing(value: val),
                                            if (val.ceil() != 100)
                                              Text('${val.ceil().toString()}%',
                                                  style: const TextStyle(
                                                      fontSize: 10))
                                          ],
                                        ),
                                        SizedBox(
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2) -
                                                70),
                                        if (kIsWeb &&
                                            appTitle == "Kàddug Yàlla")
                                          Button(
                                              onPressed: () async {
                                                const url =
                                                    'https://biblewolof.com/av/';
                                                if (await canLaunchUrl(
                                                    Uri.parse(url))) {
                                                  await launchUrl(
                                                      Uri.parse(url),
                                                      webOnlyWindowName:
                                                          "_self");
                                                } else {
                                                  throw 'Could not launch $url';
                                                }
                                              },
                                              child: const Text(
                                                  'Dafa yeex ba ëpp, demal ci version bu weesu')),
                                        const SizedBox(
                                          height: 30,
                                        )
                                      ],
                                    );
                                  }
                                });
                          }
                          //Main row that holds the text columns
                          else {
                            AppInfo appInfo = snapshot.data as AppInfo;
                            //Sets a default in case there is no RTL below
                            late String comboBoxFont =
                                collections.first.fonts.first.fontFamily;
                            bool anyRTL = collections.any(
                                (element) => element.textDirection != 'LTR');

                            if (anyRTL) {
                              String font = collections
                                  .firstWhere((element) =>
                                      element.textDirection == 'RTL')
                                  .fonts
                                  .first
                                  .fontFamily;
                              comboBoxFont = font;
                            }

                            return BibleView(
                                appInfo: appInfo, comboBoxFont: comboBoxFont);
                          }
                        },
                      ),
                      icon: const Icon(FluentIcons.reading_mode),
                      title: Text(appTitle),
                    ),
                  ],
                  footerItems: finalNavPaneItems),
            ),
          );
        }
      },
    );
  }

  @override
  void onWindowClose() async {
    // print('closing');
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      if (!mounted) return;
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
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);

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
    required super.icon,
    required this.functionToRun, //pass in the function
    required super.body,
    super.title,
    super.infoBadge,
    super.focusNode,
    super.autofocus = false,
  });
  Function functionToRun;
  @override
  Widget build(
    BuildContext context,
    bool selected,
    VoidCallback? onPressed, {
    PaneDisplayMode? displayMode,
    bool showTextOnTop = true,
    bool? autofocus,
    int? itemIndex,
  }) {
    // Runs this function - referencing the function passed in above
    internalCaller() {
      functionToRun();
    }

    return super.build(context, selected, internalCaller);
  }
}

class LightDarkModePaneItemAction extends PaneItem {
  LightDarkModePaneItemAction({
    required super.icon,
    required this.appTheme,
    super.title,
    super.infoBadge,
    super.focusNode,
    super.autofocus = false,
  }) : super(
          body: const About(),
        );
  final AppTheme appTheme;
  @override
  Widget build(
    BuildContext context,
    bool selected,
    VoidCallback? onPressed, {
    PaneDisplayMode? displayMode,
    bool showTextOnTop = true,
    bool? autofocus,
    int? itemIndex,
  }) {
    Future<void> saveThemeMode(String themeMode) async {
      Box userPrefsBox = await Hive.openBox('userPrefs');
      userPrefsBox.put('themeMode', themeMode);
      // userPrefsBox.close();
    }

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
      saveThemeMode(appTheme.mode.toString());
    }

    return super.build(context, selected, switchThemeMode);
  }
}

class _LinkPaneItemAction extends PaneItem {
  final String link;

  _LinkPaneItemAction({
    required this.link,
    required super.icon,
    required super.body,
    super.title,
  });

  @override
  Widget build(
    BuildContext context,
    bool selected,
    VoidCallback? onPressed, {
    PaneDisplayMode? displayMode,
    bool showTextOnTop = true,
    bool? autofocus,
    int? itemIndex,
  }) {
    return Link(
      target: LinkTarget.blank, //opens in new tab on web
      uri: Uri.parse(link),
      builder: (context, followLink) => super.build(
        context,
        selected,
        followLink,
        displayMode: displayMode,
        showTextOnTop: showTextOnTop,
        itemIndex: itemIndex,
        autofocus: autofocus,
      ),
    );
  }
}
