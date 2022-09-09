'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "f75229385fea6e08cd7a98fff46367df",
"index.html": "8ae48b9802c3338a417a81dd0637c3ef",
"/": "8ae48b9802c3338a417a81dd0637c3ef",
"main.dart.js": "0e007e480bc117cc918f5bdfbca725f1",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "a6615e6c25831e6a32425be7afebd8a2",
"assets/AssetManifest.json": "eb2f8ca1f3d986e124615cb21b1038a8",
"assets/NOTICES": "ab05474fb10e701b5a4e274f486dc438",
"assets/FontManifest.json": "9c61d404ac24fadbefcd3f3067e3d23e",
"assets/packages/window_manager/images/ic_chrome_unmaximize.png": "4a90c1909cb74e8f0d35794e2f61d8bf",
"assets/packages/window_manager/images/ic_chrome_minimize.png": "4282cd84cb36edf2efb950ad9269ca62",
"assets/packages/window_manager/images/ic_chrome_maximize.png": "af7499d7657c8b69d23b85156b60298c",
"assets/packages/window_manager/images/ic_chrome_close.png": "75f4b8ab3608a05461a31fc18d6b47c2",
"assets/packages/fluent_ui/fonts/FluentIcons.ttf": "1cd173aed13e298ab2663dd0924f6762",
"assets/packages/fluent_ui/assets/AcrylicNoise.png": "81f27726c45346351eca125bd062e9a7",
"assets/shaders/ink_sparkle.frag": "9516de3f655988d2989116e82bc1a065",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/translations.json": "b5a2e1710dfe5f97ae2873c0bf03c041",
"assets/assets/project/appDef.appDef": "9e315ea2ff228434672a31386ce4ddf0",
"assets/assets/project/data/contents/contents.xml": "768e937d900b75fdd1e4b015c4b31499",
"assets/assets/project/data/images/drawable-xxxhdpi/ic_launcher.png": "8786a4dcd43d187838464650947d0a27",
"assets/assets/project/data/about/audio-not-found.txt": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/project/data/about/about.txt": "97f73962a438d878935ac04873669949",
"assets/assets/project/data/about/expiry.txt": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/project/data/books/C01/23ISAwolKYG.SFM": "1f4c2c50c90238274fe347a6a5e10ba9",
"assets/assets/project/data/books/C01/142CHwolKYG.SFM": "3dd9c26d0b3be151739b5d95e68e6fb8",
"assets/assets/project/data/books/C01/653JNwolKYG.SFM": "6a5e1b002f9aae840d4e272b885f3b8c",
"assets/assets/project/data/books/C01/05DEUwolKYG.SFM": "4f5588a2ba2b3ee6081916f4b049adef",
"assets/assets/project/data/books/C01/19PSAwolKYG.SFM": "44d728da63fe8643fb956b5bac0e1ded",
"assets/assets/project/data/books/C01/44JHNwolKYG.SFM": "8ac0e3f316c6f2b36e674295cdc93d8b",
"assets/assets/project/data/books/C01/41MATwolKYG.SFM": "2a190b08686a6d87adc2695ee3e1f711",
"assets/assets/project/data/books/C01/37HAGwolKYG.SFM": "4d2b348950366fe7978368a138b5cecb",
"assets/assets/project/data/books/C01/35HABwolKYG.SFM": "5d5fbc2d088e58f6bb297b50b09e15cf",
"assets/assets/project/data/books/C01/51PHPwolKYG.SFM": "7f38d22cc0f777cb9b0cc2bd5bbf50fc",
"assets/assets/project/data/books/C01/31OBAwolKYG.SFM": "e00f4e319983faf868330b20fae0f2a3",
"assets/assets/project/data/books/C01/59HEBwolKYG.SFM": "ed2894112ac0377f941ce1006903d2de",
"assets/assets/project/data/books/C01/622PEwolKYG.SFM": "a61fd573b0d5d88814c7e625528e002f",
"assets/assets/project/data/books/C01/562TIwolKYG.SFM": "1ff4f3ae168cf16a09f165c5762f7bee",
"assets/assets/project/data/books/C01/Suseef%2520-%2520Copy.sfm": "bbc34ab59b8bcea6126ed3cdd9ade0f3",
"assets/assets/project/data/books/C01/52COLwolKYG.SFM": "3d35864d6441af1845e989896cf87f46",
"assets/assets/project/data/books/C01/38ZECwolKYG.SFM": "3fbe32930dc47ba0073e931140a41d02",
"assets/assets/project/data/books/C01/471COwolKYG.SFM": "0ad0cd403256ee2a97c31e72d8a75da2",
"assets/assets/project/data/books/C01/26EZKwolKYG.SFM": "8d5fa883bbd3cccbb37bb04373ca5527",
"assets/assets/project/data/books/C01/03LEVwolKYG.SFM": "581aec846a8cc83fed3bdb3c2b6b0310",
"assets/assets/project/data/books/C01/43LUKwolKYG.SFM": "96d56e3f706dac9728e5bb3c32ebffef",
"assets/assets/project/data/books/C01/58PHMwolKYG.SFM": "0a89f627366fab01fed555b6b8ab4367",
"assets/assets/project/data/books/C01/122KIwolKYG.SFM": "5175600af94bcbf1b26f7354d89cfc9f",
"assets/assets/project/data/books/C01/29JOLwolKYG.SFM": "97e9c39425a319f201c63c65e11cc36f",
"assets/assets/project/data/books/C01/30AMOwolKYG.SFM": "892e1bcdb4c88ce3109a0c9a8ec45bf6",
"assets/assets/project/data/books/C01/60JASwolKYG.SFM": "a3f5551345af60036c991c4f20a167ae",
"assets/assets/project/data/books/C01/32JONwolKYG.SFM": "03f4675f0f4869c9aa3237483ce8138d",
"assets/assets/project/data/books/C01/06JOSwolKYG.SFM": "769c9d9e13e67633cb0faba9c5511c88",
"assets/assets/project/data/books/C01/01GENwolKYG.SFM": "6737ce4ec5dc2d944229c508627cd2b2",
"assets/assets/project/data/books/C01/24JERwolKYG.SFM": "9108c92b3745dec648182ed5262c1fcf",
"assets/assets/project/data/books/C01/33MICwolKYG.SFM": "76f62ee6d5505bf49acd7d6eb3af047c",
"assets/assets/project/data/books/C01/27DANwolKYG.SFM": "b7b0e9d8a13c65805eb7beda2e62aee1",
"assets/assets/project/data/books/C01/131CHwolKYG.SFM": "b128c92a7865f5702f37fedcf0a6ed9d",
"assets/assets/project/data/books/C01/542THwolKYG.SFM": "c42d31d7c6bd0395ad9f90bd33424ced",
"assets/assets/project/data/books/C01/102SAwolKYG.SFM": "9cf244587a70dbbc8164857fc3259f65",
"assets/assets/project/data/books/C01/50EPHwolKYG.SFM": "6f7d8ae776eb4deb649cd93a22709327",
"assets/assets/project/data/books/C01/551TIwolKYG.SFM": "5b7d36fc2874a1d88928320b88ff02be",
"assets/assets/project/data/books/C01/18JOBwolKYG.SFM": "df98a8c5c5dbe5496404918fe4e4ff98",
"assets/assets/project/data/books/C01/642JNwolKYG.SFM": "341b6b267ee3541527b040d1778b05cc",
"assets/assets/project/data/books/C01/15EZRwolKYG.SFM": "81d2ee2363c0eca87a89c51e01c66dc1",
"assets/assets/project/data/books/C01/04NUMwolKYG.SFM": "0a11c08444163fb8e9c51c6042b156d3",
"assets/assets/project/data/books/C01/36ZEPwolKYG.SFM": "03f3fe2fedf4b280ad8777d75fac3276",
"assets/assets/project/data/books/C01/46ROMwolKYG.SFM": "525226370e8907f3f1bc6865f772ee27",
"assets/assets/project/data/books/C01/42MRKwolKYG.SFM": "ad7b05b7f99d1af6df25241c738becc5",
"assets/assets/project/data/books/C01/611PEwolKYG.SFM": "01ac4e72b71fe309d13c85bf5a959b60",
"assets/assets/project/data/books/C01/45ACTwolKYG.SFM": "6b283b239efe048bea8e40562b77c7d6",
"assets/assets/project/data/books/C01/57TITwolKYG.SFM": "c296d0d3076c9fd1d750d868b243d117",
"assets/assets/project/data/books/C01/091SAwolKYG.SFM": "2a38cbe4e03d8961398bf9776a972005",
"assets/assets/project/data/books/C01/66JUDwolKYG.SFM": "7aace41ddbf12052597a9321be533a7a",
"assets/assets/project/data/books/C01/39MALwolKYG.SFM": "d64d5785a9daa8d55d915a0560f0b472",
"assets/assets/project/data/books/C01/16NEHwolKYG.SFM": "d102a69bf672be301bb83da681a3262a",
"assets/assets/project/data/books/C01/21ECCwolKYG.SFM": "e78c29bd2387eea3c5da82863276a286",
"assets/assets/project/data/books/C01/02EXOwolKYG.SFM": "a375e93281bdb4198c15f265286631bf",
"assets/assets/project/data/books/C01/28HOSwolKYG.SFM": "f1c1963851e0ad3f2babb7a490d9e284",
"assets/assets/project/data/books/C01/07JDGwolKYG.SFM": "1a448db834e70d94d9d074cbe1f11015",
"assets/assets/project/data/books/C01/17ESTwolKYG.SFM": "8a904b6269d6a704ced5cffbb905ecad",
"assets/assets/project/data/books/C01/08RUTwolKYG.SFM": "cb2243d5ef12b60eaf83dc2fa991756e",
"assets/assets/project/data/books/C01/482COwolKYG.SFM": "55c2c66d5244718b725ad77cc281650c",
"assets/assets/project/data/books/C01/22SNGwolKYG.SFM": "b822ee70e690d08d0443dff049191195",
"assets/assets/project/data/books/C01/49GALwolKYG.SFM": "e65cd6153ab06c1cd45773f609c109d5",
"assets/assets/project/data/books/C01/631JNwolKYG.SFM": "badcf77dc001d3609e91084df737eed7",
"assets/assets/project/data/books/C01/67REVwolKYG.SFM": "f370fc89fb5b70da6e8beb415f6fdaa0",
"assets/assets/project/data/books/C01/34NAMwolKYG.SFM": "6db47b9e365d793e84f6111ec6665d09",
"assets/assets/project/data/books/C01/20PROwolKYG.SFM": "30114528672b33e67822974665f44302",
"assets/assets/project/data/books/C01/25LAMwolKYG.SFM": "c4c4b6ba882b7a1b0176097e40994ae6",
"assets/assets/project/data/books/C01/Suseef%2520-%2520Copy-Corey's%2520MacBook%2520Pro%25202012.sfm": "78e9a03d6beff6da9a8d32793b73e098",
"assets/assets/project/data/books/C01/531THwolKYG.SFM": "fd865890276705f359e416bc26b4911d",
"assets/assets/project/data/books/C01/111KIwolKYG.SFM": "81c8d43a88e5a9d9c56ec919aa9b05f7",
"assets/assets/project/data/books/C02/631JNWNPub18.SFM": "4a2cf61a8f21c2c21a882c95fb3a977e",
"assets/assets/project/data/books/C02/59HEBWNPub18.SFM": "91bc92bde53d6fbed4b61dc46e705ba9",
"assets/assets/project/data/books/C02/531THWNPub18.SFM": "c016aa300f61daaeca2712ea8204fe97",
"assets/assets/project/data/books/C02/58PHMWNPub18.SFM": "b96030358f5fc78384852c97f1e21341",
"assets/assets/project/data/books/C02/611PEWNPub18.SFM": "1ab005c4defe53a76e588399b1a8f196",
"assets/assets/project/data/books/C02/60JASWNPub18.SFM": "c8e437640916e9a0fdc9c81efd990ae3",
"assets/assets/project/data/books/C02/50EPHWNPub18.SFM": "d644e0d0a7f1987a8532cd569c2acb4b",
"assets/assets/project/data/books/C02/653JNWNPub18.SFM": "d1d6e6cf1d50b48d8efdba2e21278891",
"assets/assets/project/data/books/C02/52COLWNPub18.SFM": "3d9283fe935daacced8b70802957ccb6",
"assets/assets/project/data/books/C02/43LUKWNPub18.SFM": "76d4501b83d5c6764b440259d5077add",
"assets/assets/project/data/books/C02/45ACTWNPub18.SFM": "95a4b634616e9c4a832ad72c7746eaeb",
"assets/assets/project/data/books/C02/551TIWNPub18.SFM": "7437352c17f5c3740ebe31df30f52adf",
"assets/assets/project/data/books/C02/46ROMWNPub18.SFM": "e5d697700cc4cd0c0ed4bb4967e6fc2c",
"assets/assets/project/data/books/C02/42MRKWNPub18.SFM": "e0f5da02843c73c4f472d08c80608f0b",
"assets/assets/project/data/books/C02/51PHPWNPub18.SFM": "1c97d320bda4286d12f1a25d74c5a062",
"assets/assets/project/data/books/C02/482COWNPub18.SFM": "392a773c5a4c61faf888519a0ed023e3",
"assets/assets/project/data/books/C02/44JHNWNPub18.SFM": "6ce056bea8b9e8dc4ac68cef2ceb94cc",
"assets/assets/project/data/books/C02/562TIWNPub18.SFM": "9c33acf9de860f349d1e4d39555908c2",
"assets/assets/project/data/books/C02/66JUDWNPub18.SFM": "982d532806dca4ad58870489addedbe2",
"assets/assets/project/data/books/C02/57TITWNPub18.SFM": "17d0737106ce40343747d909f26fbeb2",
"assets/assets/project/data/books/C02/67REVWNPub18.SFM": "9b109ba6036e5a972d35ccdc38874cea",
"assets/assets/project/data/books/C02/49GALWNPub18.SFM": "171d3f9b5130ef53c4db8e82dffec596",
"assets/assets/project/data/books/C02/41MATWNPub18.SFM": "5971c67a6b6ce9acddba4ae922186949",
"assets/assets/project/data/books/C02/471COWNPub18.SFM": "fcd73da174733a2e696977d21b825d41",
"assets/assets/project/data/books/C02/622PEWNPub18.SFM": "8d6049489ae8b1cb0326f97755774181",
"assets/assets/project/data/books/C02/542THWNPub18.SFM": "dab3009f261c1a08cf20916a89cc3612",
"assets/assets/project/data/books/C02/642JNWNPub18.SFM": "d8866ca9fbc87fcfa27ef94c3ce11d0c",
"assets/assets/project/data/books/C05/15EZRwPP.SFM": "34585c6c92122274a5a365659f40f63b",
"assets/assets/project/data/books/C05/531THwPP.SFM": "20472a32390ff205f0d04f6c1fd5acdd",
"assets/assets/project/data/books/C05/03LEVwPP.SFM": "2326d5fbc9d8e53349a17ba02e046a2a",
"assets/assets/project/data/books/C05/07JDGwPP.SFM": "35416f8d016d3c58c4c4caaaed8e97bd",
"assets/assets/project/data/books/C05/50EPHwPP.SFM": "681be2455bdb97a1ba5dc1311d6f9e44",
"assets/assets/project/data/books/C05/49GALwPP.SFM": "d744a386b4b247b51ffae280d41de9f4",
"assets/assets/project/data/books/C05/25LAMwPP.SFM": "f2b302e63966818ad9d44513763f3200",
"assets/assets/project/data/books/C05/57TITwPP.SFM": "a70c60810b44c305b16ac76050947a9a",
"assets/assets/project/data/books/C05/28HOSwPP.SFM": "ed41deeb7f0b7e1ec69cfd2905470c33",
"assets/assets/project/data/books/C05/642JNwPP.SFM": "6f39aff982d5c5eab23ec400df84582c",
"assets/assets/project/data/books/C05/091SAwPP.SFM": "71c92167edaa46d73893bd0acce090f9",
"assets/assets/project/data/books/C05/05DEUwPP.SFM": "cd143b20c3edeb02b4eb9a46b6c8836b",
"assets/assets/project/data/books/C05/29JOLwPP.SFM": "459614a966dd9386115f9c811fafcbce",
"assets/assets/project/data/books/C05/142CHwPP.SFM": "a21f9605f58315d2f0c719ac845838d7",
"assets/assets/project/data/books/C05/24JERwPP.SFM": "0f40f6edbcb64d984dfabca99aad3169",
"assets/assets/project/data/books/C05/06JOSwPP.SFM": "c2dc2ecf56cb70109342a531c8b4fa51",
"assets/assets/project/data/books/C05/611PEwPP.SFM": "5986dbe50662c1e8ab8204a8bb79911d",
"assets/assets/project/data/books/C05/67REVwPP.SFM": "a9ca248a8c5560097ea5f29b7c9636a9",
"assets/assets/project/data/books/C05/42MRKwPP.SFM": "cc17fa64238d64b603e6d0a43e63a809",
"assets/assets/project/data/books/C05/44JHNwPP.SFM": "42152813e1042b2d2d4b346536d3d221",
"assets/assets/project/data/books/C05/622PEwPP.SFM": "6c9b9291d14aa4ccb058fcd1451c30e1",
"assets/assets/project/data/books/C05/60JASwPP.SFM": "15be1aebffef26b438dd31ecb94f5f83",
"assets/assets/project/data/books/C05/45ACTwPP.SFM": "a1b5d7f83bfd1293a155b82aee8cd2b4",
"assets/assets/project/data/books/C05/02EXOwPP.SFM": "c8fb280b2a789515e3afe73b3b5b39db",
"assets/assets/project/data/books/C05/653JNwPP.SFM": "794145f8bb36b69f9a7cf3ebbcc60559",
"assets/assets/project/data/books/C05/34NAMwPP.SFM": "f13e0ab86ec834d5c3c2935054dcf69d",
"assets/assets/project/data/books/C05/21ECCwPP.SFM": "d1676415848fb1c2f972ad5c56c0c74a",
"assets/assets/project/data/books/C05/39MALwPP.SFM": "55688a4ab4e9a1a2f3610648c45c333e",
"assets/assets/project/data/books/C05/23ISAwPP.SFM": "dcf09ad96b8d035b8510bf2193ca4ccf",
"assets/assets/project/data/books/C05/32JONwPP.SFM": "6ea532ce51b57d58d350b5de0e6557e6",
"assets/assets/project/data/books/C05/102SAwPP.SFM": "bc32d0a6cdd0d6ebe35db71cfa0c01c8",
"assets/assets/project/data/books/C05/04NUMwPP.SFM": "f9afad11d697be68a9bc400f3b1c823e",
"assets/assets/project/data/books/C05/482COwPP.SFM": "cc3af1232928a3ca42c299b2976dd257",
"assets/assets/project/data/books/C05/27DANwPP.SFM": "0a6cd3ce4f7e03fbbee43fc1e682ec1d",
"assets/assets/project/data/books/C05/43LUKwPP.SFM": "0c0d0b80dafcd878369fd412995c2077",
"assets/assets/project/data/books/C05/59HEBwPP.SFM": "75bcd9c67e952eff9ce57724035d5e3a",
"assets/assets/project/data/books/C05/01GENwPP.SFM": "223e802e27bf27b38d50261f6061e83a",
"assets/assets/project/data/books/C05/33MICwPP.SFM": "3480637aa1ddc7c1fa775085bcd36c46",
"assets/assets/project/data/books/C05/19PSAwPP.SFM": "b0a71bc8480e24d5fdc30f180289f600",
"assets/assets/project/data/books/C05/16NEHwPP.SFM": "c0111857ca34e49f3c2aa72adc4641c1",
"assets/assets/project/data/books/C05/471COwPP.SFM": "f2e5d123d743e71193a9442a59591fe5",
"assets/assets/project/data/books/C05/46ROMwPP.SFM": "fed7815fa7ee56d98efd57abe56430b6",
"assets/assets/project/data/books/C05/37HAGwPP.SFM": "4931e99af6a35361242dfb3a82d97fad",
"assets/assets/project/data/books/C05/26EZKwPP.SFM": "98d2e091c57ae9e1381b338362c4818a",
"assets/assets/project/data/books/C05/18JOBwPP.SFM": "054eef18f25e24f94da7a9b2e7c1222f",
"assets/assets/project/data/books/C05/551TIwPP.SFM": "38ffc7b8c91f05f334518e9f9342b6c2",
"assets/assets/project/data/books/C05/51PHPwPP.SFM": "1aca4531cd6dbcaaa21ff34477007a66",
"assets/assets/project/data/books/C05/122KIwPP.SFM": "12e7a158215f0129e1ad33b13af6bd3a",
"assets/assets/project/data/books/C05/22SNGwPP.SFM": "fbf79507a5e7c94f99ea342da5f87bf7",
"assets/assets/project/data/books/C05/111KIwPP.SFM": "620eef0428b67a1bc9d9d353b433e301",
"assets/assets/project/data/books/C05/17ESTwPP.SFM": "c06eb86dca986b7bb7ef3d7146430550",
"assets/assets/project/data/books/C05/631JNwPP.SFM": "bfb708724e961612f9356109c45e71bb",
"assets/assets/project/data/books/C05/562TIwPP.SFM": "d27e9e0cf291575740d12ff6f000b9b8",
"assets/assets/project/data/books/C05/36ZEPwPP.SFM": "dc686aa3c8f051f8736ce5f218ac0012",
"assets/assets/project/data/books/C05/52COLwPP.SFM": "5a85813e19564e2fbf9b4d34a72627d9",
"assets/assets/project/data/books/C05/08RUTwPP.SFM": "fe9b39d3738844578c89a3ff2d4a1885",
"assets/assets/project/data/books/C05/35HABwPP.SFM": "cb67a7b16fe0dfc114e145869247bce4",
"assets/assets/project/data/books/C05/542THwPP.SFM": "2b66a3ad3dd69838db2242b9d3428ebb",
"assets/assets/project/data/books/C05/38ZECwPP.SFM": "e89ee1901093f696e8e88f47a6baa6e5",
"assets/assets/project/data/books/C05/30AMOwPP.SFM": "c801653fa1f001f56b631798f6605a22",
"assets/assets/project/data/books/C05/41MATwPP.SFM": "32df49eb62e3811d482843184b4eebc6",
"assets/assets/project/data/books/C05/31OBAwPP.SFM": "6b77ff6aebf9a1d0ce4a8ece610cdaec",
"assets/assets/project/data/books/C05/131CHwPP.SFM": "6428ef1dde51a1a917dc8d86d3c8c1b3",
"assets/assets/project/data/books/C05/66JUDwPP.SFM": "c703f58bb187d7746b8877cd3d0d410e",
"assets/assets/project/data/books/C05/20PROwPP.SFM": "417db88f596beabf4a5b93caf23a1b12",
"assets/assets/project/data/books/C05/58PHMwPP.SFM": "a55d60e24bd5dec1e29bfd74bbe31588",
"assets/assets/project/data/books/C04/33%2520ENG%255BB%255DLEB2012.sfm": "47d0ace150deaf1be94a04b3a89efad3",
"assets/assets/project/data/books/C04/42%2520ENG%255BB%255DLEB2012.sfm": "7aacd3f3e4793dc6c0d4676c1f95000a",
"assets/assets/project/data/books/C04/02%2520ENG%255BB%255DLEB2012.sfm": "af92e4963fef049995cf0b86cc3eae4f",
"assets/assets/project/data/books/C04/11%2520ENG%255BB%255DLEB2012.sfm": "80037f3288dd090a1ddeaed88b26ea01",
"assets/assets/project/data/books/C04/60%2520ENG%255BB%255DLEB2012.sfm": "72e3c4997c59d89e2192999b28c00451",
"assets/assets/project/data/books/C04/51%2520ENG%255BB%255DLEB2012.sfm": "8f7cde8b02f8c35dc7494baa9dd35d5d",
"assets/assets/project/data/books/C04/20%2520ENG%255BB%255DLEB2012.sfm": "79ae1e8e2a9a8f4911361ac1482e4ebc",
"assets/assets/project/data/books/C04/49%2520ENG%255BB%255DLEB2012.sfm": "2b11fbfa31f0790009b9cccfca097c6b",
"assets/assets/project/data/books/C04/38%2520ENG%255BB%255DLEB2012.sfm": "e64079aa19403fa7c3772ace8e92fbb1",
"assets/assets/project/data/books/C04/06%2520ENG%255BB%255DLEB2012.sfm": "1af8b0577404cd7e01e0ad21d9fb4ff8",
"assets/assets/project/data/books/C04/09%2520ENG%255BB%255DLEB2012.sfm": "f3e5b05ac93ef8e20b77bfdf483f4a4c",
"assets/assets/project/data/books/C04/37%2520ENG%255BB%255DLEB2012.sfm": "9fd126bde979931b6a5076806de573b6",
"assets/assets/project/data/books/C04/46%2520ENG%255BB%255DLEB2012.sfm": "da556dac942d1d88c6c5eb09d99a9535",
"assets/assets/project/data/books/C04/55%2520ENG%255BB%255DLEB2012.sfm": "fceb95441ff44e3d0f21c13753eef6f1",
"assets/assets/project/data/books/C04/24%2520ENG%255BB%255DLEB2012.sfm": "eab1c645aa9999b92aef548847103c06",
"assets/assets/project/data/books/C04/15%2520ENG%255BB%255DLEB2012.sfm": "e7f4725d132a7e02878ad98f6e612089",
"assets/assets/project/data/books/C04/64%2520ENG%255BB%255DLEB2012.sfm": "ca1f97ce203e5d15669b8d1ecb77d627",
"assets/assets/project/data/books/C04/56%2520ENG%255BB%255DLEB2012.sfm": "85346858723988c61de94f06d468eef7",
"assets/assets/project/data/books/C04/27%2520ENG%255BB%255DLEB2012.sfm": "630261579c188491ddae9dd0994372a4",
"assets/assets/project/data/books/C04/19%2520ENG%255BB%255DLEB2012.sfm": "62738654db635ba4aa7e5e3742fd6b5c",
"assets/assets/project/data/books/C04/16%2520ENG%255BB%255DLEB2012.sfm": "c1cc5191598eb3a03aa95e80f2a01ba2",
"assets/assets/project/data/books/C04/28%2520ENG%255BB%255DLEB2012.sfm": "51b5443cd1b14af4033b017912519f65",
"assets/assets/project/data/books/C04/59%2520ENG%255BB%255DLEB2012.sfm": "5d199627702989685d6a88032bece6c0",
"assets/assets/project/data/books/C04/05%2520ENG%255BB%255DLEB2012.sfm": "bc5ea7de7462efa2edb7b54abe1f6e5a",
"assets/assets/project/data/books/C04/34%2520ENG%255BB%255DLEB2012.sfm": "5f9fab3adeae0bafd6a58c70f0565ce1",
"assets/assets/project/data/books/C04/45%2520ENG%255BB%255DLEB2012.sfm": "3ae8264f87427edde3d62ded12811c88",
"assets/assets/project/data/books/C04/12%2520ENG%255BB%255DLEB2012.sfm": "711f5531c990d7d25d76c74bf9c60832",
"assets/assets/project/data/books/C04/63%2520ENG%255BB%255DLEB2012.sfm": "961c5a315150bb6081ee0064647fc7b4",
"assets/assets/project/data/books/C04/52%2520ENG%255BB%255DLEB2012.sfm": "305b2669226593ea262d5d8e949543a4",
"assets/assets/project/data/books/C04/23%2520ENG%255BB%255DLEB2012.sfm": "e5f82a850c2ee54ae277284f19fd1d27",
"assets/assets/project/data/books/C04/30%2520ENG%255BB%255DLEB2012.sfm": "503ac0b3d29931532e51593e9637cf2f",
"assets/assets/project/data/books/C04/41%2520ENG%255BB%255DLEB2012.sfm": "8e986d0f931ba6f0788e7d8fe8f62dd3",
"assets/assets/project/data/books/C04/01%2520ENG%255BB%255DLEB2012.sfm": "72f7b72f348551f9d38227266cd50270",
"assets/assets/project/data/books/C04/65%2520ENG%255BB%255DLEB2012.sfm": "6fa2943b58cae5a12b2daaf0b3937108",
"assets/assets/project/data/books/C04/14%2520ENG%255BB%255DLEB2012.sfm": "be8618bd8787b6c97dbe8e21ed5197d1",
"assets/assets/project/data/books/C04/25%2520ENG%255BB%255DLEB2012.sfm": "320b8e6164c99fa9eddfab9ec6931ea2",
"assets/assets/project/data/books/C04/54%2520ENG%255BB%255DLEB2012.sfm": "c4a7cef11f6ae97c314a9bee11652f01",
"assets/assets/project/data/books/C04/47%2520ENG%255BB%255DLEB2012.sfm": "e398b8bfbcbcb3ff0b7a1846848663b8",
"assets/assets/project/data/books/C04/36%2520ENG%255BB%255DLEB2012.sfm": "9a86c6f7f8955cbb6b9175a9f0ba5354",
"assets/assets/project/data/books/C04/08%2520ENG%255BB%255DLEB2012.sfm": "a4439af214d9080995c3511afcafe4d3",
"assets/assets/project/data/books/C04/07%2520ENG%255BB%255DLEB2012.sfm": "cc0d7b381e3d693a2cced2c5fdd4465a",
"assets/assets/project/data/books/C04/39%2520ENG%255BB%255DLEB2012.sfm": "369bc88e3e2e9509457f90948b9f5f00",
"assets/assets/project/data/books/C04/48%2520ENG%255BB%255DLEB2012.sfm": "4eb65462c4a51efe22380bf031fad585",
"assets/assets/project/data/books/C04/21%2520ENG%255BB%255DLEB2012.sfm": "dbbcb77896c52ba2def1d97198412b99",
"assets/assets/project/data/books/C04/50%2520ENG%255BB%255DLEB2012.sfm": "d85bf86cbe87574fea6586df5e7e0b2a",
"assets/assets/project/data/books/C04/61%2520ENG%255BB%255DLEB2012.sfm": "5f7d8c2f73db6ebc79f8814159692c0d",
"assets/assets/project/data/books/C04/10%2520ENG%255BB%255DLEB2012.sfm": "91750c11f81d6ac54b63c84d9f403da1",
"assets/assets/project/data/books/C04/03%2520ENG%255BB%255DLEB2012.sfm": "6c05b0c75ca4cd9f2f029b2d72c68b21",
"assets/assets/project/data/books/C04/43%2520ENG%255BB%255DLEB2012.sfm": "79a89afeede7675cf3f0629de8e8a90e",
"assets/assets/project/data/books/C04/32%2520ENG%255BB%255DLEB2012.sfm": "9122fbf813604606675ad296db043148",
"assets/assets/project/data/books/C04/40%2520ENG%255BB%255DLEB2012.sfm": "498babad18b38ef5e9a3e5bbbca8e818",
"assets/assets/project/data/books/C04/31%2520ENG%255BB%255DLEB2012.sfm": "101fdfad5b740f5c6df00ae06e21f43e",
"assets/assets/project/data/books/C04/22%2520ENG%255BB%255DLEB2012.sfm": "f6804cc3419b49da299a30374d8fffa1",
"assets/assets/project/data/books/C04/53%2520ENG%255BB%255DLEB2012.sfm": "1a78b483c14cc48195075034847ce79e",
"assets/assets/project/data/books/C04/62%2520ENG%255BB%255DLEB2012.sfm": "17f01f22ae510248de008794c3146b9c",
"assets/assets/project/data/books/C04/13%2520ENG%255BB%255DLEB2012.sfm": "1e6da51e67e93d6f2716b722df750949",
"assets/assets/project/data/books/C04/44%2520ENG%255BB%255DLEB2012.sfm": "3fe561980269621bbbd08a0bf1b4c6d8",
"assets/assets/project/data/books/C04/35%2520ENG%255BB%255DLEB2012.sfm": "fa272d332fa47b3249f4a265099b1ecd",
"assets/assets/project/data/books/C04/04%2520ENG%255BB%255DLEB2012.sfm": "f880e0be712b53ecbfca75143118ae2e",
"assets/assets/project/data/books/C04/58%2520ENG%255BB%255DLEB2012.sfm": "9284f86dc043235a10070bbfa2506035",
"assets/assets/project/data/books/C04/66%2520ENG%255BB%255DLEB2012.sfm": "aa1bb93a73f6dcca9681717366abe7a0",
"assets/assets/project/data/books/C04/29%2520ENG%255BB%255DLEB2012.sfm": "fecdf680931790b3c56edc44cd6031f7",
"assets/assets/project/data/books/C04/17%2520ENG%255BB%255DLEB2012.sfm": "6a4cafaf1980ac726cc237498c9f459f",
"assets/assets/project/data/books/C04/18%2520ENG%255BB%255DLEB2012.sfm": "c25b255efa7b648ec0712f50ad53e9a7",
"assets/assets/project/data/books/C04/26%2520ENG%255BB%255DLEB2012.sfm": "260ddc1ab30cbffb38cfce602216d7bd",
"assets/assets/project/data/books/C04/57%2520ENG%255BB%255DLEB2012.sfm": "b4615c1efd51116bf7c39cce206a9fe1",
"assets/assets/project/data/books/C03/57-COLfraLSG.usfm": "339d789a7ae9805723a2ad76db42f8bc",
"assets/assets/project/data/books/C03/15-2CHfraLSG.usfm": "fc346f35279c57beb3dc344b10f0d917",
"assets/assets/project/data/books/C03/50-ACTfraLSG.usfm": "c5554d8bb63524068e597106a5d764ff",
"assets/assets/project/data/books/C03/18-ESTfraLSG.usfm": "a5a617c3617a16f6071e1bfd85c7ddbb",
"assets/assets/project/data/books/C03/22-ECCfraLSG.usfm": "371dad7474570ddd92f94274130dc00d",
"assets/assets/project/data/books/C03/20-PSAfraLSG.usfm": "042a943c752f6c48d9741cce5ac7e4bd",
"assets/assets/project/data/books/C03/27-EZKfraLSG.usfm": "88f11964b3e42e8d4d9de767d42a0f55",
"assets/assets/project/data/books/C03/35-NAMfraLSG.usfm": "186fe0e7849b892190d6b37264558d91",
"assets/assets/project/data/books/C03/17-NEHfraLSG.usfm": "6fc2f7b8890f8a65c010ce57955b9289",
"assets/assets/project/data/books/C03/40-MALfraLSG.usfm": "09e3c63ac727887f167e2bc191c3aa4e",
"assets/assets/project/data/books/C03/64-HEBfraLSG.usfm": "405369ea7f5ea7129e1ec1d08dc96d42",
"assets/assets/project/data/books/C03/13-2KIfraLSG.usfm": "ef88462484ded50b5e7331d17c5afa1d",
"assets/assets/project/data/books/C03/65-JASfraLSG.usfm": "c2b0de837eb94752327aba87d38c4b2d",
"assets/assets/project/data/books/C03/36-HABfraLSG.usfm": "bf4aa6e4ee3adc010a5835e92f1437e5",
"assets/assets/project/data/books/C03/51-ROMfraLSG.usfm": "54711dfe4388e2615d7bce31c380fd3a",
"assets/assets/project/data/books/C03/52-1COfraLSG.usfm": "07f4012180393dce84d726977092b412",
"assets/assets/project/data/books/C03/38-HAGfraLSG.usfm": "af05f1327343fcf8a6a2f08e3c54ce9c",
"assets/assets/project/data/books/C03/91-2PEfraLSG.usfm": "84c73bc19f527a80ffadea4351e45aa3",
"assets/assets/project/data/books/C03/08-JDGfraLSG.usfm": "bcf978646aa05e8ba2de2a2e93ac4176",
"assets/assets/project/data/books/C03/71-JUDfraLSG.usfm": "1d9ffbd3e93697909bd388adb28addd3",
"assets/assets/project/data/books/C03/37-ZEPfraLSG.usfm": "53990d18a0ec95c72be64d171f441178",
"assets/assets/project/data/books/C03/68-1JNfraLSG.usfm": "19e70558410afbb4c1a1b1b33be158c9",
"assets/assets/project/data/books/C03/54-GALfraLSG.usfm": "94eac7cd7ec9754ddf85963e15dddda5",
"assets/assets/project/data/books/C03/59-2THfraLSG.usfm": "82f7a7d77b50597113b94f4a557a8400",
"assets/assets/project/data/books/C03/47-MRKfraLSG.usfm": "9d0c1831951e005fccdb6a1ed9000134",
"assets/assets/project/data/books/C03/05-NUMfraLSG.usfm": "7a47b74c1f2f169ced26b46c71e98c95",
"assets/assets/project/data/books/C03/61-2TIfraLSG.usfm": "de5d26a4a97f180cf0effdf9a4909ea5",
"assets/assets/project/data/books/C03/24-ISAfraLSG.usfm": "74939fb4ba63a3e9dcc0e37d89b57ff2",
"assets/assets/project/data/books/C03/21-PROfraLSG.usfm": "f5ae7411b2dfefbace5799529e322ade",
"assets/assets/project/data/books/C03/39-ZECfraLSG.usfm": "94caccbb58f01b4a6de6e59055077b5d",
"assets/assets/project/data/books/C03/02-GENfraLSG.usfm": "6dc47f61c6de53dbfe1178e71a51025d",
"assets/assets/project/data/books/C03/10-1SAfraLSG.usfm": "a5be360ca73607eb207a08d595a1f7e0",
"assets/assets/project/data/books/C03/66-1PEfraLSG.usfm": "ac5f9426a72bb0963179e53fc956be98",
"assets/assets/project/data/books/C03/11-2SAfraLSG.usfm": "5815ba2203454321a70c0c19da84cb64",
"assets/assets/project/data/books/C03/28-DANfraLSG.usfm": "2194546fe31139229b08b6f33b9fd8e2",
"assets/assets/project/data/books/C03/60-1TIfraLSG.usfm": "9b87d2c90a265dc19ac77b74bfed7639",
"assets/assets/project/data/books/C03/58-1THfraLSG.usfm": "d004b8a84647352855fcad87e942c21d",
"assets/assets/project/data/books/C03/09-RUTfraLSG.usfm": "c748e72d7384bb01a1f6f5e181d9300c",
"assets/assets/project/data/books/C03/73-JHNfraLSG.usfm": "14e3d3f0c1096ec28869ed71f58246d7",
"assets/assets/project/data/books/C03/25-JERfraLSG.usfm": "c48c32816d71a48795b0412180a011d4",
"assets/assets/project/data/books/C03/23-SNGfraLSG.usfm": "3d186ed677e413fa2173cf0487979dac",
"assets/assets/project/data/books/C03/48-LUKfraLSG.usfm": "34a995dfc6d8203fee4f3d9b5b332f1f",
"assets/assets/project/data/books/C03/69-2JNfraLSG.usfm": "f9c9eb220c829dfc2e22c6b575a69db6",
"assets/assets/project/data/books/C03/34-MICfraLSG.usfm": "cbd2c44af34235f303b57670d149a9e1",
"assets/assets/project/data/books/C03/31-AMOfraLSG.usfm": "e0415fce59dec61668f421e699ffb95b",
"assets/assets/project/data/books/C03/53-2COfraLSG.usfm": "8229aa75f647de9753cd92a333d83266",
"assets/assets/project/data/books/C03/55-EPHfraLSG.usfm": "1d3f18acf39ea92c00008d3492b932bd",
"assets/assets/project/data/books/C03/56-PHPfraLSG.usfm": "c11e9f3aaca444de75160fc0d7496089",
"assets/assets/project/data/books/C03/03-EXOfraLSG.usfm": "327edaa7e6eb836a37260a81316d61af",
"assets/assets/project/data/books/C03/06-DEUfraLSG.usfm": "31fc442087b250e9c1a2d45e239ceb5d",
"assets/assets/project/data/books/C03/12-1KIfraLSG.usfm": "ff5ff7175a33047cfa12e70739d4b81e",
"assets/assets/project/data/books/C03/04-LEVfraLSG.usfm": "44f58a77fb0c3c9d633d88776bf54c3b",
"assets/assets/project/data/books/C03/46-MATfraLSG.usfm": "5e340c11f22b3d4423bcf812553a2cbc",
"assets/assets/project/data/books/C03/26-LAMfraLSG.usfm": "47cf09492cdbb92a2e7d71aaf8f226b3",
"assets/assets/project/data/books/C03/62-TITfraLSG.usfm": "c753a174315f7942dd01206247c82aa8",
"assets/assets/project/data/books/C03/70-3JNfraLSG.usfm": "28305d3c2463209bfc163455e050571b",
"assets/assets/project/data/books/C03/29-HOSfraLSG.usfm": "b9ebc0e74317e139f75dbafe46ba536f",
"assets/assets/project/data/books/C03/63-PHMfraLSG.usfm": "fc994906fc5023b1ef333364564b0140",
"assets/assets/project/data/books/C03/32-OBAfraLSG.usfm": "2f37149a14bf48d8226c1fc65b88478c",
"assets/assets/project/data/books/C03/07-JOSfraLSG.usfm": "92d129508987099167e082e2500a996d",
"assets/assets/project/data/books/C03/16-EZRfraLSG.usfm": "b3540f728367d32acf23d0bec3d1a154",
"assets/assets/project/data/books/C03/14-1CHfraLSG.usfm": "4a753a782c8e6b468e3f696f8f4b8b23",
"assets/assets/project/data/books/C03/19-JOBfraLSG.usfm": "e0077393679f56438a602647cb8e03dd",
"assets/assets/project/data/books/C03/33-JONfraLSG.usfm": "15e5e3e6c636fce504d19114cc0d308f",
"assets/assets/project/data/books/C03/72-REVfraLSG.usfm": "fb4cd9db2658b4c96f4cd5eaaf3b1516",
"assets/assets/project/data/books/C03/30-JOLfraLSG.usfm": "ab447fbae4ccd8c9474fe5b097ca263b",
"assets/assets/project/data/fonts/font2-R.ttf": "e43231e6d2cb021c0bfdf00cbca8e95e",
"assets/assets/project/data/fonts/font2-B.ttf": "59b9b768691235eec7b51595e35828d3",
"assets/assets/project/data/fonts/font1-R.ttf": "017b2b2ad86e09d3c22b8cf0dfc78247",
"assets/assets/project/data/fonts/font1-B.ttf": "6f5069ac6a300dad45383c952e92c573",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
