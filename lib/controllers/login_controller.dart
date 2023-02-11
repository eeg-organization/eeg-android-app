import 'dart:convert';

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
  login() async {
    isLoading.value = true;
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
      isLoading.value = false;
      Get.offAll(() => const PatientLogin());
    }
    return response.statusCode;
  }
}
