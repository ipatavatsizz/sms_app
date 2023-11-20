import 'dart:async';
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:readsms/readsms.dart';
import 'package:sms_app/notifications.dart';
import 'package:telephony/telephony.dart';

@pragma('vm:entry-point')
Future<void> handleMessage(SMS sms) async {
  DartPluginRegistrant.ensureInitialized();

  if (sms.sender == '+905550035244') return;

  await Telephony.backgroundInstance.sendSms(
    to: sms.sender,
    message: sms.body,
  );
}

@pragma('vm:entry-point')
Future<void> backgroundProcess() async {
  DartPluginRegistrant.ensureInitialized();

  await NotificationManager.initialize();

  await NotificationManager.instance
      .showNotificationMessage('Working on background');

  // Start listening
  final reader = Readsms();
  reader.smsStream.listen(handleMessage);
  reader.read();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationManager.initialize();

  await AndroidAlarmManager.initialize();

  runApp(MainApp());

  await NotificationManager.requestPermission();
  await Telephony.instance.requestSmsPermissions;

  await AndroidAlarmManager.periodic(
    Duration(seconds: 30),
    0,
    backgroundProcess,
    allowWhileIdle: true,
    rescheduleOnReboot: true,
    exact: true,
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
