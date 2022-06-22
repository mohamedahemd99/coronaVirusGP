import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AppNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //intialize local notification
  static final onSelectNotify = BehaviorSubject<String?>();

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);
    tz.initializeTimeZones();
    //App is closed
    NotificationAppLaunchDetails? details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onSelectNotify.add(details.payload);
    }
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) => onSelectNotify.add(payload));
  }

  static Future showNotificationDetails() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: IOSNotificationDetails());
    return platformChannelSpecifics;
  }

  static Future<void> showNotificationWithNoBody(
      {int id = 0, String? title, body, payload}) async {
    await flutterLocalNotificationsPlugin.show(
        id, title, body, await showNotificationDetails(),
        payload: payload ?? 'item x');
  }

  static Future<void> showFullScreenNotification(BuildContext context) async {
    print(tz.local);
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Turn off your screen'),
        content: const Text(
            'to see the full-screen intent in 5 seconds, press OK and TURN '
            'OFF your screen'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              var scheduledNotificationDateTime = new DateTime.now();
              final zone = tz.getLocation('Africa/Cairo');

              print(
                  tz.TZDateTime.from(scheduledNotificationDateTime, tz.local));
              //  tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5))
              var time = tz.TZDateTime.from(
                scheduledNotificationDateTime,
                tz.local,
              );
              await flutterLocalNotificationsPlugin.zonedSchedule(
                  0,
                  'scheduled title',
                  'scheduled body',
                  tz.TZDateTime.now(zone).add(const Duration(seconds: 10)),
                  const NotificationDetails(
                      android: AndroidNotificationDetails(
                          'full screen channel id', 'full screen channel name',
                          channelDescription: 'full screen channel description',
                          priority: Priority.high,
                          importance: Importance.high,
                          playSound: true,
                          progress: 40,
                          fullScreenIntent: true)),
                  payload: "hello",
                  androidAllowWhileIdle: true,
                  uiLocalNotificationDateInterpretation:
                      UILocalNotificationDateInterpretation.absoluteTime);

              Navigator.pop(context);
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  static Future<void> zonedScheduleNotification({
    int id = 0,
    String? title,
    body,
    payload,
    DateTime? dateTime,
  }) async {
    var now = DateTime.now();
    Duration duration = dateTime!.difference(now);
    final zone = tz.getLocation('Africa/Cairo');

    await flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
        tz.TZDateTime.now(zone).add(duration), await showNotificationDetails(),
        androidAllowWhileIdle: true,
        payload: payload,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
