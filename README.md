# usfm_bible

An extension of Scripture App Builder primarily for web apps but also can be used to produce Windows and macOS apps.

## Getting Started

### To use built web version:

- Copy contents of SAB .appDef and \_data folder into the assets/project folder - _rename_ your appDef file to "appDef.appDef" and your data file to "data".
- Change app name and favicon in index.html.

### To use in Flutter for desktop build:

- Do the same in your Visual Code or your IDE.
- Copy contents of SAB .appDef and \_data folder into the assets/project folder - _rename_ your appDef file to "appDef.appDef" and your data file to "data".
- Change app name in pubspec.yaml, (macOS? Windows?)

### Be aware

Book Collection ID must follow C01, C02 pattern.

## TODO:

Remember window size and position, column references visible on close...
Figure out localizations from appDef rather than from Flutter localizations

Change window title on desktop

https://stackoverflow.com/questions/64800455/how-to-change-app-icon-and-app-name-for-flutter-desktop-application

Global options: Add column, Search, Contact Us, About
Each translation options: font size up and down, Remove columns - remove the one you are clicking the thing on
