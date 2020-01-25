/* Simple cache web service worker for PWAs */
let cacheName = 'WeatherClient-cache';

self.addEventListener('install', function(event) {
  event.waitUntil(
    caches.open(cacheName).then(function(cache) {
      // Use self.registration.scope to find the base URL instead
      return cache.addAll(
        [ /* All resources that are fit to store */
          '/index.html',
          '/sw.js',
          '/manifest.json',
          '/js/localforage.min-1.7.3.js',
          '/js/handlebars-v4.1.2.js',
          '/js/morphdom-2.5.4.js',
          '/css/bootstrap-3.4.1.min.css',
          '/app.css'
          // '/offline.html'
        ]
      );
    })
  );
});

/* Serve everything from the cache */
/*
self.addEventListener('fetch', function(event) {
  event.respondWith(caches.match(event.request));
});
*/

self.addEventListener('fetch', function(event) {
  event.respondWith(
    // Try the cache
    caches.match(event.request).then(function(response) {
      // Fall back to network
      if( response )
        return response;
      console.log("Returnng network request via fetch()");
      return fetch(event.request);

      // Fetch data online, cache locally
      /*
      caches.open(cacheName).then(function(cache) {
          return fetch(event.request).then(function(response) {
            cache.put(event.request, response.clone());
            return response;
          });
      })
      */

      // Inform the client that they should update their stuff
      /*
           client.postMessage({
             msg: "Hey I just got a fetch from you!",
             url: event.request.url
           });
      */

    }).catch(function() {
      // If both fail, show a generic fallback:
      return caches.match('/offline.html');
      // However, in reality you'd have many different
      // fallbacks, depending on URL & headers.
      // Eg, a fallback silhouette image for avatars.
    })
  );
});

/* Evict outdated stuff resp. update our new cache */
self.addEventListener('activate', function(event) {
  event.waitUntil(
    caches.keys().then(function(cacheNames) {
      return Promise.all(
        cacheNames.filter(function(cacheName) {
          // Return true if you want to remove this cache,
          // but remember that caches are shared across
          // the whole origin
        }).map(function(cacheName) {
          return caches.delete(cacheName);
        })
      );
    })
  );
});
