// Service Worker para Firebase Cloud Messaging (FCM)
// PITBULL GYM - Gestión de Entrenamiento

importScripts("https://www.gstatic.com/firebasejs/10.12.2/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.12.2/firebase-messaging-compat.js");

// Inicialización con las credenciales del proyecto pitbull-gym-100889
firebase.initializeApp({
  apiKey: "AIzaSyBJ_Z_gIsNIIrXVBmsa1MoEpKGchAhIMCs",
  authDomain: "pitbull-gym-100889.firebaseapp.com",
  projectId: "pitbull-gym-100889",
  storageBucket: "pitbull-gym-100889.firebasestorage.app",
  messagingSenderId: "438607140066",
  appId: "1:438607140066:web:071a99d7c563ef30583abb"
});

const messaging = firebase.messaging();

// Manejador de notificaciones cuando la app está en segundo plano o cerrada
messaging.onBackgroundMessage((payload) => {
  console.log('[firebase-messaging-sw.js] Notificación recibida en background:', payload);

  const title = payload.notification?.title || payload.data?.title || 'PITBULL GYM';
  const options = {
    body: payload.notification?.body || payload.data?.body || 'Nueva notificación de Pitbull Gym',
    icon: '/icons/Icon-192.png',
    badge: '/icons/Icon-192.png',
    image: payload.notification?.image || payload.data?.image || undefined,
    data: payload.data || {},
    vibrate: [200, 100, 200],
    tag: payload.data?.tag || 'pitbull-notification'
  };

  return self.registration.showNotification(title, options);
});

// Evento al hacer click en la notificación
self.addEventListener('notificationclick', (event) => {
  event.notification.close();

  // Enfocar la ventana si ya está abierta, o abrir una nueva
  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true }).then((windowClients) => {
      for (let i = 0; i < windowClients.length; i++) {
        const client = windowClients[i];
        if (client.url.includes(self.location.origin) && 'focus' in client) {
          return client.focus();
        }
      }
      if (clients.openWindow) {
        return clients.openWindow('/');
      }
    })
  );
});
