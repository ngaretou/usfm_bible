'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "4e022f3ae4274c8e7b0a8d3e3b266c3f",
"splash/img/light-2x.png": "6b66ea6e70a1c73c3b7758d66862f9d5",
"splash/img/dark-4x.png": "5b6866f5fbfd0e4606a82ce0b3e57394",
"splash/img/light-3x.png": "cde60582cbed8e36c37f93d0b5651239",
"splash/img/dark-3x.png": "cde60582cbed8e36c37f93d0b5651239",
"splash/img/light-4x.png": "5b6866f5fbfd0e4606a82ce0b3e57394",
"splash/img/dark-2x.png": "6b66ea6e70a1c73c3b7758d66862f9d5",
"splash/img/dark-1x.png": "f5e7ac5f9b405fbf77854adbcc4bf789",
"splash/img/light-1x.png": "f5e7ac5f9b405fbf77854adbcc4bf789",
"splash/splash.js": "123c400b58bea74c1305ca3ac966748d",
"splash/style.css": "c94c38ff00a9d487c353a2d78989ea08",
"index.html": "6f9408ae74f2bd37a4d580915bdaeabc",
"/": "6f9408ae74f2bd37a4d580915bdaeabc",
"main.dart.js": "403ec8be6d84ff005c68a80d318f76dc",
"flutter.js": "1cfe996e845b3a8a33f57607e8b09ee4",
"favicon.png": "54cd19c9af00638fc6b9737ab739a4de",
"icons/512.png": "7ecb32b60df65e9e651736711d06fd04",
"icons/icon.svg": "9c59fde0e0c08c7406c661c972aff32c",
"icons/192.png": "a76bf4e4ec061bc1611d849ddbed97e5",
"manifest.json": "5e95ff98eece5ae62ee98a3bea0aa5a6",
"Archive.zip": "70d75d9db04fa06f5fbf4125943acb5a",
"assets/AssetManifest.json": "ff81ea1d78eeeebcc3d7f55318d74781",
"assets/NOTICES": "b114a683277ede410f8cd158dd4ed79c",
"assets/FontManifest.json": "2e32db8346bad9f53a1c9dc15cc06f8f",
"assets/packages/window_manager/images/ic_chrome_unmaximize.png": "4a90c1909cb74e8f0d35794e2f61d8bf",
"assets/packages/window_manager/images/ic_chrome_minimize.png": "4282cd84cb36edf2efb950ad9269ca62",
"assets/packages/window_manager/images/ic_chrome_maximize.png": "af7499d7657c8b69d23b85156b60298c",
"assets/packages/window_manager/images/ic_chrome_close.png": "75f4b8ab3608a05461a31fc18d6b47c2",
"assets/packages/fluent_ui/fonts/FluentIcons.ttf": "1cd173aed13e298ab2663dd0924f6762",
"assets/packages/fluent_ui/assets/AcrylicNoise.png": "81f27726c45346351eca125bd062e9a7",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/translations.json": "b5a2e1710dfe5f97ae2873c0bf03c041",
"assets/assets/images/app-logo.png": "c1324c0a870220b80a336a24af709c44",
"assets/assets/images/screenshot.png": "7b1dc9b3a239ac2f60cec12f9e0999b6",
"assets/assets/images/menu.png": "2260e2be9727564e80d77a574e2f7224",
"assets/assets/images/columntools.png": "d942829adab9561d58c4f740045e9215",
"assets/assets/images/columntools.old.png": "141c5bdf5f3e57847967c97d55fe3f49",
"assets/assets/project/appDef.appDef": "e3ae82799bb4ab0f6fcd49ac35528d08",
"assets/assets/project/data/contents/contents.xml": "768e937d900b75fdd1e4b015c4b31499",
"assets/assets/project/data/images/drawable-xxxhdpi/ic_launcher.png": "8786a4dcd43d187838464650947d0a27",
"assets/assets/project/data/about/audio-not-found.txt": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/project/data/about/about.txt": "c00e496ad32e0ebd8e42184482b26b92",
"assets/assets/project/data/about/expiry.txt": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/project/data/books/C01/23ISAwolKYG.SFM": "78a5d818783fbdffc40a67c5f02fc323",
"assets/assets/project/data/books/C01/142CHwolKYG.SFM": "911d2b17342d8bfbd266528ad0867d68",
"assets/assets/project/data/books/C01/653JNwolKYG.SFM": "6a5e1b002f9aae840d4e272b885f3b8c",
"assets/assets/project/data/books/C01/05DEUwolKYG.SFM": "1c9ec3d64df423fdc7125e67b9f2183f",
"assets/assets/project/data/books/C01/19PSAwolKYG.SFM": "0405dbafac5fc1adf90242a4d6aa665c",
"assets/assets/project/data/books/C01/44JHNwolKYG.SFM": "b1b9dc8d6de7e3dbf93eef76da9e1e92",
"assets/assets/project/data/books/C01/41MATwolKYG.SFM": "5bf8fb1c0c09833eee18867784f4ae12",
"assets/assets/project/data/books/C01/37HAGwolKYG.SFM": "9c8078abc9b823eb0a447ea167e7dbf3",
"assets/assets/project/data/books/C01/35HABwolKYG.SFM": "b33ebef7bd0d9ce3cf30b3cf8da670b4",
"assets/assets/project/data/books/C01/51PHPwolKYG.SFM": "8c00eb1d9a0d776dc5e5524ed0a4f458",
"assets/assets/project/data/books/C01/31OBAwolKYG.SFM": "9250e335127b8e72125b674507be7a5c",
"assets/assets/project/data/books/C01/59HEBwolKYG.SFM": "3113f639fcc8e5bca9e5ecd7d076eaf4",
"assets/assets/project/data/books/C01/622PEwolKYG.SFM": "a61fd573b0d5d88814c7e625528e002f",
"assets/assets/project/data/books/C01/562TIwolKYG.SFM": "1ff4f3ae168cf16a09f165c5762f7bee",
"assets/assets/project/data/books/C01/Suseef%2520-%2520Copy.sfm": "bbc34ab59b8bcea6126ed3cdd9ade0f3",
"assets/assets/project/data/books/C01/52COLwolKYG.SFM": "3d35864d6441af1845e989896cf87f46",
"assets/assets/project/data/books/C01/38ZECwolKYG.SFM": "bdc99ae98204b768c5830ebfaac3cdc5",
"assets/assets/project/data/books/C01/471COwolKYG.SFM": "b93f458845617dfbd91ba09ebf826e1d",
"assets/assets/project/data/books/C01/26EZKwolKYG.SFM": "d543709689b29f2189791210db3ecd74",
"assets/assets/project/data/books/C01/03LEVwolKYG.SFM": "762eb88d19b61b2b32f3a568d445ae55",
"assets/assets/project/data/books/C01/43LUKwolKYG.SFM": "ab4631f661085c39b4dea2a7c3b5cad0",
"assets/assets/project/data/books/C01/58PHMwolKYG.SFM": "0a89f627366fab01fed555b6b8ab4367",
"assets/assets/project/data/books/C01/122KIwolKYG.SFM": "86b15e13feb9fc7c672457cc28a1491e",
"assets/assets/project/data/books/C01/29JOLwolKYG.SFM": "50c1439f5243d18ecc49b9b72301158d",
"assets/assets/project/data/books/C01/30AMOwolKYG.SFM": "800fd7ce942ef181f16ef32f9aaf9aed",
"assets/assets/project/data/books/C01/60JASwolKYG.SFM": "0c52317b7718fbc7e7a194895142b487",
"assets/assets/project/data/books/C01/32JONwolKYG.SFM": "085eec2cde8177f1e136e78ac0956f83",
"assets/assets/project/data/books/C01/06JOSwolKYG.SFM": "d000da2062abd709bebf3241d7dd624d",
"assets/assets/project/data/books/C01/01GENwolKYG.SFM": "0de92b4116697129839dde9b9a0ff3ce",
"assets/assets/project/data/books/C01/24JERwolKYG.SFM": "83186061e73fb4d250628606b47d45a8",
"assets/assets/project/data/books/C01/33MICwolKYG.SFM": "45e609002739799b39123768e80a68e2",
"assets/assets/project/data/books/C01/27DANwolKYG.SFM": "97d1245db5defad879fcf97b37242937",
"assets/assets/project/data/books/C01/131CHwolKYG.SFM": "bd88437b77800cf788772dcde1d9c9c4",
"assets/assets/project/data/books/C01/542THwolKYG.SFM": "c9e9e66adc31ed0381cdaf3092089a57",
"assets/assets/project/data/books/C01/102SAwolKYG.SFM": "02cf8fca7c2310eb3bb49f51ca948b67",
"assets/assets/project/data/books/C01/50EPHwolKYG.SFM": "7a2e5452c7a985ffca16ab761be6cc9e",
"assets/assets/project/data/books/C01/551TIwolKYG.SFM": "5b7d36fc2874a1d88928320b88ff02be",
"assets/assets/project/data/books/C01/18JOBwolKYG.SFM": "79ee2aa917e10bbef8234c5ca37a5e8b",
"assets/assets/project/data/books/C01/642JNwolKYG.SFM": "341b6b267ee3541527b040d1778b05cc",
"assets/assets/project/data/books/C01/15EZRwolKYG.SFM": "add759195e82d3321fcd6a6839ebdc81",
"assets/assets/project/data/books/C01/04NUMwolKYG.SFM": "d97341cb16624f9bbcb67e25ef62089c",
"assets/assets/project/data/books/C01/36ZEPwolKYG.SFM": "79e203206f9c55eaec09c154f2fca91c",
"assets/assets/project/data/books/C01/46ROMwolKYG.SFM": "bf609da0f809aaf0884669af31b299f6",
"assets/assets/project/data/books/C01/42MRKwolKYG.SFM": "86e4afa0644db7910b1cfaef2ae42b75",
"assets/assets/project/data/books/C01/611PEwolKYG.SFM": "2bb82375f63fdfbc4d69fa9d9308ab00",
"assets/assets/project/data/books/C01/45ACTwolKYG.SFM": "94c0f4f801f674135362ffc8555dbf26",
"assets/assets/project/data/books/C01/57TITwolKYG.SFM": "1f7668824f750385e4ff53e2d1df484f",
"assets/assets/project/data/books/C01/091SAwolKYG.SFM": "66ccb5df8fdaa205a972c442116a6d61",
"assets/assets/project/data/books/C01/66JUDwolKYG.SFM": "7aace41ddbf12052597a9321be533a7a",
"assets/assets/project/data/books/C01/39MALwolKYG.SFM": "9b4616d19892bafcb4de543aec711aaa",
"assets/assets/project/data/books/C01/16NEHwolKYG.SFM": "1054fff3df2d6044eb5c3f0110e9477f",
"assets/assets/project/data/books/C01/21ECCwolKYG.SFM": "cdbb4e57a8f4d3f92c3780d0cb42b946",
"assets/assets/project/data/books/C01/02EXOwolKYG.SFM": "b0c9eeefab3343f9c1cbfe3b7546849e",
"assets/assets/project/data/books/C01/28HOSwolKYG.SFM": "40399264c65ffd71409126cdc99c2873",
"assets/assets/project/data/books/C01/07JDGwolKYG.SFM": "b929cd80d879d3e50f1f5710aa5130ff",
"assets/assets/project/data/books/C01/17ESTwolKYG.SFM": "f24c5982377fb8b232ee8d2b916e1729",
"assets/assets/project/data/books/C01/08RUTwolKYG.SFM": "8759e9a45c522eabd7ce3e8cb526f17d",
"assets/assets/project/data/books/C01/482COwolKYG.SFM": "20555dd914b42635430945fe1f3ac439",
"assets/assets/project/data/books/C01/22SNGwolKYG.SFM": "c2a13a1ecb3cbef4d93eb2365e328d8d",
"assets/assets/project/data/books/C01/49GALwolKYG.SFM": "da11a9c4fe2986f67dc8fbb3ecee3f3e",
"assets/assets/project/data/books/C01/631JNwolKYG.SFM": "b128702d561d257ffae7b4900c42dbe0",
"assets/assets/project/data/books/C01/67REVwolKYG.SFM": "b0755fcbf8939907dcf10deaf06f18ef",
"assets/assets/project/data/books/C01/34NAMwolKYG.SFM": "ab9a8074b2542dc956d2b6184ddc56c9",
"assets/assets/project/data/books/C01/20PROwolKYG.SFM": "a49dbc639dc83a0b9ff3ac2800814259",
"assets/assets/project/data/books/C01/25LAMwolKYG.SFM": "8d800d6325da8e9c68311e0cf6b21b2e",
"assets/assets/project/data/books/C01/Suseef%2520-%2520Copy-Corey's%2520MacBook%2520Pro%25202012.sfm": "78e9a03d6beff6da9a8d32793b73e098",
"assets/assets/project/data/books/C01/531THwolKYG.SFM": "93973c37960494151c852f9c4cc4be36",
"assets/assets/project/data/books/C01/111KIwolKYG.SFM": "845e8962352b82560af8c4d005ba79f1",
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
"assets/assets/project/data/books/C05/71-JUDgrcsbl.usfm": "45d885f57f6bb5510165b4f6adc75608",
"assets/assets/project/data/books/C05/49-JHNgrcsbl.usfm": "8a9ac9227383a14eef1fa83fe7281d8d",
"assets/assets/project/data/books/C05/68-1JNgrcsbl.usfm": "bc8dc3f3d5d92aa380488930783a092d",
"assets/assets/project/data/books/C05/59-2THgrcsbl.usfm": "0d2ccea28f50736472caac098a5e36da",
"assets/assets/project/data/books/C05/47-MRKgrcsbl.usfm": "bd54f30446f1a4a8461181fb22ace48a",
"assets/assets/project/data/books/C05/54-GALgrcsbl.usfm": "057d45af6654ee7c09119ed356a5335c",
"assets/assets/project/data/books/C05/61-2TIgrcsbl.usfm": "8cf6754904049c75d2c7db73b93f980a",
"assets/assets/project/data/books/C05/67-2PEgrcsbl.usfm": "9455a154840cb2eb25d00580fd73af74",
"assets/assets/project/data/books/C05/57-COLgrcsbl.usfm": "3f87bc9b198ebf1c74305269ee801c5e",
"assets/assets/project/data/books/C05/50-ACTgrcsbl.usfm": "0babd2aaacc7322758143222b0387ec8",
"assets/assets/project/data/books/C05/51-ROMgrcsbl.usfm": "0d8b57055c32fb57c9e60a5c8ccbe7ae",
"assets/assets/project/data/books/C05/65-JASgrcsbl.usfm": "17ce4c638f853508233700430ff6360c",
"assets/assets/project/data/books/C05/64-HEBgrcsbl.usfm": "bc80827c100cdb9b1ac8a4473028c3a2",
"assets/assets/project/data/books/C05/52-1COgrcsbl.usfm": "4cd23f93d9fa5c97d369180d5c378ec6",
"assets/assets/project/data/books/C05/56-PHPgrcsbl.usfm": "cb155aa48ee22c292febb22faba9db8b",
"assets/assets/project/data/books/C05/55-EPHgrcsbl.usfm": "ff3dc4fd6b9ea57fa5b653be266ffbf7",
"assets/assets/project/data/books/C05/53-2COgrcsbl.usfm": "a581f8d31c73a482437e4a66a8bd3375",
"assets/assets/project/data/books/C05/70-3JNgrcsbl.usfm": "d67644a5e65f060f99f666b8a829e23d",
"assets/assets/project/data/books/C05/62-TITgrcsbl.usfm": "ee11057077f44617618c12145a440ccb",
"assets/assets/project/data/books/C05/46-MATgrcsbl.usfm": "f978c66ad87209f34f041ed6220c13be",
"assets/assets/project/data/books/C05/63-PHMgrcsbl.usfm": "d47a60d80b09b7b139997ee4066f42a7",
"assets/assets/project/data/books/C05/72-REVgrcsbl.usfm": "be06813efb067192aee1ea34bbfa989d",
"assets/assets/project/data/books/C05/66-1PEgrcsbl.usfm": "5083ee70b58fa8dd0b8ea719ae3c1fbc",
"assets/assets/project/data/books/C05/60-1TIgrcsbl.usfm": "0724fb09be78779995a5728d4c56435b",
"assets/assets/project/data/books/C05/58-1THgrcsbl.usfm": "a8e2f68976243b430af77d5e8fd9d8ba",
"assets/assets/project/data/books/C05/48-LUKgrcsbl.usfm": "3806a495390338099f20b3e3357b09fd",
"assets/assets/project/data/books/C05/69-2JNgrcsbl.usfm": "c74f8dc08de44ba3e0e939bec781e41d",
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
"assets/assets/project/data/fonts/font2-R.ttf": "017b2b2ad86e09d3c22b8cf0dfc78247",
"assets/assets/project/data/fonts/font2-B.ttf": "6f5069ac6a300dad45383c952e92c573",
"assets/assets/project/data/fonts/font3-R.ttf": "0e2ed0ab7fb81e540dab3203fc8386e3",
"assets/assets/project/data/fonts/font1-R.ttf": "017b2b2ad86e09d3c22b8cf0dfc78247",
"assets/assets/project/data/fonts/font3-B.ttf": "0e2ed0ab7fb81e540dab3203fc8386e3",
"assets/assets/project/data/fonts/font1-B.ttf": "6f5069ac6a300dad45383c952e92c573",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e"
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
