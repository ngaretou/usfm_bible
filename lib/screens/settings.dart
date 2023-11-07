import 'package:flutter/foundation.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:usfm_bible/main.dart';
import '../logic/database_builder.dart';
import '../providers/user_prefs.dart';

import '../theme.dart';

const List<String> accentColorNames = [
  'System',
  'Yellow',
  'Orange',
  'Red',
  'Magenta',
  'Purple',
  'Blue',
  'Teal',
  'Green',
];

bool get kIsWindowEffectsSupported {
  return !kIsWeb &&
      [
        TargetPlatform.windows,
        TargetPlatform.linux,
        TargetPlatform.macOS,
      ].contains(defaultTargetPlatform);
}

const linuxWindowEffects = [
  WindowEffect.disabled,
  WindowEffect.transparent,
];

const windowsWindowEffects = [
  WindowEffect.disabled,
  WindowEffect.solid,
  WindowEffect.transparent,
  WindowEffect.aero,
  WindowEffect.acrylic,
  WindowEffect.mica,
  WindowEffect.tabbed,
];

const macosWindowEffects = [
  WindowEffect.disabled,
  WindowEffect.titlebar,
  WindowEffect.selection,
  WindowEffect.menu,
  WindowEffect.popover,
  WindowEffect.sidebar,
  WindowEffect.headerView,
  WindowEffect.sheet,
  WindowEffect.windowBackground,
  WindowEffect.hudWindow,
  WindowEffect.fullScreenUI,
  WindowEffect.toolTip,
  WindowEffect.contentBackground,
  WindowEffect.underWindowBackground,
  WindowEffect.underPageBackground,
];

List<WindowEffect> get currentWindowEffects {
  if (kIsWeb) return [];

  if (defaultTargetPlatform == TargetPlatform.windows) {
    return windowsWindowEffects;
  } else if (defaultTargetPlatform == TargetPlatform.linux) {
    return linuxWindowEffects;
  } else if (defaultTargetPlatform == TargetPlatform.macOS) {
    return macosWindowEffects;
  }

  return [];
}

class Settings extends StatelessWidget {
  const Settings({super.key, this.controller});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    // print('settings page build');
    assert(debugCheckHasMediaQuery(context));
    final appTheme = context.watch<AppTheme>();

    const spacer = SizedBox(height: 10.0);
    const biggerSpacer = SizedBox(height: 40.0);

    // final supportedLocales = const AppLocalizationDelegate().supportedLocales;
    // final currentLocale =
    //     appTheme.locale ?? Localizations.maybeLocaleOf(context);

    return ScaffoldPage.scrollable(
      header: PageHeader(
          title: Text(Provider.of<UserPrefs>(context, listen: true)
              .currentTranslation
              .settings)),
      scrollController: controller,
      children: [
        Text(
            Provider.of<UserPrefs>(context, listen: true)
                .currentTranslation
                .settingsInterfaceLanguage,
            style: FluentTheme.of(context).typography.subtitle),
        spacer,
        SizedBox(
          width: 150,
          child: ComboBox<String>(
            isExpanded: true,
            items: translations
                .map((e) => ComboBoxItem<String>(
                      value: e.langCode,
                      child: Text(
                        e.langName,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: Provider.of<UserPrefs>(context, listen: false)
                .currentTranslation
                .langCode,
            onChanged: (value) {
              Provider.of<UserPrefs>(context, listen: false).setUserLang =
                  value!;
              userPrefsBox.put('savedUserLang', value);
            },
          ),
        ),
        biggerSpacer,
        Text(
            Provider.of<UserPrefs>(context, listen: false)
                .currentTranslation
                .settingsTheme,
            style: FluentTheme.of(context).typography.subtitle),
        spacer,
        ...List.generate(ThemeMode.values.length, (index) {
          String label = '';
          final mode = ThemeMode.values[index];
          switch (index) {
            case 0:
              label = Provider.of<UserPrefs>(context, listen: false)
                  .currentTranslation
                  .systemTheme;
              break;
            case 1:
              label = Provider.of<UserPrefs>(context, listen: false)
                  .currentTranslation
                  .lightTheme;
              break;
            case 2:
              label = Provider.of<UserPrefs>(context, listen: false)
                  .currentTranslation
                  .darkTheme;
              break;
            default:
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: RadioButton(
              checked: appTheme.mode == mode,
              onChanged: (value) async {
                if (value) {
                  appTheme.mode = mode;

                  Box userPrefsBox = await Hive.openBox('userPrefs');
                  userPrefsBox.put('themeMode', mode.toString());
                  // userPrefsBox.close();

                  // if (kIsWindowEffectsSupported) {
                  //   // some window effects require on [dark] to look good.
                  //   // appTheme.setEffect(WindowEffect.disabled, context);
                  //   appTheme.setEffect(appTheme.windowEffect, context);
                  // }
                }
              },
              // content: Text('$mode'.replaceAll('ThemeMode.', '')),
              content: Text(label),
            ),
          );
        }),
        biggerSpacer,
        // Text(
        //   'Navigation Pane Display Mode',
        //   style: FluentTheme.of(context).typography.subtitle,
        // ),
        // spacer,
        // ...List.generate(PaneDisplayMode.values.length, (index) {
        //   final mode = PaneDisplayMode.values[index];

        //   return Padding(
        //     padding: const EdgeInsets.only(bottom: 8.0),
        //     child: RadioButton(
        //       checked: appTheme.displayMode == mode,
        //       onChanged: (value) {
        //         // print(mode.toString());
        //         if (value) appTheme.displayMode = mode;
        //       },
        //       content: Text(
        //         mode.toString().replaceAll('PaneDisplayMode.', ''),
        //       ),
        //     ),
        //   );
        // }),
        // biggerSpacer,
        // Text('Navigation Indicator',
        //     style: FluentTheme.of(context).typography.subtitle),
        // spacer,
        // ...List.generate(NavigationIndicators.values.length, (index) {
        //   final mode = NavigationIndicators.values[index];
        //   return Padding(
        //     padding: const EdgeInsets.only(bottom: 8.0),
        //     child: RadioButton(
        //       checked: appTheme.indicator == mode,
        //       onChanged: (value) {
        //         if (value) appTheme.indicator = mode;
        //       },
        //       content: Text(
        //         mode.toString().replaceAll('NavigationIndicators.', ''),
        //       ),
        //     ),
        //   );
        // }),
        // biggerSpacer,
        // Text('Accent Color',
        //     style: FluentTheme.of(context).typography.subtitle),
        // spacer,
        Wrap(children: [
          // Tooltip(
          //   message: accentColorNames[0],
          //   child: _buildColorBlock(appTheme, systemAccentColor, 0),
          // ),
          ...List.generate(Colors.accentColors.length, (index) {
            final color = Colors.accentColors[index];
            return Tooltip(
              message: accentColorNames[index + 1],
              child: _buildColorBlock(appTheme, color, index),
            );
          }),
        ]),
        // if (kIsWindowEffectsSupported) ...[
        //   biggerSpacer,
        //   Text(
        //     'Window Transparency (${defaultTargetPlatform.toString().replaceAll('TargetPlatform.', '')})',
        //     style: FluentTheme.of(context).typography.subtitle,
        //   ),
        //   spacer,
        //   ...List.generate(currentWindowEffects.length, (index) {
        //     final mode = currentWindowEffects[index];
        //     return Padding(
        //       padding: const EdgeInsets.only(bottom: 8.0),
        //       child: RadioButton(
        //         checked: appTheme.windowEffect == mode,
        //         onChanged: (value) {
        //           if (value) {
        //             appTheme.windowEffect = mode;
        //             appTheme.setEffect(mode, context);
        //           }
        //         },
        //         content: Text(
        //           mode.toString().replaceAll('WindowEffect.', ''),
        //         ),
        //       ),
        //     );
        //   }),
        // ],
        // biggerSpacer,
        // Text('Text Direction',
        //     style: FluentTheme.of(context).typography.subtitle),
        // spacer,
        // ...List.generate(TextDirection.values.length, (index) {
        //   final direction = TextDirection.values[index];
        //   return Padding(
        //     padding: const EdgeInsets.only(bottom: 8.0),
        //     child: RadioButton(
        //       checked: appTheme.textDirection == direction,
        //       onChanged: (value) {
        //         if (value) {
        //           appTheme.textDirection = direction;
        //         }
        //       },
        //       content: Text(
        //         '$direction'
        //             .replaceAll('TextDirection.', '')
        //             .replaceAll('rtl', 'Right to left')
        //             .replaceAll('ltr', 'Left to right'),
        //       ),
        //     ),
        //   );
        // }).reversed,
        // Text('Locale', style: FluentTheme.of(context).typography.subtitle),
        // spacer,
        // Wrap(
        //   spacing: 15.0,
        //   runSpacing: 10.0,
        //   children: List.generate(
        //     supportedLocales.length,
        //     (index) {
        //       final locale = supportedLocales[index];

        //       return Padding(
        //         padding: const EdgeInsets.only(bottom: 8.0),
        //         child: RadioButton(
        //           checked: currentLocale == locale,
        //           onChanged: (value) {
        //             if (value) {
        //               appTheme.locale = locale;
        //             }
        //           },
        //           content: Text('$locale'),
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }

  Widget _buildColorBlock(AppTheme appTheme, AccentColor color, int index) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Button(
        onPressed: () {
          appTheme.color = color;

          userPrefsBox.put('colorIndex', index);
        },
        style: ButtonStyle(
          padding: ButtonState.all(EdgeInsets.zero),
          backgroundColor: ButtonState.resolveWith((states) {
            if (states.isPressing) {
              return color.light;
            } else if (states.isHovering) {
              return color.lighter;
            }
            return color;
          }),
        ),
        child: Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          child: appTheme.color == color
              ? Icon(
                  FluentIcons.check_mark,
                  color: color.basedOnLuminance(),
                  size: 22.0,
                )
              : null,
        ),
      ),
    );
  }
}
