import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sms_app/feature/new_model/new_model.dart';
import 'package:sms_app/product/model/filter_model.dart';
import 'package:sms_app/product/service/database_service.dart';
import 'package:workmanager/workmanager.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<FilterModel> initialData = [];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.scheduleFrameCallback((_) async {
      initialData = await DatabaseService.instance.getAll();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SMS App', style: Theme.of(context).textTheme.titleLarge),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => NewModelView(
                      remove: false,
                    ))),
        child: Icon(Ionicons.add_outline),
      ),
      body: SafeArea(
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
              SizedBox(height: 20),
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: .5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: FutureBuilder(
                      initialData: initialData,
                      future: DatabaseService.instance.getAll(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.done:
                            final data = snapshot.data;
                            return RefreshIndicator(
                              onRefresh: () async => setState(() {}),
                              child: ListView(
                                children: (data != null && data.isNotEmpty)
                                    ? data
                                        .map((item) => ListTile(
                                              onTap: () => Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              NewModelView(
                                                                model: item,
                                                                remove: true,
                                                              ))),
                                              title: Text(item.phone),
                                              trailing: Text(item.filter),
                                              leadingAndTrailingTextStyle:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                            ))
                                        .toList()
                                    : [
                                        Center(
                                          child: Text('No filter added yet'),
                                        ),
                                      ],
                              ),
                            );
                          default:
                            return Center(child: CircularProgressIndicator());
                        }
                      }),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Ionicons.play_outline),
                      onPressed: () async {
                        await Workmanager().registerPeriodicTask(
                            'start_service', 'start',
                            inputData: {'state': true},
                            frequency: Duration(minutes: 15),
                            existingWorkPolicy: ExistingWorkPolicy.replace);
                      },
                      label: Text('Start'),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Ionicons.stop_outline),
                      onPressed: () async {
                        await Workmanager().registerOneOffTask(
                            'stop_service', 'stop',
                            inputData: {'state': false});
                        Future.delayed(Duration(seconds: 1),
                            () async => await Workmanager().cancelAll());
                      },
                      label: Text('Stop'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
