import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  static const String vapidKey =
      'BG1jDPF7f-zHUnntBAwmyPxZj9Z_QLmfv27rgRwoGJ_l79XhPnP3uK-jQb1LYd6HUaji24XdXeiL2ML0rZC2_go';
  static const String senderId = '438607140066';

  static Timer? _waterReminderTimer;
  static String? _cachedFcmToken;
  static bool _initialized = false;
  static Function(RemoteMessage)? _onMessageCallback;

  static String? get currentToken => _cachedFcmToken;

  static bool get isSupported {
    try {
      return html.Notification.supported;
    } catch (_) {
      return false;
    }
  }

  static bool get isGranted {
    try {
      if (!isSupported) return false;
      return html.Notification.permission == 'granted';
    } catch (e) {
      return false;
    }
  }

  /// Inicializa listeners de FCM (foreground, background clicks & token refresh)
  static Future<void> initialize({Function(RemoteMessage)? onMessageReceived}) async {
    if (_initialized) return;
    _initialized = true;
    _onMessageCallback = onMessageReceived;

    try {
      // Escuchar notificaciones cuando la app está abierta en primer plano
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('[FCM] Mensaje recibido en primer plano: ${message.messageId}');
        final title = message.notification?.title ?? message.data['title'] ?? 'PITBULL GYM';
        final body = message.notification?.body ?? message.data['body'] ?? '';

        showNotification(title, body);
        _onMessageCallback?.call(message);
      });

      // Escuchar cuando el usuario hace clic en una notificación y abre la app
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint('[FCM] App abierta desde notificación: ${message.messageId}');
        _onMessageCallback?.call(message);
      });

      // Escuchar renovación periódica de tokens
      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
        debugPrint('[FCM] Token renovado: $newToken');
        _cachedFcmToken = newToken;
        saveTokenToFirestore(newToken);
      });

      // Si ya tiene permiso concedido previamente, obtener y registrar token en silencio
      if (isGranted) {
        await getFcmToken();
      }
    } catch (e) {
      debugPrint('[FCM] Error inicializando FirebaseMessaging: $e');
    }
  }

  /// Solicita permisos tanto a nivel navegador como FirebaseMessaging
  static Future<bool> requestPermission() async {
    try {
      if (!isSupported) {
        debugPrint('Notifications not supported in this browser.');
        return false;
      }

      // 1. Permiso en el navegador
      final browserPermission = await html.Notification.requestPermission();
      final granted = browserPermission == 'granted';
      if (!granted) return false;

      // 2. Permiso en Firebase Messaging
      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      final fcmGranted = settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional;

      if (fcmGranted || granted) {
        await getFcmToken();
        return true;
      }

      return false;
    } catch (e) {
      debugPrint('Error solicitando permisos de notificación: $e');
      return false;
    }
  }

  /// Obtiene el token FCM utilizando la VAPID key
  static Future<String?> getFcmToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken(
        vapidKey: vapidKey,
      );
      if (token != null) {
        _cachedFcmToken = token;
        debugPrint('[FCM] Token obtenido con éxito: $token');
        await saveTokenToFirestore(token);
      }
      return token;
    } catch (e) {
      debugPrint('[FCM] Error obteniendo FCM Token: $e');
      return null;
    }
  }

  /// Registra el token en Firestore tanto en la colección global `fcm_tokens` como en el usuario
  static Future<void> saveTokenToFirestore(String token, [String? uid]) async {
    try {
      final db = FirebaseFirestore.instance;

      // 1. Guardar en colección central de tokens para envíos masivos desde consola/backend
      await db.collection('fcm_tokens').doc(token).set({
        'token': token,
        'uid': uid ?? '',
        'platform': 'web',
        'updatedAt': FieldValue.serverTimestamp(),
        'active': true,
      }, SetOptions(merge: true));

      // 2. Si hay un usuario asociado, guardar en su perfil
      if (uid != null && uid.isNotEmpty) {
        await db.collection('usuarios').doc(uid).set({
          'fcmToken': token,
          'fcmTokenUpdatedAt': FieldValue.serverTimestamp(),
          'notificationsEnabled': true,
        }, SetOptions(merge: true));
      }
    } catch (e) {
      debugPrint('[FCM] Error guardando token en Firestore: $e');
    }
  }

  /// Solicita permisos y asocia el token directamente a un UID de usuario
  static Future<bool> requestPermissionAndRegister([String? uid]) async {
    final granted = await requestPermission();
    if (granted) {
      final token = await getFcmToken();
      if (token != null && uid != null) {
        await saveTokenToFirestore(token, uid);
      }
      return true;
    }
    return false;
  }

  /// Sincroniza el token actual con un usuario logueado
  static Future<void> syncUser(String uid) async {
    try {
      if (_cachedFcmToken != null) {
        await saveTokenToFirestore(_cachedFcmToken!, uid);
      } else if (isGranted) {
        final token = await getFcmToken();
        if (token != null) {
          await saveTokenToFirestore(token, uid);
        }
      }
    } catch (e) {
      debugPrint('[FCM] Error sincronizando usuario: $e');
    }
  }

  /// Muestra una notificación local en el navegador
  static void showNotification(String title, String body) {
    try {
      if (isGranted) {
        html.window.navigator.serviceWorker?.ready.then((registration) {
          registration.showNotification(title, {
            'body': body,
            'icon': 'icons/Icon-192.png',
            'badge': 'icons/Icon-192.png',
          });
        }).catchError((_) {
          html.Notification(title, body: body, icon: 'icons/Icon-192.png');
        });
      }
    } catch (e) {
      debugPrint('Error mostrando notificación: $e');
    }
  }

  /// Recordatorio periódico de hidratación
  static void scheduleWaterReminder(Duration delay) {
    _waterReminderTimer?.cancel();
    _waterReminderTimer = Timer(delay, () {
      showNotification(
        '¡Hora de hidratarse!',
        'El Pitbull te recuerda que es hora de tomar tu próximo vaso de agua. 💪💧',
      );
    });
  }

  static void cancelReminders() {
    _waterReminderTimer?.cancel();
  }
}
