import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';
import 'Notification.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  void showNotification() async {
    print('ndskdn');
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "notifications-youtube",
        "YouTube Notifications",
        priority: Priority.max,
        importance: Importance.max
    );

    DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notiDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails
    );

    DateTime scheduleDate = DateTime.now().add(Duration(seconds: 5));

    await notificationsPlugin.zonedSchedule(
        0,
        "Sample Notification",
        "This is a notification",
        tz.TZDateTime.from(scheduleDate, tz.local),
        notiDetails,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
        payload: "notification-payload"
    );
  }

  void checkForNotification() async {
    initializeTimeZones();

    AndroidInitializationSettings androidSettings = AndroidInitializationSettings("@mipmap/ic_launcher");

    DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestCriticalPermission: true,
        requestSoundPermission: true
    );

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings
    );

    bool? initialized = await notificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (response) {
          log(response.payload.toString());
        }
    );

    log("Notifications: $initialized");
    NotificationAppLaunchDetails? details = await notificationsPlugin.getNotificationAppLaunchDetails();

    if(details != null) {
      if(details.didNotificationLaunchApp) {
        NotificationResponse? response = details.notificationResponse;

        if(response != null) {
          String? payload = response.payload;
          log("Notification Payload: $payload");
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();

    checkForNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          debugPrint('Notification Scheduled for ${DateTime.now().add(Duration(seconds: 5))}');
          NotificationService().scheduleNotification(
              title: 'Scheduled Notification',
              body: '$DateTime.now().add(Duration(seconds: 5));',
              scheduledNotificationDateTime: DateTime.now().add(Duration(seconds: 5)));
        },
        child: Icon(Icons.notification_add),
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}