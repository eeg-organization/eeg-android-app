import 'dart:convert';

import 'package:adv_eeg/models/allDoctorModel.dart';
import 'package:adv_eeg/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Constants/constants.dart';

class SignUpController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await fetchDoctor();
  }

  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController bloodGroup = TextEditingController();
  TextEditingController bloodPressure = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController doctor = TextEditingController();
  //create-user-usinapp
  var doctorList = AllDoctorModel().obs;
  fetchDoctor() async {
    var response = await http.get(
        Uri.parse(
            '${Constants.apiUrl}/get-all-user-paticular-role?role=DOCTOR'),
        headers: Constants.header);
    doctorList.value = allDoctorModelFromJson(response.body);
    print(response.body);
    print(response.statusCode);
  }
  createUser() async {
    var response = await http.post(
        Uri.parse('${Constants.apiUrl}/create-profile-usingapp/'),
        headers: Constants.header,
        body: jsonEncode({
          "role": "USER",
          "parent_username": "null",
          "info": {
            "username": username.text,
            "name": name.text,
            "age": age.text,
            "email": email.text,
            "password": password.text,
          }
        }));
    print(response.body);
  }
}
