import 'dart:async';

import 'package:another_telephony/telephony.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sms_app/notifications.dart';
import 'package:vibration/vibration.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
final Stopwatch stopwatch = Stopwatch()..start();

@pragma(('vm:entry-point'))
Future<void> handleBackgroundTelephonyMessage(SmsMessage message) async {
  await NotificationManager.instance
      .showNotificationMessage('handleBackgroundTelephonyMessage!');
  Vibration.vibrate(duration: 1000);
}

@pragma('vm:entry-point')
Future<void> backgroundProcess() async {
  Workmanager().executeTask((taskName, inputData) async {
    await NotificationManager.instance
        .showNotificationMessage('backgroudProcess is on');
    await NotificationManager.instance
        .showNotificationMessage('Elapsed time ${stopwatch.elapsed.inMinutes}');

    Telephony.backgroundInstance.listenIncomingSms(
      listenInBackground: true,
      onNewMessage: (message) async {
        await NotificationManager.instance
            .showNotificationMessage('handleTelephonyMessage!');
        Vibration.vibrate(duration: 1000);
      },
      onBackgroundMessage: handleBackgroundTelephonyMessage,
    );

    return true;
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationManager.initialize();

  runApp(SmsApp());

  await Telephony.backgroundInstance.requestSmsPermissions;

  await NotificationManager.requestPermission();

  Workmanager().initialize(backgroundProcess, isInDebugMode: kDebugMode);
  Workmanager().registerPeriodicTask(
    'listenBackground',
    'listenBackground',
    frequency: Duration(minutes: 15),
    existingWorkPolicy: ExistingWorkPolicy.replace,
  );
}

class SmsApp extends StatelessWidget {
  const SmsApp({super.key});

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
