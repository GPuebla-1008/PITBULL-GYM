import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class NotificationService {
  static Timer? _waterReminderTimer;

  static Future<bool> requestPermission() async {
    final permission = await html.Notification.requestPermission();
    return permission == 'granted';
  }

  static bool get isGranted {
    return html.Notification.permission == 'granted';
  }

  static void showNotification(String title, String body) {
    if (html.Notification.permission == 'granted') {
      html.Notification(title, body: body, icon: 'assets/images/logo.png');
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
