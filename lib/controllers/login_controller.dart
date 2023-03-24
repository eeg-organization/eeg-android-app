import 'dart:convert';

import 'package:adv_eeg/screens/adminSide.dart';
import 'package:adv_eeg/screens/doctorView.dart';
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
    try{
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
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      loginDetails.value = loginFromJson(response.body);
      print(response.body);
      await box.write("loginDetails", jsonDecode(response.body));
      await box.write("timestamp", DateTime.now().millisecondsSinceEpoch);
      // isLoading.value = false;
      loginDetails.value.role == 'USER'
          ? Get.offAll(() => PatientLogin())
          : loginDetails.value.role == 'DOCTOR'
              ? Get.offAll(() => DoctorView())
              : loginDetails.value.role == 'ADMIN'
                  ? Get.off(() => AdminMain())
                  : printError();
    }
    return response.statusCode;}
    catch(err){
      print(err);
    }finally{
      isLoading.value = false;
    }
  }
}
