import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readsms/readsms.dart';
import 'package:telephony/telephony.dart';

const int processID = 0;
const int closeLevel = 10;

@pragma('vm:entry-point')
void handleMessage(SMS sms) {
  if (sms.sender == '+905550035244') return; // prevent self-loop

  print(sms);

  Telephony.backgroundInstance.sendSms(to: sms.sender, message: sms.body);
}

@pragma('vm:entry-point')
void backgroundProcess() async {
  print('Background Process is on');

  // Start listening
  final reader = Readsms();
  reader.smsStream.listen(handleMessage);
  reader.read();

  // Stop program if battery lower than ten percent.
  final battery = Battery();
  battery.batteryLevel.asStream().listen((level) => switch (level) {
        <= closeLevel => {
            print('Low battery detected, exiting.'),
            reader.dispose(),
            AndroidAlarmManager.cancel(processID),
            ServicesBinding.instance.exitApplication(AppExitType.required),
            exit(0),
          },
        _ => null,
      });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();

  runApp(const MainApp());

  await Telephony.instance.requestSmsPermissions;

  await AndroidAlarmManager.oneShot(
    Duration.zero,
    0,
    backgroundProcess,
    allowWhileIdle: true,
    rescheduleOnReboot: true,
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
