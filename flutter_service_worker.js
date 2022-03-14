'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "6bc521c4f5a00a15c5f344f0d9e5942a",
"index.html": "f8289126b21ae638d17099706f4bc828",
"/": "f8289126b21ae638d17099706f4bc828",
"main.dart.js": "82be42325abb4d6c17d71d4840ff2e5a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "1ff87a0889d2f2602d6a72a708703e4b",
"assets/AssetManifest.json": "f7c4f2896616e97d8d717f639d94de2e",
"assets/NOTICES": "e8ddb7d9bcf047a4218e1502a0551c32",
"assets/FontManifest.json": "e60b431b74dcf6fc323c5826b932a984",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/shrine_images/33-0.jpg": "b95b0ace9e0637e6b5e8701e0a969807",
"assets/packages/shrine_images/17-0.jpg": "38063393e595ea9a8b3cd1506787d92f",
"assets/packages/shrine_images/9-0.jpg": "8069aef3d079a13960c9e99faa5bb202",
"assets/packages/shrine_images/28-0.jpg": "4119f3e71c38a6eb047a2ff6a7d74b8b",
"assets/packages/shrine_images/15-0.jpg": "fff60b95217c2c443546a09760175702",
"assets/packages/shrine_images/31-0.jpg": "6e9c7a0282c8dfb0bacbafa5b9598f92",
"assets/packages/shrine_images/35-0.jpg": "70ba6a1c10a14d92e2345779eb5bb82d",
"assets/packages/shrine_images/11-0.jpg": "307bcf0b51d37a949dec4e62b84a7c50",
"assets/packages/shrine_images/13-0.jpg": "758c3c9ca1f6e70f64a46a5a411fe426",
"assets/packages/shrine_images/37-0.jpg": "8400e66014b44b1a653183463a5b243d",
"assets/packages/shrine_images/14-0.jpg": "158b7a582cbecf20ea90d2ea98dbe301",
"assets/packages/shrine_images/2.0x/33-0.jpg": "77e8288671197c1617328eb2018af730",
"assets/packages/shrine_images/2.0x/17-0.jpg": "2db0f8dff70ebc61250c745974c1e822",
"assets/packages/shrine_images/2.0x/9-0.jpg": "125e814ac7495726ae8e4faf650861c6",
"assets/packages/shrine_images/2.0x/28-0.jpg": "658ab1c5b0b076a603ec9149070f60e2",
"assets/packages/shrine_images/2.0x/15-0.jpg": "c1b678ea76eee74433c98369df0d1bdc",
"assets/packages/shrine_images/2.0x/31-0.jpg": "1468b80abf5d292867dff53fcf68c4e5",
"assets/packages/shrine_images/2.0x/35-0.jpg": "734b424507fdce02644ce857e7eb4244",
"assets/packages/shrine_images/2.0x/11-0.jpg": "13f8219194be4323d7c55f6667c54866",
"assets/packages/shrine_images/2.0x/13-0.jpg": "9fe2238fe2718a181433f4d300ad9ac6",
"assets/packages/shrine_images/2.0x/37-0.jpg": "0ed9fb933b68fa0acdc7066ff7eadaf2",
"assets/packages/shrine_images/2.0x/14-0.jpg": "25703fe09d52fb2e58d486a0864b71ae",
"assets/packages/shrine_images/2.0x/29-0.jpg": "91fcd84d4b7d5b88fdb3b4035f8e1413",
"assets/packages/shrine_images/2.0x/30-0.jpg": "e152d302ace79e6d5db43e192b4e5b70",
"assets/packages/shrine_images/2.0x/32-0.jpg": "6840afbeac3621156d5c06d6925e6f37",
"assets/packages/shrine_images/2.0x/8-0.jpg": "722d4083bd61482e52c15f9d1d8c3fe8",
"assets/packages/shrine_images/2.0x/16-0.jpg": "ce8ee93796c9a16f13e06d1f5c58ff7e",
"assets/packages/shrine_images/2.0x/12-0.jpg": "0991f476c7d99b1c4fe124f168b2d5b3",
"assets/packages/shrine_images/2.0x/36-0.jpg": "4fa2a3db8ca69fb8b295245f7c6a8ce7",
"assets/packages/shrine_images/2.0x/34-0.jpg": "24b1ac267d0b1b7436bc79ef4d86571f",
"assets/packages/shrine_images/2.0x/10-0.jpg": "14c4f0b31dd0c56f494f0b9733150c37",
"assets/packages/shrine_images/2.0x/21-0.jpg": "5db8b9f6b757f3d505ed9c93763edd87",
"assets/packages/shrine_images/2.0x/2-0.jpg": "d81ddfa43a08f9f490ce1e11c6f32649",
"assets/packages/shrine_images/2.0x/0-0.jpg": "567fc9e10096243d5b1682e41085adf9",
"assets/packages/shrine_images/2.0x/23-0.jpg": "694a8b748befca33d598fbde5f7be3b7",
"assets/packages/shrine_images/2.0x/4-0.jpg": "ff0ac68da148e4960b371f398048df7d",
"assets/packages/shrine_images/2.0x/27-0.jpg": "8e7898165fce2dc5a63d92ef12d79f0f",
"assets/packages/shrine_images/2.0x/25-0.jpg": "a68fcf2ce1a0572fdf132439179ecadc",
"assets/packages/shrine_images/2.0x/6-0.jpg": "a382c96bf484b0a04d4a5d6a01d53a74",
"assets/packages/shrine_images/2.0x/18-0.jpg": "0575c5baa6d83e263c38efaf8fbb42b2",
"assets/packages/shrine_images/2.0x/22-0.jpg": "55b04621fd6d6fc0fee515f25f31776d",
"assets/packages/shrine_images/2.0x/1-0.jpg": "c7118fcae307e4a7cbbf0b35f5634489",
"assets/packages/shrine_images/2.0x/3-0.jpg": "ba3da87287544a91753a367b98d52a89",
"assets/packages/shrine_images/2.0x/20-0.jpg": "cb60384c66a08433c183426de2bd30df",
"assets/packages/shrine_images/2.0x/19-0.jpg": "bc0a09d9528f18b8d6b6b7bb29a830cd",
"assets/packages/shrine_images/2.0x/7-0.jpg": "c8c09a6f1e29ae38b964a148670a4ac8",
"assets/packages/shrine_images/2.0x/24-0.jpg": "a85a532d6697595cde408fce12dc8b81",
"assets/packages/shrine_images/2.0x/26-0.jpg": "ab74dd40a480bd7ba961fe5dbbfd5dc0",
"assets/packages/shrine_images/2.0x/5-0.jpg": "3e4f39db19f699f3db548693bb0bebef",
"assets/packages/shrine_images/29-0.jpg": "ca11a388bc08ead39912c2cf361140cd",
"assets/packages/shrine_images/30-0.jpg": "9da4cc70092b5973996a9b05f9a4c351",
"assets/packages/shrine_images/32-0.jpg": "d6f1b9d586c955f871e56bb95c47cc98",
"assets/packages/shrine_images/8-0.jpg": "4b2af19930d6faf4fa0c393bc9f32bde",
"assets/packages/shrine_images/16-0.jpg": "79e93a395d04737df815bb6bf7e83baa",
"assets/packages/shrine_images/12-0.jpg": "6e23edb47278260a0418a817aba843c0",
"assets/packages/shrine_images/36-0.jpg": "4a814c4a3d6a0af97b3016050f4c75ce",
"assets/packages/shrine_images/34-0.jpg": "49dcca5ea4ece2d35a433e902cc82a33",
"assets/packages/shrine_images/3.0x/33-0.jpg": "88690b196aa60a5f87d9f445be10829e",
"assets/packages/shrine_images/3.0x/17-0.jpg": "e9096a662af08fa8a0b2f7a249f14bb4",
"assets/packages/shrine_images/3.0x/9-0.jpg": "affeb6c351219f9340d6a1e1606019da",
"assets/packages/shrine_images/3.0x/28-0.jpg": "19eff320f190488cceacadb02b179ea9",
"assets/packages/shrine_images/3.0x/15-0.jpg": "50f028fb390cfaa0f6f753c74ba350c6",
"assets/packages/shrine_images/3.0x/31-0.jpg": "4de26420a08793b35f63cdad08be106d",
"assets/packages/shrine_images/3.0x/35-0.jpg": "eb04060439c948c09835fd4ca7a2597d",
"assets/packages/shrine_images/3.0x/11-0.jpg": "22052736148d59bbd8973ff7fc4e4dea",
"assets/packages/shrine_images/3.0x/13-0.jpg": "5c611563cbb7bde9d0e1bc32f3e72ef7",
"assets/packages/shrine_images/3.0x/37-0.jpg": "e439015083aedd1df21d6ebd15ba079f",
"assets/packages/shrine_images/3.0x/14-0.jpg": "b4dd2d70d3018a219d2c6dfe1631abe0",
"assets/packages/shrine_images/3.0x/29-0.jpg": "22209749436aeb3fe8df97c2bacabf73",
"assets/packages/shrine_images/3.0x/30-0.jpg": "645e267845b69121255c77fdf6936e71",
"assets/packages/shrine_images/3.0x/32-0.jpg": "bc9e81cc56b61885cb046a32531cc41a",
"assets/packages/shrine_images/3.0x/8-0.jpg": "6de8548d738c03cb0ec8c00a1a9680b2",
"assets/packages/shrine_images/3.0x/16-0.jpg": "aa3646973515affef582512ab39a183b",
"assets/packages/shrine_images/3.0x/12-0.jpg": "310819a0b53f92b3bd31fbea2b85a789",
"assets/packages/shrine_images/3.0x/36-0.jpg": "e2981239a0fdb7565caab7a94e4f1fb4",
"assets/packages/shrine_images/3.0x/34-0.jpg": "e99900dc84046703725cc3fcac18f0c3",
"assets/packages/shrine_images/3.0x/10-0.jpg": "9286bbc94416379705ca479f62ff69dd",
"assets/packages/shrine_images/3.0x/21-0.jpg": "fdc64c3abaa4f18242909677697df6c5",
"assets/packages/shrine_images/3.0x/2-0.jpg": "d9c04ed1fe0cc95925d4e43c7eb8a163",
"assets/packages/shrine_images/3.0x/0-0.jpg": "9f55a9a86b4d423947c5630a4954763b",
"assets/packages/shrine_images/3.0x/23-0.jpg": "457162e9fbaa6fc4a9f04b043febafbf",
"assets/packages/shrine_images/3.0x/4-0.jpg": "81090aeadec8494f4075c628d9fa694b",
"assets/packages/shrine_images/3.0x/27-0.jpg": "eda328e26357e013ba41bedaeb27e0f4",
"assets/packages/shrine_images/3.0x/25-0.jpg": "b974b151f54e91f39f481aadb3a40d68",
"assets/packages/shrine_images/3.0x/6-0.jpg": "4902f47b6f76a683ee19c7ea0f720254",
"assets/packages/shrine_images/3.0x/18-0.jpg": "c3d778aa170bb0a8fe3d06d0f6a80a61",
"assets/packages/shrine_images/3.0x/22-0.jpg": "9b53863793bd210ec7d159e87aebc0be",
"assets/packages/shrine_images/3.0x/1-0.jpg": "a499c97dc22231edf250da04a76377fb",
"assets/packages/shrine_images/3.0x/3-0.jpg": "96ff246fd96221efb9cc949ad68c8bcd",
"assets/packages/shrine_images/3.0x/20-0.jpg": "e8fae7ac109e6893b0cb97bbb9d6b41d",
"assets/packages/shrine_images/3.0x/19-0.jpg": "a4aaa7261cab9157791c4f152c6ba5e6",
"assets/packages/shrine_images/3.0x/7-0.jpg": "359717e39b3aafbc41e59858d092fb63",
"assets/packages/shrine_images/3.0x/24-0.jpg": "9ee29440dbea09c900eea9bd31ac3934",
"assets/packages/shrine_images/3.0x/26-0.jpg": "bbc6062c1c23678a5b86e493a648c2b6",
"assets/packages/shrine_images/3.0x/5-0.jpg": "2e04290cee7c0ab77e4d195300a9215a",
"assets/packages/shrine_images/10-0.jpg": "8e156e859d8b0f155b29e1b41f8878c2",
"assets/packages/shrine_images/21-0.jpg": "c21fcd094a4841e1a97bbbda76785945",
"assets/packages/shrine_images/2-0.jpg": "061d352f1afe2755e294f8e2428b16ef",
"assets/packages/shrine_images/0-0.jpg": "63c1cb3d139d57f3abadaa6b1a47e9ec",
"assets/packages/shrine_images/23-0.jpg": "b684c2225ccbc14ec14dd65fb68ddd76",
"assets/packages/shrine_images/4-0.jpg": "0fe383ff6affdd0fc2493c2131b2e3c8",
"assets/packages/shrine_images/27-0.jpg": "e1a12f3491860a2756e7e1537449b10d",
"assets/packages/shrine_images/25-0.jpg": "0ff35e583472078e2ab670b6ed06d2dc",
"assets/packages/shrine_images/6-0.jpg": "ecaead6e9443503ad161f39062668b14",
"assets/packages/shrine_images/18-0.jpg": "3f144fe7979040f3e7d7277c7a07c2ed",
"assets/packages/shrine_images/22-0.jpg": "ffbccb086af16dc5862a6f76ddb6356a",
"assets/packages/shrine_images/1-0.jpg": "3911b473b253bd7cd808c3f78320970a",
"assets/packages/shrine_images/3-0.jpg": "0fa71fb00d37a3a9ae0a08dc39ea9ab3",
"assets/packages/shrine_images/20-0.jpg": "014cab213b9f871119c32079eabc191e",
"assets/packages/shrine_images/19-0.jpg": "bacf82d72a8eb386a7ba6b28f846df73",
"assets/packages/shrine_images/7-0.jpg": "e0e41a63648469bdc60af8570b71ebd6",
"assets/packages/shrine_images/24-0.jpg": "a92c8b074a41abf30eedc66f25e30704",
"assets/packages/shrine_images/26-0.jpg": "8362eead8df268194bef78d40324306d",
"assets/packages/shrine_images/5-0.jpg": "5242b866fe8531060757c059d423d96c",
"assets/fonts/Rubik-Medium.ttf": "394a3b3371914d7a65e80ff82ae35f78",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/fonts/Rubik-Regular.ttf": "6c980940392587c8d7d325c07965ebda",
"assets/assets/2.0x/diamond.png": "85f6d367acb2a35d87efe84f5c3a9168",
"assets/assets/3.0x/diamond.png": "3104c8b69c9dc7e6e2e4e703c460b64c",
"assets/assets/diamond.png": "10f8a6c14246d2f05839c8c30e4a4bdd",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
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
