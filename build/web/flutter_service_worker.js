'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "f75229385fea6e08cd7a98fff46367df",
"index.html": "8da8658bedeb5d71493b7ab1fe1d9da6",
"/": "8da8658bedeb5d71493b7ab1fe1d9da6",
"main.dart.js": "51b15f025a7ab2c16176c1c52bcb8ab6",
"flutter.js": "0816e65a103ba8ba51b174eeeeb2cb67",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "a6615e6c25831e6a32425be7afebd8a2",
"assets/AssetManifest.json": "8ccd3321ca5a639c6f3e1c8c7325ecf7",
"assets/NOTICES": "f28046005197e7bd6befa52ae739b353",
"assets/FontManifest.json": "9c61d404ac24fadbefcd3f3067e3d23e",
"assets/packages/window_manager/images/ic_chrome_unmaximize.png": "4a90c1909cb74e8f0d35794e2f61d8bf",
"assets/packages/window_manager/images/ic_chrome_minimize.png": "4282cd84cb36edf2efb950ad9269ca62",
"assets/packages/window_manager/images/ic_chrome_maximize.png": "af7499d7657c8b69d23b85156b60298c",
"assets/packages/window_manager/images/ic_chrome_close.png": "75f4b8ab3608a05461a31fc18d6b47c2",
"assets/packages/fluent_ui/fonts/FluentIcons.ttf": "1cd173aed13e298ab2663dd0924f6762",
"assets/packages/fluent_ui/assets/AcrylicNoise.png": "81f27726c45346351eca125bd062e9a7",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/project/appDef.appDef": "726d98017aefd88ecb0b074d306babe4",
"assets/assets/project/data/contents/contents.xml": "768e937d900b75fdd1e4b015c4b31499",
"assets/assets/project/data/images/drawable-xxxhdpi/ic_launcher.png": "8786a4dcd43d187838464650947d0a27",
"assets/assets/project/data/about/audio-not-found.txt": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/project/data/about/about.txt": "2c0368584fce81a7a6f0747b79f64c47",
"assets/assets/project/data/about/expiry.txt": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/project/data/books/C01/23ISAwolKYG.SFM": "e37a27512d8ad52b3ac5f0feb698762b",
"assets/assets/project/data/books/C01/142CHwolKYG.SFM": "d3252e7d939fd0010910c574d86a88e4",
"assets/assets/project/data/books/C01/653JNwolKYG.SFM": "f5f0d38132a8c3c68f9ba2df81900979",
"assets/assets/project/data/books/C01/05DEUwolKYG.SFM": "3a785ff573bdb93d4ca720cdef174b21",
"assets/assets/project/data/books/C01/19PSAwolKYG.SFM": "ac672cff57f003b87baa0622d478022f",
"assets/assets/project/data/books/C01/44JHNwolKYG.SFM": "71d8e7c0e79054cbf75f7d887fb48551",
"assets/assets/project/data/books/C01/41MATwolKYG.SFM": "02bdb008225ecbf4962b32236d416714",
"assets/assets/project/data/books/C01/37HAGwolKYG.SFM": "8e348664cc50b3d797590585146eb4a6",
"assets/assets/project/data/books/C01/35HABwolKYG.SFM": "6849e47f8e76f8862788e63c88c60ecc",
"assets/assets/project/data/books/C01/51PHPwolKYG.SFM": "4e689cd91a940db782b05d0555a2e316",
"assets/assets/project/data/books/C01/31OBAwolKYG.SFM": "435f931e349d6c9af884f85e17d4d44e",
"assets/assets/project/data/books/C01/59HEBwolKYG.SFM": "eb2561490c2679aa63342e4b500c7925",
"assets/assets/project/data/books/C01/622PEwolKYG.SFM": "6f4448d0fee6fab9acd37d313ffbd909",
"assets/assets/project/data/books/C01/562TIwolKYG.SFM": "3db415815acfcf8896c7352a6659fb95",
"assets/assets/project/data/books/C01/Suseef%2520-%2520Copy.sfm": "bbc34ab59b8bcea6126ed3cdd9ade0f3",
"assets/assets/project/data/books/C01/52COLwolKYG.SFM": "1817e4e7a4dbc7a4bfa7f19117bb9c44",
"assets/assets/project/data/books/C01/38ZECwolKYG.SFM": "f923be699ebd331290c308f77bc5615c",
"assets/assets/project/data/books/C01/471COwolKYG.SFM": "96963d89cd51610fc0bb74a6cbac9235",
"assets/assets/project/data/books/C01/26EZKwolKYG.SFM": "82ee1036d2e71e47e5f115d50fd62164",
"assets/assets/project/data/books/C01/03LEVwolKYG.SFM": "9d30bf6f4bf83b0d032c36ab66974abc",
"assets/assets/project/data/books/C01/43LUKwolKYG.SFM": "5a4b1405499564db432977694fcc4b25",
"assets/assets/project/data/books/C01/58PHMwolKYG.SFM": "92930f71eedcbf5bc456b045c4d1a5d5",
"assets/assets/project/data/books/C01/122KIwolKYG.SFM": "ea069d43eca2b382527ddac068612769",
"assets/assets/project/data/books/C01/29JOLwolKYG.SFM": "d4fb15c1c4459ac61eccf9738f1b2952",
"assets/assets/project/data/books/C01/30AMOwolKYG.SFM": "4e9b409d184252af88482c20f097ba32",
"assets/assets/project/data/books/C01/60JASwolKYG.SFM": "0edbd125a5842c5130905a93d1db81a7",
"assets/assets/project/data/books/C01/32JONwolKYG.SFM": "0e946c8c3fb207def109c3e10a566d2b",
"assets/assets/project/data/books/C01/06JOSwolKYG.SFM": "16bfd94b923ce7b1ae478d41570393ce",
"assets/assets/project/data/books/C01/01GENwolKYG.SFM": "9d63bfcf2f2b1878754aab4632607185",
"assets/assets/project/data/books/C01/24JERwolKYG.SFM": "40a9684e855ca8b864bbec956c5529de",
"assets/assets/project/data/books/C01/33MICwolKYG.SFM": "915cfa3cd7e72ba6de39615c1bc99e53",
"assets/assets/project/data/books/C01/27DANwolKYG.SFM": "15d286fd284494ae9827d2a0452d324d",
"assets/assets/project/data/books/C01/131CHwolKYG.SFM": "90a2200190a21dbbc36708fca7b9bd88",
"assets/assets/project/data/books/C01/542THwolKYG.SFM": "4429ae21a1e48728ac2f79a25282c948",
"assets/assets/project/data/books/C01/102SAwolKYG.SFM": "79552f84693886bb675763ce89597bd3",
"assets/assets/project/data/books/C01/50EPHwolKYG.SFM": "a91765ff5e25b8e089d48eeed4d9b8c7",
"assets/assets/project/data/books/C01/551TIwolKYG.SFM": "14afe94bd42d76b2e4a85bcb4db0a28e",
"assets/assets/project/data/books/C01/18JOBwolKYG.SFM": "b441d0e95ea7991b4e80d807c02ac778",
"assets/assets/project/data/books/C01/642JNwolKYG.SFM": "c07921b63c3a83d6f02aec1ab70b269c",
"assets/assets/project/data/books/C01/15EZRwolKYG.SFM": "5447ac59893b26b71c28c7e6912a7bed",
"assets/assets/project/data/books/C01/04NUMwolKYG.SFM": "450ef2752ba9aa188427a6b649d3d52a",
"assets/assets/project/data/books/C01/36ZEPwolKYG.SFM": "a5ec4926cff10e94522d0457eefa0dec",
"assets/assets/project/data/books/C01/46ROMwolKYG.SFM": "cbcb9a3d92a1f809a30da91c132acf2d",
"assets/assets/project/data/books/C01/42MRKwolKYG.SFM": "fb996542c994abb5e2995062a492a429",
"assets/assets/project/data/books/C01/611PEwolKYG.SFM": "c8c6115fd58b69e688ce8a6384956f96",
"assets/assets/project/data/books/C01/45ACTwolKYG.SFM": "44832e115dc5c15f0dcfa26253d78aed",
"assets/assets/project/data/books/C01/57TITwolKYG.SFM": "186542e664b926cc934ef2cff4bcfcc6",
"assets/assets/project/data/books/C01/091SAwolKYG.SFM": "c90bdc16b2da7fc31cc75c3532e71803",
"assets/assets/project/data/books/C01/66JUDwolKYG.SFM": "1d952f096e3531b6b6254b982dd8220f",
"assets/assets/project/data/books/C01/39MALwolKYG.SFM": "6bc3cb79b7ea21c5611f56981ce8ab46",
"assets/assets/project/data/books/C01/16NEHwolKYG.SFM": "4699df28bea1ca2f742dbda7b028f973",
"assets/assets/project/data/books/C01/21ECCwolKYG.SFM": "1c3cec63b569968a96fdebd3de34c2cc",
"assets/assets/project/data/books/C01/02EXOwolKYG.SFM": "005dd325a0bc62e53ee6f77d341de272",
"assets/assets/project/data/books/C01/28HOSwolKYG.SFM": "9a39901aab16a647ab2416b73ebd1378",
"assets/assets/project/data/books/C01/07JDGwolKYG.SFM": "f18d2f356c4246eacd774132853bea48",
"assets/assets/project/data/books/C01/17ESTwolKYG.SFM": "9a093efaeea8de0605ae8f3a2d90c4e8",
"assets/assets/project/data/books/C01/08RUTwolKYG.SFM": "5dd059b8cae43aa2809112e6aae3c1f9",
"assets/assets/project/data/books/C01/482COwolKYG.SFM": "ea75d47a9562b6238cfd6bc44e849a25",
"assets/assets/project/data/books/C01/22SNGwolKYG.SFM": "8e815d9f4529b8872d3f104dc2aaf5d0",
"assets/assets/project/data/books/C01/49GALwolKYG.SFM": "f289da2c6faa546e8be19dc6aa371b7d",
"assets/assets/project/data/books/C01/631JNwolKYG.SFM": "11a912475c26e8c58cfcb86418b0b6f9",
"assets/assets/project/data/books/C01/67REVwolKYG.SFM": "f2d536249a2ef37abe8f42692a5f0240",
"assets/assets/project/data/books/C01/34NAMwolKYG.SFM": "d5f2b6b7654c985841e391e09f28b210",
"assets/assets/project/data/books/C01/20PROwolKYG.SFM": "9e3d0b37a234a914b9f85b3e538d2f9c",
"assets/assets/project/data/books/C01/25LAMwolKYG.SFM": "b564b8ab8d6bfe343ca43c870d08471d",
"assets/assets/project/data/books/C01/Suseef%2520-%2520Copy-Corey's%2520MacBook%2520Pro%25202012.sfm": "78e9a03d6beff6da9a8d32793b73e098",
"assets/assets/project/data/books/C01/531THwolKYG.SFM": "2998d539c7ddbbd021d96b4956818995",
"assets/assets/project/data/books/C01/111KIwolKYG.SFM": "0805fa4d0a74fddab09e9cca84ff3f67",
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
"assets/assets/project/data/books/C03/33%2520ENG%255BB%255DLEB2012.sfm": "47d0ace150deaf1be94a04b3a89efad3",
"assets/assets/project/data/books/C03/42%2520ENG%255BB%255DLEB2012.sfm": "7aacd3f3e4793dc6c0d4676c1f95000a",
"assets/assets/project/data/books/C03/02%2520ENG%255BB%255DLEB2012.sfm": "af92e4963fef049995cf0b86cc3eae4f",
"assets/assets/project/data/books/C03/11%2520ENG%255BB%255DLEB2012.sfm": "80037f3288dd090a1ddeaed88b26ea01",
"assets/assets/project/data/books/C03/60%2520ENG%255BB%255DLEB2012.sfm": "72e3c4997c59d89e2192999b28c00451",
"assets/assets/project/data/books/C03/51%2520ENG%255BB%255DLEB2012.sfm": "8f7cde8b02f8c35dc7494baa9dd35d5d",
"assets/assets/project/data/books/C03/20%2520ENG%255BB%255DLEB2012.sfm": "79ae1e8e2a9a8f4911361ac1482e4ebc",
"assets/assets/project/data/books/C03/49%2520ENG%255BB%255DLEB2012.sfm": "2b11fbfa31f0790009b9cccfca097c6b",
"assets/assets/project/data/books/C03/38%2520ENG%255BB%255DLEB2012.sfm": "e64079aa19403fa7c3772ace8e92fbb1",
"assets/assets/project/data/books/C03/06%2520ENG%255BB%255DLEB2012.sfm": "1af8b0577404cd7e01e0ad21d9fb4ff8",
"assets/assets/project/data/books/C03/09%2520ENG%255BB%255DLEB2012.sfm": "f3e5b05ac93ef8e20b77bfdf483f4a4c",
"assets/assets/project/data/books/C03/37%2520ENG%255BB%255DLEB2012.sfm": "9fd126bde979931b6a5076806de573b6",
"assets/assets/project/data/books/C03/46%2520ENG%255BB%255DLEB2012.sfm": "da556dac942d1d88c6c5eb09d99a9535",
"assets/assets/project/data/books/C03/55%2520ENG%255BB%255DLEB2012.sfm": "fceb95441ff44e3d0f21c13753eef6f1",
"assets/assets/project/data/books/C03/24%2520ENG%255BB%255DLEB2012.sfm": "eab1c645aa9999b92aef548847103c06",
"assets/assets/project/data/books/C03/15%2520ENG%255BB%255DLEB2012.sfm": "e7f4725d132a7e02878ad98f6e612089",
"assets/assets/project/data/books/C03/64%2520ENG%255BB%255DLEB2012.sfm": "ca1f97ce203e5d15669b8d1ecb77d627",
"assets/assets/project/data/books/C03/56%2520ENG%255BB%255DLEB2012.sfm": "85346858723988c61de94f06d468eef7",
"assets/assets/project/data/books/C03/27%2520ENG%255BB%255DLEB2012.sfm": "630261579c188491ddae9dd0994372a4",
"assets/assets/project/data/books/C03/19%2520ENG%255BB%255DLEB2012.sfm": "62738654db635ba4aa7e5e3742fd6b5c",
"assets/assets/project/data/books/C03/16%2520ENG%255BB%255DLEB2012.sfm": "c1cc5191598eb3a03aa95e80f2a01ba2",
"assets/assets/project/data/books/C03/28%2520ENG%255BB%255DLEB2012.sfm": "51b5443cd1b14af4033b017912519f65",
"assets/assets/project/data/books/C03/59%2520ENG%255BB%255DLEB2012.sfm": "5d199627702989685d6a88032bece6c0",
"assets/assets/project/data/books/C03/05%2520ENG%255BB%255DLEB2012.sfm": "bc5ea7de7462efa2edb7b54abe1f6e5a",
"assets/assets/project/data/books/C03/34%2520ENG%255BB%255DLEB2012.sfm": "5f9fab3adeae0bafd6a58c70f0565ce1",
"assets/assets/project/data/books/C03/45%2520ENG%255BB%255DLEB2012.sfm": "3ae8264f87427edde3d62ded12811c88",
"assets/assets/project/data/books/C03/12%2520ENG%255BB%255DLEB2012.sfm": "711f5531c990d7d25d76c74bf9c60832",
"assets/assets/project/data/books/C03/63%2520ENG%255BB%255DLEB2012.sfm": "961c5a315150bb6081ee0064647fc7b4",
"assets/assets/project/data/books/C03/52%2520ENG%255BB%255DLEB2012.sfm": "305b2669226593ea262d5d8e949543a4",
"assets/assets/project/data/books/C03/23%2520ENG%255BB%255DLEB2012.sfm": "e5f82a850c2ee54ae277284f19fd1d27",
"assets/assets/project/data/books/C03/30%2520ENG%255BB%255DLEB2012.sfm": "503ac0b3d29931532e51593e9637cf2f",
"assets/assets/project/data/books/C03/41%2520ENG%255BB%255DLEB2012.sfm": "8e986d0f931ba6f0788e7d8fe8f62dd3",
"assets/assets/project/data/books/C03/01%2520ENG%255BB%255DLEB2012.sfm": "72f7b72f348551f9d38227266cd50270",
"assets/assets/project/data/books/C03/65%2520ENG%255BB%255DLEB2012.sfm": "6fa2943b58cae5a12b2daaf0b3937108",
"assets/assets/project/data/books/C03/14%2520ENG%255BB%255DLEB2012.sfm": "be8618bd8787b6c97dbe8e21ed5197d1",
"assets/assets/project/data/books/C03/25%2520ENG%255BB%255DLEB2012.sfm": "320b8e6164c99fa9eddfab9ec6931ea2",
"assets/assets/project/data/books/C03/54%2520ENG%255BB%255DLEB2012.sfm": "c4a7cef11f6ae97c314a9bee11652f01",
"assets/assets/project/data/books/C03/47%2520ENG%255BB%255DLEB2012.sfm": "e398b8bfbcbcb3ff0b7a1846848663b8",
"assets/assets/project/data/books/C03/36%2520ENG%255BB%255DLEB2012.sfm": "9a86c6f7f8955cbb6b9175a9f0ba5354",
"assets/assets/project/data/books/C03/08%2520ENG%255BB%255DLEB2012.sfm": "a4439af214d9080995c3511afcafe4d3",
"assets/assets/project/data/books/C03/07%2520ENG%255BB%255DLEB2012.sfm": "cc0d7b381e3d693a2cced2c5fdd4465a",
"assets/assets/project/data/books/C03/39%2520ENG%255BB%255DLEB2012.sfm": "369bc88e3e2e9509457f90948b9f5f00",
"assets/assets/project/data/books/C03/48%2520ENG%255BB%255DLEB2012.sfm": "4eb65462c4a51efe22380bf031fad585",
"assets/assets/project/data/books/C03/21%2520ENG%255BB%255DLEB2012.sfm": "dbbcb77896c52ba2def1d97198412b99",
"assets/assets/project/data/books/C03/50%2520ENG%255BB%255DLEB2012.sfm": "d85bf86cbe87574fea6586df5e7e0b2a",
"assets/assets/project/data/books/C03/61%2520ENG%255BB%255DLEB2012.sfm": "5f7d8c2f73db6ebc79f8814159692c0d",
"assets/assets/project/data/books/C03/10%2520ENG%255BB%255DLEB2012.sfm": "91750c11f81d6ac54b63c84d9f403da1",
"assets/assets/project/data/books/C03/03%2520ENG%255BB%255DLEB2012.sfm": "6c05b0c75ca4cd9f2f029b2d72c68b21",
"assets/assets/project/data/books/C03/43%2520ENG%255BB%255DLEB2012.sfm": "79a89afeede7675cf3f0629de8e8a90e",
"assets/assets/project/data/books/C03/32%2520ENG%255BB%255DLEB2012.sfm": "9122fbf813604606675ad296db043148",
"assets/assets/project/data/books/C03/40%2520ENG%255BB%255DLEB2012.sfm": "498babad18b38ef5e9a3e5bbbca8e818",
"assets/assets/project/data/books/C03/31%2520ENG%255BB%255DLEB2012.sfm": "101fdfad5b740f5c6df00ae06e21f43e",
"assets/assets/project/data/books/C03/22%2520ENG%255BB%255DLEB2012.sfm": "f6804cc3419b49da299a30374d8fffa1",
"assets/assets/project/data/books/C03/53%2520ENG%255BB%255DLEB2012.sfm": "1a78b483c14cc48195075034847ce79e",
"assets/assets/project/data/books/C03/62%2520ENG%255BB%255DLEB2012.sfm": "17f01f22ae510248de008794c3146b9c",
"assets/assets/project/data/books/C03/13%2520ENG%255BB%255DLEB2012.sfm": "1e6da51e67e93d6f2716b722df750949",
"assets/assets/project/data/books/C03/44%2520ENG%255BB%255DLEB2012.sfm": "3fe561980269621bbbd08a0bf1b4c6d8",
"assets/assets/project/data/books/C03/35%2520ENG%255BB%255DLEB2012.sfm": "fa272d332fa47b3249f4a265099b1ecd",
"assets/assets/project/data/books/C03/04%2520ENG%255BB%255DLEB2012.sfm": "f880e0be712b53ecbfca75143118ae2e",
"assets/assets/project/data/books/C03/58%2520ENG%255BB%255DLEB2012.sfm": "9284f86dc043235a10070bbfa2506035",
"assets/assets/project/data/books/C03/66%2520ENG%255BB%255DLEB2012.sfm": "aa1bb93a73f6dcca9681717366abe7a0",
"assets/assets/project/data/books/C03/29%2520ENG%255BB%255DLEB2012.sfm": "fecdf680931790b3c56edc44cd6031f7",
"assets/assets/project/data/books/C03/17%2520ENG%255BB%255DLEB2012.sfm": "6a4cafaf1980ac726cc237498c9f459f",
"assets/assets/project/data/books/C03/18%2520ENG%255BB%255DLEB2012.sfm": "c25b255efa7b648ec0712f50ad53e9a7",
"assets/assets/project/data/books/C03/26%2520ENG%255BB%255DLEB2012.sfm": "260ddc1ab30cbffb38cfce602216d7bd",
"assets/assets/project/data/books/C03/57%2520ENG%255BB%255DLEB2012.sfm": "b4615c1efd51116bf7c39cce206a9fe1",
"assets/assets/project/data/fonts/font2-R.ttf": "a2f45e9509ff156c6591d3b48b9d3d2c",
"assets/assets/project/data/fonts/AndikaCompact-R.ttf": "3e4574c4047ec8311b820b234d7f643b",
"assets/assets/project/data/fonts/font2-B.ttf": "a2f45e9509ff156c6591d3b48b9d3d2c",
"assets/assets/project/data/fonts/font1-R.ttf": "bf3b8fa39cbdb09e1ef881c5e94fe98c",
"assets/assets/project/data/fonts/font1-B.ttf": "9cd85723a282d28259b6697699e1f187",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/NOTICES",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
