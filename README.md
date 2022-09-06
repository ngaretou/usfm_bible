# usfm_bible

_Still in development, not production ready_

An extension of [Scripture App Builder](https://software.sil.org/scriptureappbuilder/) primarily for web apps that also can be used to produce offline Windows and macOS.

To use the pre-built version for your SAB project, upload it to your web server, drop in your SAB project, and it generates a multi-collection multi-column web app.

Demo of current version at https://coreygarrett.org/usfm_bible/

<p align="center">
  <img src="https://github.com/ngaretou/usfm_bible/blob/master/screenshot.png">
  <br>
  <i>Screenshot of usfm_bible on a web browser</i>
</p>

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
- Some translations are available in the appDef and pulled directly from your existing project. Some are not a part of SAB's translation strings and you can provide those five that usfm_bible uses for your language in assets/translations.json. Include the translations there with the language codes from the Interface/Language/Language Codes column.
  - Before using make sure the following Interface translations are filled in for all of the languages you want to use in the interface: 
    - Search
    - Settings_Title
    - Settings_Interface_Language
    - Menu_About
    - Menu_Item_Copy
    - Menu_Item_Share
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

- Book Collection ID must follow C01, C02 pattern in your SAB project.
- Footnote text is without formatting, just plain text stripped of USFM. The Tooltip widget only allows one style.  https://ubsicap.github.io/usfm/notes_basic/fnotes.html#fq etc.


## To do:
### Minimal
- Add in Ajami Wolof
- NavPane buttons: 
  - Contact Us (?)
- Complete search - searching by collection
- Scroll bars are wierd on hover now
- Context menu should not be transparent

### Maximal
- Remember window size and position on close...
- Remember column references visible on close...
- Change window title on desktop https://stackoverflow.com/questions/64800455/how-to-change-app-icon-and-app-name-for-flutter-desktop-application
- Figure out permissions - right now you have to manually change permissions to 744 for appdef and all sfm book files after output :(
- reader mode/no verses
- read in styles from appdef
- audio
- Pass in ref via URL to go straight there? 

