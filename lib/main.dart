import 'dart:async';

import 'package:another_telephony/telephony.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sms_app/feature/home/home_view.dart';
import 'package:sms_app/product/core/application.dart';
import 'package:sms_app/product/model/filter_model.dart';
import 'package:sms_app/product/service/database_service.dart';
import 'package:sms_app/product/service/notification_service.dart';
import 'package:sms_app/product/theme/color_schemas.g.dart';
import 'package:vibration/vibration.dart';
import 'package:workmanager/workmanager.dart';

@pragma(('vm:entry-point'))
Future<void> handleBackgroundTelephonyMessage(SmsMessage message) async {
  try {
    await DatabaseService.initialize([FilterModelSchema]);

    final filters = await DatabaseService.instance.getAll();

    for (final filter in filters) {
      if (message.address == '+90${filter.phone}' &&
          message.body!.contains(filter.filter)) {
        await NotificationManager.instance.showNotificationMessage(
            'Got a filtered message man! #${message.address}');
        await Vibration.vibrate(duration: 1000);
      }
    }

    await DatabaseService.instance.service?.close();
  } catch (e) {
    await NotificationManager.instance
        .showNotificationMessage('Got an unexpected error :S', id: 3);
  }
}

@pragma('vm:entry-point')
Future<void> backgroundProcess() async {
  Workmanager().executeTask((taskName, inputData) async {
    final bool state = inputData!['state'];

    await NotificationManager.instance.showNotificationMessage(
        'Background service has ${state ? 'started' : 'stopped'}!');

    Telephony.backgroundInstance.listenIncomingSms(
      listenInBackground: state,
      onNewMessage: (message) {},
      onBackgroundMessage: state ? handleBackgroundTelephonyMessage : null,
    );

    return true;
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseService.initialize([FilterModelSchema]);

  await NotificationManager.initialize();

  await Workmanager().initialize(backgroundProcess, isInDebugMode: kDebugMode);

  runApp(SmsApp());

  await Telephony.backgroundInstance.requestSmsPermissions;

  await NotificationManager.requestPermission();
}

class SmsApp extends StatelessWidget {
  SmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Application.messenger,
      theme: ThemeData.light().copyWith(
        colorScheme: lightColorScheme,
      ),
      home: HomeView(),
    );
  }
}
