import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
void notificationBackgroundHandler(NotificationResponse response) async {
  inspect(response);
  switch (response.actionId) {
    case 'end_session':
      await Future.delayed(Duration(seconds: 3));
      NotificationManager.instance.plugin.cancelAll();
      Isolate.current.kill();
      exit(0);
    default:
      return;
  }
}

void notificationForegroundHandler(NotificationResponse response) async {
  inspect(response);
}

@pragma('vm:entry-point')
class NotificationManager {
  NotificationManager._private();

  static final NotificationManager _instance = NotificationManager._private();
  static NotificationManager get instance => _instance;

  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    await instance.plugin.initialize(
      InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher')),
      onDidReceiveBackgroundNotificationResponse: notificationBackgroundHandler,
      onDidReceiveNotificationResponse: notificationForegroundHandler,
    );
  }

  Future<void> showNotificationMessage(String message, {int? id}) async {
    await plugin.show(
      id ?? 1,
      'SMS App',
      message,
      NotificationDetails(
        android: AndroidNotificationDetails('1', 'App notifications',
            channelDescription: 'Background service related notifications'),
      ),
    );
  }

  static Future<void> requestPermission() async {
    instance.plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }
}
