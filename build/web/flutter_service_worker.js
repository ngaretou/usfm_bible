'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "502f8f2ba259f4a5f98f8b164c58005b",
"splash/img/light-2x.png": "6e70d65c25732ecf2f6f76fc5fa21b47",
"splash/img/dark-4x.png": "5b6866f5fbfd0e4606a82ce0b3e57394",
"splash/img/light-3x.png": "4575d370ad314ef3cf924f336dc588b7",
"splash/img/dark-3x.png": "4575d370ad314ef3cf924f336dc588b7",
"splash/img/light-4x.png": "5b6866f5fbfd0e4606a82ce0b3e57394",
"splash/img/dark-2x.png": "6e70d65c25732ecf2f6f76fc5fa21b47",
"splash/img/dark-1x.png": "7d35d9e91ad35b42a3961254074d77bf",
"splash/img/light-1x.png": "7d35d9e91ad35b42a3961254074d77bf",
"index.html": "c16822efa9df01d13feee0bf3b820d32",
"/": "c16822efa9df01d13feee0bf3b820d32",
"main.dart.js": "f518ba3ae5764b293b7c26aed45a5675",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"favicon.png": "949684f311230a51816c77648f854f74",
"icons/Icon-192.png": "81e0640fd822ff957bf9e9c1974b6842",
"icons/Icon-maskable-192.png": "81e0640fd822ff957bf9e9c1974b6842",
"icons/512.png": "7ecb32b60df65e9e651736711d06fd04",
"icons/icon.svg": "9c59fde0e0c08c7406c661c972aff32c",
"icons/Icon-maskable-512.png": "6e70d65c25732ecf2f6f76fc5fa21b47",
"icons/192.png": "a76bf4e4ec061bc1611d849ddbed97e5",
"icons/Icon-512.png": "6e70d65c25732ecf2f6f76fc5fa21b47",
"manifest.json": "a6615e6c25831e6a32425be7afebd8a2",
"assets/AssetManifest.json": "ad70988571cd32c33c0144a121a3e2cd",
"assets/NOTICES": "5e66878660e934ee312acd7287b6aef1",
"assets/FontManifest.json": "2e32db8346bad9f53a1c9dc15cc06f8f",
"assets/AssetManifest.bin.json": "58b6231dd711f39d95fa72a2b3897ebb",
"assets/packages/window_manager/images/ic_chrome_unmaximize.png": "4a90c1909cb74e8f0d35794e2f61d8bf",
"assets/packages/window_manager/images/ic_chrome_minimize.png": "4282cd84cb36edf2efb950ad9269ca62",
"assets/packages/window_manager/images/ic_chrome_maximize.png": "af7499d7657c8b69d23b85156b60298c",
"assets/packages/window_manager/images/ic_chrome_close.png": "75f4b8ab3608a05461a31fc18d6b47c2",
"assets/packages/fluent_ui/fonts/FluentIcons.ttf": "f3c4f09a37ace3246250ff7142da5cdd",
"assets/packages/fluent_ui/assets/AcrylicNoise.png": "81f27726c45346351eca125bd062e9a7",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/AssetManifest.bin": "094b6e0512c10b3f77d6012814648db4",
"assets/fonts/MaterialIcons-Regular.otf": "9567b378bb220ea817f868435e21b975",
"assets/assets/translations.json": "edc27d9e4ce5c5f259287965ccb3633b",
"assets/assets/images/Thumbs.db": "d7968fd33029e06b894bb7f0956c9102",
"assets/assets/images/book_selection.png": "21b5f5dde20f1a1d1c6051466f085779",
"assets/assets/images/app-logo.png": "c1324c0a870220b80a336a24af709c44",
"assets/assets/images/screenshot.png": "7b1dc9b3a239ac2f60cec12f9e0999b6",
"assets/assets/images/AppStore.png": "3d252de203e9e4cb7e99058d5c9b280f",
"assets/assets/images/menu.png": "2260e2be9727564e80d77a574e2f7224",
"assets/assets/images/ch_vs_selection.png": "6f80cc0ee247dc521990616263537d40",
"assets/assets/images/bible_book_selection.png": "ae186d5ca3558a8a730d9a0872cc08b0",
"assets/assets/images/app-logo-apple.png": "e6a4fcf450cac91d221f93f81bc8aa40",
"assets/assets/images/font_size.png": "52130f5561e840e930d9979d5bfc194b",
"assets/assets/images/link_button.png": "1db5781fbaf4dd7955f9c5650679a317",
"assets/assets/images/Microsoft-badge.png": "deee1c8dd80adb387d1384b8085b994c",
"assets/assets/project/appDef.appDef.old": "d1cc1e035de478575cfd65cdcb86d307",
"assets/assets/project/appDef.appDef": "d0958f7ca2ded6e304083d5045d1b358",
"assets/assets/project/data/contents/contents.xml": "768e937d900b75fdd1e4b015c4b31499",
"assets/assets/project/data/images/drawable-xxxhdpi/ic_launcher.png": "8786a4dcd43d187838464650947d0a27",
"assets/assets/project/data/about/audio-not-found.txt": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/project/data/about/about.txt": "86da95419ffe8ddb3779a482cf1a4efa",
"assets/assets/project/data/about/expiry.txt": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/project/data/books/C01/23ISAwolKYG.SFM": "140bd863c99da28f702692a2d063c58c",
"assets/assets/project/data/books/C01/142CHwolKYG.SFM": "bebd2b2caf6a1d59a11495272318668a",
"assets/assets/project/data/books/C01/653JNwolKYG.SFM": "da2d54fa88135b25ec2020ed509a117a",
"assets/assets/project/data/books/C01/05DEUwolKYG.SFM": "24191aebaa96a0d43d3eec6392a29760",
"assets/assets/project/data/books/C01/19PSAwolKYG.SFM": "011eaef20878a45b71e951655d67ae22",
"assets/assets/project/data/books/C01/44JHNwolKYG.SFM": "00b5c9cc1b266c97f182d77f55f0926d",
"assets/assets/project/data/books/C01/41MATwolKYG.SFM": "773f7537b18059a3dcd464404a631d6e",
"assets/assets/project/data/books/C01/37HAGwolKYG.SFM": "f31d9a3e91bea0f3869a127767647a4b",
"assets/assets/project/data/books/C01/35HABwolKYG.SFM": "7a8794d757eed3644b25785229e4a740",
"assets/assets/project/data/books/C01/51PHPwolKYG.SFM": "d17f38daeeb890a3b5a081800282361b",
"assets/assets/project/data/books/C01/31OBAwolKYG.SFM": "294fc8046915ea4cd623e57788b40025",
"assets/assets/project/data/books/C01/59HEBwolKYG.SFM": "819760be8a333713ec17099df5109ba0",
"assets/assets/project/data/books/C01/622PEwolKYG.SFM": "5ccc3a27f0ab63ec4593036d58188a7b",
"assets/assets/project/data/books/C01/562TIwolKYG.SFM": "cdf334a64cac554282017b15cdbae045",
"assets/assets/project/data/books/C01/Suseef%2520-%2520Copy.sfm": "bbc34ab59b8bcea6126ed3cdd9ade0f3",
"assets/assets/project/data/books/C01/52COLwolKYG.SFM": "fe3b66782ec346baf4466ac8bba8a8c3",
"assets/assets/project/data/books/C01/38ZECwolKYG.SFM": "11b6715cfbfe35a02d3789a4ec525820",
"assets/assets/project/data/books/C01/471COwolKYG.SFM": "b95945930f81e47bd95447d01868bd2f",
"assets/assets/project/data/books/C01/26EZKwolKYG.SFM": "f99c8001e46789c08e3d31dd81dc5c25",
"assets/assets/project/data/books/C01/03LEVwolKYG.SFM": "2849d4c3deac98e86b60baca8cce201c",
"assets/assets/project/data/books/C01/43LUKwolKYG.SFM": "c415874f2ece8b8d4b54ef372b701e31",
"assets/assets/project/data/books/C01/58PHMwolKYG.SFM": "1617093f533386bf61ef47707f347b03",
"assets/assets/project/data/books/C01/122KIwolKYG.SFM": "0668370af32062cc5ee51e07bd8843db",
"assets/assets/project/data/books/C01/29JOLwolKYG.SFM": "90d8af8d5618b06fd847b1143d50d507",
"assets/assets/project/data/books/C01/30AMOwolKYG.SFM": "860d05aa054aa32a82305f8030e71359",
"assets/assets/project/data/books/C01/60JASwolKYG.SFM": "d6b020b859f71cf3e10709d4ab218411",
"assets/assets/project/data/books/C01/32JONwolKYG.SFM": "1da95fc58d9c09fa3168428982759fb6",
"assets/assets/project/data/books/C01/06JOSwolKYG.SFM": "7353b42ebefacef9b86ddebc34e94305",
"assets/assets/project/data/books/C01/01GENwolKYG.SFM": "91892b52b925e2e2ef2707695c142bde",
"assets/assets/project/data/books/C01/24JERwolKYG.SFM": "025c4875bf018a1965a088debb909d0f",
"assets/assets/project/data/books/C01/33MICwolKYG.SFM": "5febf3a2a7d634f22542885b14e07185",
"assets/assets/project/data/books/C01/27DANwolKYG.SFM": "5b95fe49d848b8f6e8323ed8003619bf",
"assets/assets/project/data/books/C01/131CHwolKYG.SFM": "5dca9ee968d9ffba9019add32b7aee8b",
"assets/assets/project/data/books/C01/542THwolKYG.SFM": "20207944ba3886192fe5daa0caf1c530",
"assets/assets/project/data/books/C01/102SAwolKYG.SFM": "f0643a7f6caa40674f1ffce6999f501f",
"assets/assets/project/data/books/C01/50EPHwolKYG.SFM": "f26b8445b6ca3088b46ca366fcb6be53",
"assets/assets/project/data/books/C01/551TIwolKYG.SFM": "631385b64a6ad6828bd687d62d761da9",
"assets/assets/project/data/books/C01/18JOBwolKYG.SFM": "1a62b84d79079df768196b3f1e757272",
"assets/assets/project/data/books/C01/642JNwolKYG.SFM": "2a5a66286898523ae5dcdec3b767c2b7",
"assets/assets/project/data/books/C01/15EZRwolKYG.SFM": "5dddf2604ff3418e9917b45136fbaa57",
"assets/assets/project/data/books/C01/04NUMwolKYG.SFM": "7b305610b9d28274b80afbf7946793c1",
"assets/assets/project/data/books/C01/36ZEPwolKYG.SFM": "05afebc23157a42755a2d7852beec6e4",
"assets/assets/project/data/books/C01/46ROMwolKYG.SFM": "c469af139e6268b27114a658ed3e1d72",
"assets/assets/project/data/books/C01/42MRKwolKYG.SFM": "98a32d2ee632438359740c373184d3b8",
"assets/assets/project/data/books/C01/611PEwolKYG.SFM": "8132fa36a228c576dde3e8653637df36",
"assets/assets/project/data/books/C01/45ACTwolKYG.SFM": "df9fa81a6997b399a54ee1dc2350251b",
"assets/assets/project/data/books/C01/57TITwolKYG.SFM": "1c3ee8e0f3238f54a9615ca806fd022b",
"assets/assets/project/data/books/C01/091SAwolKYG.SFM": "08732548b1291722946ed9ff65ab535e",
"assets/assets/project/data/books/C01/66JUDwolKYG.SFM": "dbaa58b94ec261752356ecb3c128d7f7",
"assets/assets/project/data/books/C01/39MALwolKYG.SFM": "4311802f0cf4f16a8f5f324f49d45ff4",
"assets/assets/project/data/books/C01/16NEHwolKYG.SFM": "42dba84c785d5ea23e37ea98353f62f4",
"assets/assets/project/data/books/C01/21ECCwolKYG.SFM": "c2bed82ebd6d21c1007bf982a4abcb3a",
"assets/assets/project/data/books/C01/02EXOwolKYG.SFM": "7bd15caa198d5d43c1d911c417dc4696",
"assets/assets/project/data/books/C01/28HOSwolKYG.SFM": "59b9938594c154532b25fb452e7b0d68",
"assets/assets/project/data/books/C01/07JDGwolKYG.SFM": "149703d038db461f84cc4459036d5004",
"assets/assets/project/data/books/C01/17ESTwolKYG.SFM": "00a16e1f69a3b8d8cfd8749cf59fe2a0",
"assets/assets/project/data/books/C01/08RUTwolKYG.SFM": "dd4b5dac8376c7a74c83d3bd328cc7df",
"assets/assets/project/data/books/C01/482COwolKYG.SFM": "ea718a971894eab3ad7860126bf8959c",
"assets/assets/project/data/books/C01/22SNGwolKYG.SFM": "498516c99e2fb6a85e2c95c3e4ee8ca3",
"assets/assets/project/data/books/C01/49GALwolKYG.SFM": "e800eac1bd44d316a1ae1934dc2028a8",
"assets/assets/project/data/books/C01/631JNwolKYG.SFM": "f881d86ff2780c811fc2c4cf24ebbe41",
"assets/assets/project/data/books/C01/67REVwolKYG.SFM": "d12f180765604d6d9abf9b262b5449ef",
"assets/assets/project/data/books/C01/34NAMwolKYG.SFM": "164274cbdd912d8944135fded9d9accd",
"assets/assets/project/data/books/C01/20PROwolKYG.SFM": "e6fdc0622d166f7bccdcbd3c745713ad",
"assets/assets/project/data/books/C01/25LAMwolKYG.SFM": "39bbf7667cb8222cf79c2ed7901544fa",
"assets/assets/project/data/books/C01/Suseef%2520-%2520Copy-Corey's%2520MacBook%2520Pro%25202012.sfm": "78e9a03d6beff6da9a8d32793b73e098",
"assets/assets/project/data/books/C01/531THwolKYG.SFM": "9b81c9b231e31cbe7086cffa7450bfd5",
"assets/assets/project/data/books/C01/111KIwolKYG.SFM": "0e00e455129880c5daed5d553ae7548c",
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
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
