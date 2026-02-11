'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "0fc8d680319c426f496c136e727c10ce",
"assets/AssetManifest.bin.json": "57718544ca67808e9ea4ea632d515ebf",
"assets/AssetManifest.json": "1fcad9477f47498c2754ef7fc909aa92",
"assets/assets/Andong.png": "105925a511a9c5965b3f863bea0ea91d",
"assets/assets/AngJing.png": "4dd353afefb6d5317c6e826fe10d8d36",
"assets/assets/Angkor.png": "aa7430a55355e926a14a673d07aa2be2",
"assets/assets/Aural.png": "065dec9dc3ea070dec21dbeda82c4ad8",
"assets/assets/bachey.png": "09db87928d2dafcf9e50e687fd3ab05b",
"assets/assets/Bambootrain.png": "189ee950c0b13e314c004ae0d54216a7",
"assets/assets/BanteayMeanchey.png": "aec4dd87cf6d51c8948cc3aa2e5cd5b8",
"assets/assets/BanteayTorb.png": "bf32d5167606931f12370c2497c61d16",
"assets/assets/Baphnom.png": "08f1fde54bf978299cae0d934b62bf3f",
"assets/assets/Baryak.png": "c2c19822ce80ea12d06415c17d354c5a",
"assets/assets/Bassac.png": "604c90974e94dc91c8d6903ef2992edc",
"assets/assets/Battam.png": "8c57c20466418164e04d6cbde31fe63d",
"assets/assets/Battambang.png": "0d37cc5ad3e1a1fd045fb02296dc85c1",
"assets/assets/Bayon.png": "976fa74be0b44a8bd4f1659c1f7c041b",
"assets/assets/bayoung.png": "7e2c13cbf29320abcdc6475c1645050e",
"assets/assets/BengMealea.png": "4b7f8f598abb05c280a0011e29fa3409",
"assets/assets/Bokor.jpg": "fccdb48bdbde179812b137f31099a002",
"assets/assets/borei.png": "b59ffee026c7ede834549da827cd7a0d",
"assets/assets/bousra.png": "4bfa68affa4ba6cd03724d797ca2565c",
"assets/assets/Cambodia.jpg": "b3e4a4682981b4581793921ae07edbbc",
"assets/assets/Cardamom.png": "fcfdc91efa37654a1c23ba99545604bc",
"assets/assets/chaiprui.png": "637933d14d665e193d4ebb1a879dd2b6",
"assets/assets/Chambok.png": "36cf59bd3137cee1d8034d2081b7d9fa",
"assets/assets/Champei.png": "fdb23a5334fcf5f3a91582ea3f33249b",
"assets/assets/Chanong.png": "371ae5bdef974915864bd2b5b277ca0a",
"assets/assets/chisor.png": "7c25ad660c17cd305552f6f627552032",
"assets/assets/chitapech.png": "9d6d378ac6749b582d65165f6a77b7c2",
"assets/assets/Chmar.png": "9c2a49f38cf5c2bfa19508a386759d1f",
"assets/assets/Chnnang.png": "d7c3b8318cd3e2ebd2c3efed501ef132",
"assets/assets/ChreyThom.png": "a6f9ecc69e4db8f76bb31b4ffe9ed131",
"assets/assets/chrork.png": "fc979f0e9ee494bbc3384ad442ac9bf2",
"assets/assets/Crab.png": "1b8e89d855a12925e0ac2984560ac434",
"assets/assets/DeyRolous.png": "fa645068f0b2cfc56c3595a7f0533427",
"assets/assets/Farmcroco.png": "5e024d22e63010fdef29e2cfabdcdad8",
"assets/assets/Floating.png": "5701da7ea5cd7706c083b60a6d011825",
"assets/assets/flower.png": "4895367a0d4a67e1d0de4d95b486cf81",
"assets/assets/hanchey.png": "f20ec1f7ec4f4fb0157af6e982fce6c2",
"assets/assets/houng.png": "a12241b7d5ba2058e3eb77c2887ecc62",
"assets/assets/Independence.png": "a9010eb52c3a99fe62fa6671e916af41",
"assets/assets/Jihor.png": "1f8781802a9b738d273af21cc7d9b71a",
"assets/assets/Kaley.png": "b817eb993b32fde18c24f61f542dddd3",
"assets/assets/Kampi.png": "e7aa654fb55c478950c85be2d3d399ae",
"assets/assets/KampongTrach.png": "ee5f9153e5a4718f0b7d6c1330a751b1",
"assets/assets/Kandal.png": "7b24664b1067d2de8250cc5166c86bfc",
"assets/assets/Katieng.png": "219d9ef2ed7cdd62f78a25e0bab6db7c",
"assets/assets/KbalChay.png": "394bdfccf59a08d69064b6c5a3b2eaef",
"assets/assets/Keb.png": "b44cba7ed968b22850fb4d7baf340162",
"assets/assets/Kebbeach.png": "8550cef61635edded84bd59489c3217c",
"assets/assets/kiensvay.png": "9b4630aa4e555aac49da64b5cfa2ab12",
"assets/assets/Kirirom.png": "e7a0fe905ff20ff16ea0a1fd1cde1203",
"assets/assets/KnongPhsar.png": "9b6559f8b8c6588482a31d30f7e09539",
"assets/assets/Kohker.png": "335f905d82f178d7621e35bbc18f61e3",
"assets/assets/KohKong.webp": "45cfe75af5a9235d8c56349cb2adb157",
"assets/assets/KohkongIsland.png": "0c484470b175fbae2aaeb17251c544a3",
"assets/assets/Kohksach.png": "d56ea61f0f35be6467a0fb4f3af3b28b",
"assets/assets/Kohnorea.png": "6f47cae0d3c2d6ca37a54076ef0777a1",
"assets/assets/KohPdao%2520copy.png": "870f8d6cc7004bb495761b25df84370f",
"assets/assets/KohPdao.png": "870f8d6cc7004bb495761b25df84370f",
"assets/assets/Kohpen.png": "837c50f2ee1239a477f450bd2e1486a2",
"assets/assets/Kohrong.png": "d1470e145ba5af0f6bd1b01203f40caa",
"assets/assets/KohTonsay.png": "27d95f01c3b52d41c07684a6c0587f58",
"assets/assets/KohTrong.png": "719336271e204235883b29f982dc53b3",
"assets/assets/KompongCham.jpg": "1b51702d60726faf4c307e0c6b5e26e6",
"assets/assets/KompongChnang.png": "b89d1d342ddfab12962b94c0da0d494c",
"assets/assets/KompongSpeu.png": "121f65e729bef480b68df8ba1d5b60d9",
"assets/assets/KompongThom.png": "160e7ac6f7c2ce5f82de1b64a0f86830",
"assets/assets/Kompot.jpg": "6286d9f1e7d7f0886f2dabc079d9f6d4",
"assets/assets/Kongrei.png": "bb5eb17c96177ee1495607a180d4c3fc",
"assets/assets/Korky.png": "a76c8b51490e0e86b81ebc52e6217a8b",
"assets/assets/Krabei.png": "8bd68962aa03a54087cd4fd690ce1be2",
"assets/assets/Kratie.png": "5bcd305aeb48b1d41fda2bffc674e2d6",
"assets/assets/LaAng.png": "eea46a997687cbff6bc83b5f4afda9da",
"assets/assets/labak.png": "fa06481b00320a99c990c21e20e94bc5",
"assets/assets/MoanThom.png": "d73c86cfa49f1562a05cfd99c8f3e710",
"assets/assets/Mondulkiri.jpg": "03117386a70d2546776aeaa0972d5a90",
"assets/assets/National.png": "4095bbd85193deae93e95a63020b32f4",
"assets/assets/NeakBuos.png": "ee5c9f23fd61c20fcf3b0cfa32061516",
"assets/assets/Nimith.png": "48274d63428df9ca07cd1ba2d703b6e2",
"assets/assets/Nokor.png": "a5b2f4d1953247673ff27f64632ac885",
"assets/assets/obt.png": "eb7048cafe92d77bbd24d16a20f61611",
"assets/assets/OddarMeanchey.png": "ec9fcb4bfbea70ea3f6d07b3591429b8",
"assets/assets/Oresey.png": "97b8f2249b0a53c9b42f23f83e6868f4",
"assets/assets/Otres.png": "db0762dcd0a1186638b8b3272b5d3266",
"assets/assets/ouda.png": "4ca47a7978e03a0ce9a0616f0809d5a0",
"assets/assets/oudong.png": "d7dbe06ff2e4e8d5e589761dd6e5031d",
"assets/assets/Outavau.png": "5ca78a28ecf2ed602231a2c3b34d2316",
"assets/assets/Pailin.png": "79481c1d8a3edd1e5325b5d275a55c27",
"assets/assets/PeamKrasop.png": "7e21ba007877ba0523c05383c895df81",
"assets/assets/phnom1500.png": "4a454ab58996235d015279f14becedc0",
"assets/assets/Phreah.png": "bdefcce9bb5130add7689b947687d6f5",
"assets/assets/Popokvil.png": "f2fe613208bdff521579d000cc43a31c",
"assets/assets/Pp.png": "e1d5e9955a4988a3fd2497e16dbc5f22",
"assets/assets/Prasat.png": "44e9c544b16643a1ef5cc67270d8dec0",
"assets/assets/prasity.png": "8bb630cc44c3e9dd06b8d8db68c45c64",
"assets/assets/PreahTheat.png": "769f6d5c1b6f291931cea094f80c0a27",
"assets/assets/PreahVihea.webp": "f321e8df2fae203252ba5ac95d4b70ee",
"assets/assets/PreyPros.png": "e21b997965a15f3f3638f0f67f01684b",
"assets/assets/Preyveng.png": "300c169fd26752740664470f11ec2847",
"assets/assets/prossrey.png": "b85c4b09b1bb64fef4a6ed7641c0886e",
"assets/assets/PsaNat.png": "f0f98fd97d9c93bec47df29b0d3d762b",
"assets/assets/Pubstreet.png": "b2da3696964488d1e62a79ac2b8263ce",
"assets/assets/Pursat.jpg": "9b98cc1b30a7c0cd7ceffee3ed8354f4",
"assets/assets/RatanakKiri.png": "916935133ff39dd9190633c43b31ccef",
"assets/assets/reachea.png": "34b68f1ec8db28ea6eff7a7ae50a61a4",
"assets/assets/riverside.png": "7e303d9e9ba7f643c2b1789d1daa2264",
"assets/assets/Royal.png": "5c803a3bb5ba24b7526e47fdf2a1daa2",
"assets/assets/Sambor.png": "7e123c1d43e658f4b967363bc9000c5b",
"assets/assets/Santouch.png": "0d761472091e9b22e61b10922c1140d6",
"assets/assets/Santuk%2520copy.png": "fb233fc05aa5ea4b1a3ecd0a4941b903",
"assets/assets/Santuk.png": "fb233fc05aa5ea4b1a3ecd0a4941b903",
"assets/assets/senMonorom.png": "593050e55b8c6d27f31c80bf34ec4f75",
"assets/assets/SiemReap.jpg": "c1939a638d29362ff89f3b63ca394c5c",
"assets/assets/Sihanoukville.jpg": "404bb7a1db47566be00cd9e9ce3a2097",
"assets/assets/stungsen.png": "3b78e38ffba2777c47cdf9070ea6097d",
"assets/assets/StungTreng.png": "2718999aecba5bce287bc489f9c84c1a",
"assets/assets/SvayReang.png": "c90357f888c5a832591445b455f13b0e",
"assets/assets/Takeo.png": "8affefab6dbc06c986f428205ff0629c",
"assets/assets/Tamaon.png": "047c988d38694c2b66d3107360030149",
"assets/assets/tamaozoo.png": "bebdc19856349342af29cb686f245efa",
"assets/assets/Taphrom.png": "74726d1058d2805479e9ace48103b46e",
"assets/assets/Tatai.png": "dee8c338192f6dfc66800e5db284a171",
"assets/assets/TboungKhmum.png": "0cf37ef5f44d78d20c522bdde523dc30",
"assets/assets/TekVil.png": "4a225e20eb8ad09f642015b41493b188",
"assets/assets/Terkcha.png": "67dc4a11d93377e426cd2b55147a5922",
"assets/assets/TerkChhou.png": "0aba3f77caab612b85b298faba78f910",
"assets/assets/thmorda.png": "cdfa9e97238384ae4a30efddded2d388",
"assets/assets/Tmorrung.png": "dde3c3a961430228777bad66c64d0a4b",
"assets/assets/ToulBaray.png": "180a5e417597bb4bc7f22395bb8acb8a",
"assets/assets/Toulsleng.png": "dd63938d3f019fe523b64bdc48888259",
"assets/assets/VealPouch.png": "e34cd35c9b0b719d1e134e8b5b82b7a6",
"assets/assets/VihearChan.png": "671c9370fff710b0f96366f6888e6d8b",
"assets/assets/vihearsour.png": "cd9446f1446ed51c28b21f38e1bb9b2c",
"assets/assets/virakchey.png": "e84262a87d0a239b89840f9be16b66e0",
"assets/assets/Wat.png": "2a935dbc14a9cf2894bbb12acd5c1969",
"assets/assets/Watbanan.png": "058935e681b20329e5d97fb106a0c61a",
"assets/assets/WatphnomToch.png": "ec093a34072f4fc384d1411bf2bbb133",
"assets/assets/Watroka.png": "4400249da12a5c5e512567711d4be8f7",
"assets/assets/wongkut.png": "6394d27380caa2a95ebba79607d96be1",
"assets/assets/Yeaklaom.png": "9beed2c272e30c4a0e3924360ad1ea23",
"assets/FontManifest.json": "92e8a1b3d98748d06c97267ef913b004",
"assets/fonts/MaterialIcons-Regular.otf": "9aa32af992a2e4a8f3f8f7d17338e46a",
"assets/fonts/PlayfairDisplay-Bold.ttf": "f083d3d233c60977fde5d857afec24e8",
"assets/fonts/PlayfairDisplay-BoldItalic.ttf": "7e481ff3b185f4e1fc76932a914c6359",
"assets/NOTICES": "020b79a1ff20eca519684af3a544ade1",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "3b56bd02500b92ef732875df62c93b84",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "0afc733090036798cde58cbe881440dd",
"/": "0afc733090036798cde58cbe881440dd",
"main.dart.js": "3a9228b927559d0f47a2c612a071e18c",
"manifest.json": "3549873e328632aa3fe08b121ea22ebb",
"version.json": "a134f2a5d5d871d72d5fd0adcc15e14c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
