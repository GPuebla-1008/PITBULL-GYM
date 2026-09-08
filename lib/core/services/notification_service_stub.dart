import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static const String vapidKey =
      'BG1jDPF7f-zHUnntBAwmyPxZj9Z_QLmfv27rgRwoGJ_l79XhPnP3uK-jQb1LYd6HUaji24XdXeiL2ML0rZC2_go';
  static const String senderId = '438607140066';

  static String? get currentToken => null;
  static bool get isSupported => false;
  static bool get isGranted => false;

  static Future<void> initialize({Function(RemoteMessage)? onMessageReceived}) async {}
  static Future<bool> requestPermission() async => false;
  static Future<String?> getFcmToken() async => null;
  static Future<void> saveTokenToFirestore(String token, [String? uid]) async {}
  static Future<bool> requestPermissionAndRegister([String? uid]) async => false;
  static Future<void> syncUser(String uid) async {}
  static void showNotification(String title, String body) {}
  static void scheduleWaterReminder(Duration delay) {}
  static void cancelReminders() {}
}
