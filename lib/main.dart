import 'dart:async';

import 'package:another_telephony/telephony.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sms_app/database_service.dart';
import 'package:sms_app/notifications.dart';
import 'package:sms_app/theme/color_schemas.g.dart';
import 'package:vibration/vibration.dart';
import 'package:workmanager/workmanager.dart';

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
        .showNotificationMessage('Background service has started');

    Telephony.backgroundInstance.listenIncomingSms(
      listenInBackground: true,
      onNewMessage: (message) async {
        /// Uygulama açıkken (foreground state) algılama, burasıyla işimiz yok.
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

  await DatabaseService.ensureInitialized();

  runApp(SmsApp());

  await Telephony.backgroundInstance.requestSmsPermissions;

  await NotificationManager.requestPermission();

  Workmanager().initialize(backgroundProcess, isInDebugMode: kDebugMode);
}

class SmsApp extends StatelessWidget {
  SmsApp({super.key});

  final GlobalKey<ScaffoldMessengerState> messenger =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: messenger,
      theme: ThemeData.light().copyWith(
        colorScheme: lightColorScheme,
      ),
      home: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        appBar: AppBar(
          title: Text('SMS App', style: Theme.of(context).textTheme.titleLarge),
        ),
        body: SafeArea(
          child: Center(
            child: Card(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('Background Control',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    SizedBox(height: 5),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('You can control background process'),
                    ),
                    SizedBox(height: 10),
                    Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(),
                          ),
                          child: ListView(
                            children: DatabaseService
                                    .instance.filter!.values.isNotEmpty
                                ? DatabaseService.instance.filter!.values
                                    .map((e) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(e.name),
                                            Text(e.filter),
                                          ],
                                        ))
                                    .toList()
                                : [
                                    Center(
                                        child: Text(
                                            'There is nothing to see here.'))
                                  ],
                          ),
                        )),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                              icon: Icon(Ionicons.play_outline),
                              onPressed: () async {
                                await Workmanager().cancelAll();
                                await Workmanager().registerPeriodicTask(
                                  'listenBackground',
                                  'listenBackground',
                                  frequency: Duration(minutes: 15),
                                  existingWorkPolicy:
                                      ExistingWorkPolicy.replace,
                                );
                                messenger.currentState?.showSnackBar(SnackBar(
                                  content:
                                      Text('Service has successfully started.'),
                                ));
                              },
                              label: Text('Start')),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: Icon(Ionicons.stop_outline),
                            onPressed: () async {
                              await Workmanager().cancelAll();
                              await NotificationManager.instance
                                  .showNotificationMessage(
                                      'Background service has stopped');
                              messenger.currentState?.showSnackBar(SnackBar(
                                content:
                                    Text('Service has successfully stopped.'),
                              ));
                            },
                            label: Text('Stop'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Ionicons.stopwatch_outline),
                        hintText: 'Periodic time in minutes',
                        labelText: 'Periodic time in minutes',
                      ),
                      initialValue: DatabaseService.instance.settings!
                          .get('time', defaultValue: '15'),
                      onFieldSubmitted: (value) {
                        int minute = int.parse(value);
                        if (minute < 15) minute = 15;
                        if (minute > 1440) minute = 1440;
                        DatabaseService.instance.settings!
                            .put('time', '$minute');
                      },
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
