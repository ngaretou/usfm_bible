import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:system_theme/system_theme.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';

import '../main.dart';

enum NavigationIndicators { sticky, end }

ThemeMode getStoredThemeMode() {
  ThemeMode themeToSet = ThemeMode.system;
  switch (userPrefsBox.get('themeMode')) {
    case 'ThemeMode.system':
      themeToSet = ThemeMode.system;
      break;
    case 'ThemeMode.light':
      themeToSet = ThemeMode.light;
      break;
    case 'ThemeMode.dark':
      themeToSet = ThemeMode.dark;
      break;
    default:
      themeToSet = ThemeMode.system;
  }
  return themeToSet;
}

AccentColor getStoredColorByIndex() {
  AccentColor colorToReturn = systemAccentColor;
  int? savedColorIndex = userPrefsBox.get('colorIndex');
  if (savedColorIndex != null) {
    colorToReturn = Colors.accentColors[savedColorIndex];
  }

  return colorToReturn;
}

class AppTheme extends ChangeNotifier {
  AccentColor? _color = getStoredColorByIndex();
  AccentColor get color => _color ?? systemAccentColor;

  set color(AccentColor color) {
    _color = color;
    notifyListeners();
  }

  ThemeMode _mode = getStoredThemeMode();
  ThemeMode get mode => _mode;
  set mode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  PaneDisplayMode _displayMode = PaneDisplayMode.compact;
  PaneDisplayMode get displayMode => _displayMode;
  set displayMode(PaneDisplayMode displayMode) {
    _displayMode = displayMode;
    notifyListeners();
  }

  NavigationIndicators _indicator = NavigationIndicators.sticky;
  NavigationIndicators get indicator => _indicator;
  set indicator(NavigationIndicators indicator) {
    _indicator = indicator;
    notifyListeners();
  }

  WindowEffect _windowEffect = WindowEffect.disabled;
  WindowEffect get windowEffect => _windowEffect;
  set windowEffect(WindowEffect windowEffect) {
    _windowEffect = windowEffect;
    notifyListeners();
  }

  void setEffect(WindowEffect effect, BuildContext context) {
    Window.setEffect(
      effect: effect,
      color: [
        WindowEffect.solid,
        WindowEffect.acrylic,
      ].contains(effect)
          ? FluentTheme.of(context).micaBackgroundColor.withOpacity(0.05)
          : Colors.transparent,
      dark: FluentTheme.of(context).brightness.isDark,
    );
  }

  TextDirection _textDirection = TextDirection.ltr;
  TextDirection get textDirection => _textDirection;
  set textDirection(TextDirection direction) {
    _textDirection = direction;
    notifyListeners();
  }

  Locale? _locale;
  Locale? get locale => _locale;
  set locale(Locale? locale) {
    _locale = locale;
    notifyListeners();
  }
}

AccentColor get systemAccentColor {
  if ((defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.android) &&
      !kIsWeb) {
    return AccentColor('normal', {
      'darkest': SystemTheme.accentColor.darkest,
      'darker': SystemTheme.accentColor.darker,
      'dark': SystemTheme.accentColor.dark,
      'normal': SystemTheme.accentColor.accent,
      'light': SystemTheme.accentColor.light,
      'lighter': SystemTheme.accentColor.lighter,
      'lightest': SystemTheme.accentColor.lightest,
    });
  }
  return AccentColor('normal', {
    'normal': Colors.teal,
  });
  
}
