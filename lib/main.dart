import 'package:adv_eeg/Helper.dart';
import 'package:adv_eeg/screens/landing.dart';
import 'package:adv_eeg/screens/patient_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

Future myBackgroundMessageHandler(RemoteMessage message) async {
  if (message.notification != null) {
    print('Handling a background message ${message.notification}');
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotifications =
    FlutterLocalNotificationsPlugin();
Future main() async {
  await GetStorage.init();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (GetPlatform.isMobile) {
      print('here');
      final RemoteMessage? remoteMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      await HelperNotification.initialize(flutterLocalNotifications);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  } catch (er) {
    print(er);
  }
  runApp(const MyApp());

  print(DateTime.fromMillisecondsSinceEpoch(GetStorage().read('timestamp'))
      .difference(DateTime.now())
      .inDays
      .abs());
  GetStorage().read('loginDetails')['role'] == 'USER'
      ? Get.off(() => PatientLogin())
      : Get.off(() => LandingPage());
  if ((DateTime.fromMillisecondsSinceEpoch(GetStorage().read('timestamp'))
          .difference(DateTime.now())
          .inDays
          .abs()) >=
      3) {
    GetStorage().erase();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // routes: ,
      home: MaterialApp(
        title: 'ADV_EEG',
        theme: ThemeData(
            useMaterial3: true,
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.poppinsTextTheme()),
        // darkTheme: ThemeData(primarySwatch: Colors.primaries.first.shade200.blue),
        home: LandingPage(),
      ),
    );
  }
}
