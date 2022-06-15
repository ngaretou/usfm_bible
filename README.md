# usfm_bible

An extension of [Scripture App Builder](https://software.sil.org/scriptureappbuilder/) primarily for web apps that also can be used to produce offline Windows and macOS.

To use the pre-built version for your SAB project, upload it to your web server, drop in your SAB project, and it generates a multi-collection multi-column web app.

Demo of current version at https://coreygarrett.org/usfm_bible/

[screenshot]: screenshot.png  "screenshot"

## Getting Started

### To use pre-built web version with your SAB project:

- Download /build/web/ folder contents and upload to your web server (or do the following and then upload).
- Delete existing contents of the assets/project/ folder.
- Copy contents of your SAB .appDef and \_data folder into the assets/project folder
  - and _rename_ your appDef file to "appDef.appDef" and your data file to "data".
- Change font names in the project/data/fonts/ folder as follows:
  - main font: _font1-R.ttf_ and _font1-B.ttf_
  - secondary font: _font2-R.ttf_ and _font2-B.ttf_.
  - Note there must be those four fonts - if you only have one font, make copies and rename so those files are there.
    - This is a hack to deal with a Flutter limitation and hopefully will be eliminated. https://docs.flutter.dev/cookbook/design/fonts#2-declare-the-font-in-the-pubspec
- In index.html:
  - Change app name in the \<title> tag
  - Change \<base href> to your subfolder if your web app is not in the root of your site. (More instructions in the comments of index.html.)
  - Change favicon if desired
- You may have to change permissions to 744 for your appDef file and your .usfm files in your data/books/C0... collections folders.

### To use in Flutter for desktop build:

- Clone or download the repository.
- Do as described above in your your IDE, except for the changes to the index.html file.
- Change app name in pubspec.yaml.
- (macOS Windows directions?)

### Be aware

Book Collection ID must follow C01, C02 pattern in your SAB project.

## To do:

- Remember window size and position, column references visible on close...
- Figure out localizations from appDef rather than from Flutter localizations
- Change window title on desktop https://stackoverflow.com/questions/64800455/how-to-change-app-icon-and-app-name-for-flutter-desktop-application
- NavPane buttons: Search, Contact Us, About
- Each column options: font size up and down
- Figure out permissions - right now you have to manually change permissions to 744 for appdef and all sfm book files after output :(
- reader mode/no verses
- read in styles from appdef
- audio
- Better scrollbars
