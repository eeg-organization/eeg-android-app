import 'dart:convert';

import 'package:adv_eeg/models/allDoctorModel.dart';
import 'package:adv_eeg/models/user_model.dart';
import 'package:adv_eeg/screens/emailLogin.dart';
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
  var isLoading = false.obs;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  var bloodGroup = "BLOOD GROUP".obs;
  var doctor = 'DOCTOR'.obs;
  TextEditingController bloodPressure = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  var gender = 'GENDER'.obs;
  //create-user-usinapp
  var doctorList = AllDoctorModel().obs;
  fetchDoctor() async {
    try {
      isLoading(true);
      var response = await http.get(
          Uri.parse(
              '${Constants.apiUrl}/get-all-user-paticular-role?role=DOCTOR'),
          headers: Constants.header);
      print(response.body);
      doctorList.value = allDoctorModelFromJson(response.body);
      print(response.statusCode);
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  createUser() async {
    try {
      isLoading(true);
      print(doctor.value);
      print(username.text);
      print(name.text);
      print(age.text);
      print(password.text);
      var response = await http.post(
          Uri.parse('${Constants.apiUrl}/create-profile-usingapp/'),
          headers: Constants.header,
          body: jsonEncode({
            "role": "USER",
            "parent_username": doctor.value,
            "info": {
              "username": username.text,
              "name": name.text,
              "age": age.text,
              "role": "USER",
              // "email": email.text,
              "password": password.text,
            }
          }));
      print(response.body);
      Get.snackbar('Success',
          'Your account has been created successfully! Login to Continue');
      Get.off(() => usernameLogin(
            role: 'USER',
          ));
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
