import 'dart:async';

class NotificationService {
  static Future<bool> requestPermission() async => false;
  static bool get isGranted => false;
  static void showNotification(String title, String body) {}
  static void scheduleWaterReminder(Duration delay) {}
  static void cancelReminders() {}
}
