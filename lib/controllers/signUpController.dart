import 'dart:convert';

import 'package:adv_eeg/models/allDoctorModel.dart';
import 'package:adv_eeg/screens/emailLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Constants/constants.dart';

class SignUpController extends GetxController {
  SignUpController({required this.role});
  final role;
  @override
  void onInit() async {
    super.onInit();
    if (role != 'DOCTOR') await fetchRole();
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
  var userList = AllDoctorModel().obs;
  fetchRole() async {
    try {
      isLoading(true);
      var url;
      if (role == 'USER')
        url = '${Constants.apiUrl}/get-all-user-paticular-role?role=DOCTOR';
      else if (role == 'RELATIVE')
        url = '${Constants.apiUrl}/get-all-user-paticular-role?role=USER';
      var response = await http.get(Uri.parse(url), headers: Constants.header);
      print(response.body);
      userList.value = allDoctorModelFromJson(response.body);
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
              "role": role,
              "email": email.text,
              "phone_no": phoneNo.text,
              "gender": gender.value,
              "blood_group": bloodGroup.value,
              "password": password.text,
            }
          }));
      print(response.body);
      Get.snackbar('Success',
          'Your account has been created successfully! Login to Continue');
      Get.off(() => usernameLogin());
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
