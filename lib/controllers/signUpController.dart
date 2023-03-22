import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Constants/constants.dart';

class SignUpController extends GetxController {
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

  createUser() async {
    var response =
        await http.post(Uri.parse('${Constants.apiUrl}/create-profile-admin/'),
            headers: Constants.header,
            body: jsonEncode({
              "role": "USER",
              "parent_username": "null",
              "info": {
                "username": username.text,
                "name": name.text,
                "age": age.text,
                "email": email.text,
                "password":password.text,
                
              }
            }));
  }
}
