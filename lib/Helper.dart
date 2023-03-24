import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HelperNotification {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotifications) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('vector_6');
    // const iOSInitialize = const
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotifications.initialize(initializationSettings,
        onSelectNotification: (String? payload) {
      try {
        if (payload != null && payload.isNotEmpty) {
          print('notification payload: $payload');
        } else {}
      } catch (err) {
        print(err);
      }
      return;
    });
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('message');
      print(
          "onMessage : ${message.notification!.title} ${message.notification!.body} ${message.notification!.titleLocKey}");
      HelperNotification.showNotification(flutterLocalNotifications, message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('message');
      print("onMessage : ${message.notification!.title}");
    });
  }

  static void showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotifications,
      RemoteMessage message) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      message.notification!.body.toString(),
      htmlFormatBigText: true,
      contentTitle: message.notification!.title,
      htmlFormatContentTitle: true,
      summaryText: message.notification!.title,
      htmlFormatSummaryText: true,
    );
    AndroidNotificationDetails androidNotificationChannel =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      playSound: true,
      enableLights: true,
      enableVibration: true,
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidNotificationChannel);
    await flutterLocalNotifications.show(
      0,
      message.notification!.title,
      message.notification!.body,
      platformChannelSpecifics,
      payload: message.data.toString(),
    );
  }
}
