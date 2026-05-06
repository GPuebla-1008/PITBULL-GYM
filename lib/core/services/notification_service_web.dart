import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class NotificationService {
  static Timer? _waterReminderTimer;

  static bool get isSupported => html.Notification.supported;

  static Future<bool> requestPermission() async {
    try {
      if (!isSupported) {
        print('Notifications not supported in this browser.');
        return false;
      }
      
      // Alguns browsers requieren una interacción del usuario, que ya tenemos.
      final permission = await html.Notification.requestPermission();
      print('Notification permission: $permission');
      return permission == 'granted';
    } catch (e) {
      print('Error requesting notification permission: $e');
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

  static void showNotification(String title, String body) {
    try {
      if (isGranted) {
        // Intentar usar el Service Worker para mayor compatibilidad en PWA
        html.window.navigator.serviceWorker?.ready.then((registration) {
          registration.showNotification(title, {
            'body': body,
            'icon': 'assets/images/logo.png',
            'badge': 'icons/Icon-192.png',
          });
        }).catchError((_) {
          // Fallback al constructor tradicional si el SW falla
          html.Notification(title, body: body, icon: 'assets/images/logo.png');
        });
      }
    } catch (e) {
      print('Error showing notification: $e');
    }
  }

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
