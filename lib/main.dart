import 'dart:async';

import 'package:another_telephony/telephony.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sms_app/feature/home/home_view.dart';
import 'package:sms_app/product/model/filter_model.dart';
import 'package:sms_app/product/service/database_service.dart';
import 'package:sms_app/product/service/notification_service.dart';
import 'package:sms_app/product/theme/color_schemas.g.dart';
import 'package:workmanager/workmanager.dart';

const String gib = 'EARSIV FATURA(INTERAKTIF) ONAYI ICIN SMS SIFRENIZ:';
const String sb = 'Saglik Bakanligi ortak giris noktasi iki adimli ki';
const String ahmet = '+905056579275';
const String cihan = '+905054884195';
const String recep = '+905545676580';
const String ummuhan = '+905532954020';
const String gulnur = '+905326754890';
const String emre = '+905550035244';
const String esra = '+905054884196';

@pragma(('vm:entry-point'))
Future<void> handleBackgroundTelephonyMessage(SmsMessage message) async {
  await NotificationManager.instance
      .showNotificationMessage('${message.address} \n ${message.body}');

  await DatabaseService.initialize([FilterModelSchema]);

  final filters = await DatabaseService.instance.getAll();

  for (final filter in filters) {
    if (message.body!.contains(RegExp(filter.filter, caseSensitive: false))) {
      await Telephony.backgroundInstance
          .sendSms(to: '+905550035244', message: 'DÖNÜT');
    }
  }

  await DatabaseService.instance.service?.close();
}

@pragma('vm:entry-point')
Future<void> backgroundProcess() async {
  Workmanager().executeTask((taskName, inputData) async {
    final bool state = inputData!['state'];
    debugPrint('state: $state');
    await NotificationManager.instance.showNotificationMessage(
        'SMS uygulaması ${state ? 'başladı' : 'durdu'}!');

    Telephony.backgroundInstance.listenIncomingSms(
      listenInBackground: true,
      onNewMessage: handleBackgroundTelephonyMessage,
      onBackgroundMessage: handleBackgroundTelephonyMessage,
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

  await Telephony.backgroundInstance.requestPhoneAndSmsPermissions;

  await NotificationManager.requestPermission();
}

class SmsApp extends StatelessWidget {
  SmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        colorScheme: lightColorScheme,
      ),
      home: HomeView(),
    );
  }
}
