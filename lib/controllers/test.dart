import 'dart:convert';

import 'package:adv_eeg/Constants/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TestId extends GetxController {
  onInit() async {
    await getNotification();
    super.onInit();
  }

  getNotification() async {
    var token = ''.obs;
    await FirebaseMessaging.instance
        .getToken()
        .then((value) => token.value = value!);
    try {
      var response = await http.post(Uri.parse('${Constants.apiUrl}/devices/'),
          headers: Constants.header,
          body:
              jsonEncode({'registration_id': token.value, "type": "android"}));
      print(response.body);
      print(response.statusCode);
    } catch (er) {
      print(er);
    }
  }
}
