import 'dart:io';

import 'package:adv_eeg/Helper.dart';
import 'package:adv_eeg/screens/adminSide.dart';
import 'package:adv_eeg/screens/doctorView.dart';
import 'package:adv_eeg/screens/landing.dart';
import 'package:adv_eeg/screens/patient_login.dart';
import 'package:adv_eeg/screens/relativeSide.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_options.dart';

Future myBackgroundMessageHandler(RemoteMessage message) async {
  if (message.notification != null) {
    print('Handling a background message ${message.notification}');
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotifications =
    FlutterLocalNotificationsPlugin();
var role;
Future main() async {
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  if (!GetPlatform.isWeb) {
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
    try {
      if (GetPlatform.isMobile) {
        await FirebaseMessaging.instance.getInitialMessage();
        await HelperNotification.initialize(flutterLocalNotifications);
        FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
      }
    } catch (er) {
      print(er);
    }
  }
  if (await GetStorage().read('timestamp') != null &&
      (DateTime.fromMillisecondsSinceEpoch(GetStorage().read('timestamp'))
              .difference(DateTime.now())
              .inDays
              .abs()) >=
          3) {
    GetStorage().erase();
  }
  role = await GetStorage().read('loginDetails') != null
      ? await GetStorage().read('loginDetails')['user']['role']
      : null;
  // print(object)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final testId = Get.put(TestId());
    return GetMaterialApp(
      // routes: ,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          useMaterial3: true,
          // primarySwatch: Colors.blue,
          textTheme: GoogleFonts.poppinsTextTheme()),
      // darkTheme: ThemeData(primarySwatch: Colors.primaries.first.shade200.blue),
      home: role == null
          ? LandingPage()
          : role == 'USER'
              ? PatientLogin()
              : role == 'DOCTOR'
                  ? DoctorView()
                  : role == 'RELATIVE'
                      ? RelativeSide()
                      : AdminMain(),
    );
  }
}
