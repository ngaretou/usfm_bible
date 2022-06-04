# usfm_bible

An extension of Scripture App Builder primarily for web apps but also can be used to produce Windows and macOS apps.

## Getting Started

### To use built web version:

- Copy contents of SAB .appDef and \_data folder into the assets/project folder
  - and _rename_ your appDef file to "appDef.appDef" and your data file to "data".
- Change font names in the project/data/fonts/ folder as follows:
  - main font - font1-R.ttf and font1-B.ttf
  - secondary font - font2-R.ttf and font2-B.ttf.
  - Note there must be those four fonts - if you only have one font, make copies and rename so those files are there. This is a hack to deal with a Flutter limitation and hopefully will be eliminated. https://docs.flutter.dev/cookbook/design/fonts#2-declare-the-font-in-the-pubspec
- In index.html:
  - Change app name
  - favicon
  - change _base href_ to your subfolder if your web app is not in the root of your site.

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

Figure out permissions - right now you have to manually change permissions to 744 for appdef and all sfm book files after output :(

Instead of plus and minus to make new columns on the columns, one add new column action on the pane and then 'x' close buttons on the columns only
