import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

enum AppState { initial, listening, closing }

@pragma('vm:entry-point')
void notificationBackgroundHandler(NotificationResponse response) async {
  inspect(response);
  switch (response.actionId) {
    case 'end_session':
      NotificationManager.instance.showNotificationState(AppState.closing);
      await Future.delayed(Duration(seconds: 3));
      Isolate.current.kill();
      exit(0);
    default:
      return;
  }
  // TODO(ipatavatsizz): Handle actions
}

void notificationForegroundHandler(NotificationResponse response) async {
  inspect(response);
  // TODO(ipatavatsizz): Handle actions
}

@pragma('vm:entry-point')
class NotificationManager {
  NotificationManager._private();

  static final NotificationManager _instance = NotificationManager._private();
  static NotificationManager get instance => _instance;
  static bool _initialized = false;

  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    await instance.plugin.initialize(
      InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher')),
      onDidReceiveBackgroundNotificationResponse: notificationBackgroundHandler,
      onDidReceiveNotificationResponse: notificationForegroundHandler,
    );
  }

  Future<void> showNotificationMessage(String message) async {
    await plugin.cancelAll();

    await Future.delayed(Duration(seconds: 1));

    await plugin.show(
      1,
      'Message',
      message,
      NotificationDetails(
        android: AndroidNotificationDetails('1', 'App notifications'),
      ),
    );
  }

  Future<void> showNotificationState(AppState state) async {
    await plugin.cancelAll();

    await Future.delayed(Duration(seconds: 1));

    await plugin.show(
      0,
      'SMS App Notifications',
      'STATE: ${state.name.toUpperCase()}',
      NotificationDetails(
        android: AndroidNotificationDetails(
          '1',
          'App notifications',
          playSound: false,
          actions: [
            AndroidNotificationAction('end_session', 'End Session'),
          ],
          autoCancel: false,
          ongoing: true,
        ),
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
