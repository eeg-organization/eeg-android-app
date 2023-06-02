import 'dart:convert';
import 'dart:io';

import 'package:adv_eeg/screens/adminSide.dart';
import 'package:adv_eeg/screens/doctorView.dart';
import 'package:adv_eeg/screens/relativeSide.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../Constants/constants.dart';
import '../models/loginModel.dart';
import '../screens/patient_login.dart';

class LoginController extends GetxController {
  var loginDetails = Login().obs;
  var isLoading = false.obs;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  GetStorage box = GetStorage();
  getNotification() async {
    var token = ''.obs;
    await FirebaseMessaging.instance
        .getToken()
        .then((value) => token.value = value!);
    try {
      var response = await http.post(Uri.parse('${Constants.apiUrl}/devices/'),
          headers: Constants.header,
          body: jsonEncode({
            'registration_id': token.value,
            "type": Platform.isAndroid ? 'android' : 'ios'
          }));
      print(response.body);
      print(response.statusCode);
    } catch (er) {
      print(er);
    }
  }

  login() async {
    isLoading.value = true;
    if (!GetPlatform.isWeb) await getNotification();
    final url = '${Constants.apiUrl}/login/';
    try {
      var token = ''.obs;
      if (!GetPlatform.isWeb) {
        await FirebaseMessaging.instance
            .getToken()
            .then((value) => token.value = value!);
      }
      var response = await http.post(
        Uri.parse(url),
        headers: Constants.header,
        body: jsonEncode(
          {
            "username": username.text,
            "password": password.text,
            "registration_id": token.value,
          },
        ),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        loginDetails.value = loginFromJson(response.body);
        print(response.body);
        await box.write("loginDetails", jsonDecode(response.body));
        await box.write("timestamp", DateTime.now().millisecondsSinceEpoch);
        // isLoading.value = false;
        loginDetails.value.user!.role == 'USER'
            ? Get.offAll(() => PatientLogin())
            : loginDetails.value.user!.role == 'DOCTOR'
                ? Get.offAll(() => DoctorView())
                : loginDetails.value.user!.role == 'RELATIVE'
                    ? Get.off(() => RelativeSide())
                    : loginDetails.value.user!.role == 'ADMIN'
                        ? Get.off(() => AdminMain())
                        : printError();
      } else {
        Get.snackbar('Error', jsonDecode(response.body)['message']);
      }
      return response.statusCode;
    } catch (err) {
      print(err);
    } finally {
      isLoading.value = false;
    }
  }
}
