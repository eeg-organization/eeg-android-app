import 'dart:convert';

import 'package:adv_egg/Constants/constants.dart';
import 'package:adv_egg/models/loginModel.dart';
import 'package:adv_egg/screens/patient_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  var loginDetails = Login().obs;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  GetStorage box = GetStorage();
  login() async {
    final url = '${Constants.apiUrl}/login/';
    var response = await http.post(
      Uri.parse(url),
      headers: Constants.header,
      body: jsonEncode(
        {
          "username": username.text,
          "password": password.text,
        },
      ),
    );
    if (response.statusCode == 200) {
      loginDetails.value = loginFromJson(response.body);
      await box.write("loginDetails", jsonDecode(response.body));
      await box.write("timestamp", DateTime.now().millisecondsSinceEpoch);
      Get.offAll(() => const PatientLogin());
    }
  }
}
