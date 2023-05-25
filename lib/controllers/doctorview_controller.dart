import 'dart:convert';

import 'package:adv_eeg/controllers/quiz_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../Constants/constants.dart';
import '../models/doctor_model.dart';
import 'getQuizData.dart';

class DoctorViewController extends GetxController {
  final url =
      '${Constants.apiUrl}/patient-refering-doctor/${GetStorage().read('loginDetails')['user']['uid']}/';
  var docDetails = DoctorData().obs;
  TextEditingController searchText = TextEditingController();
  // GetQuizController getQuizController = Get.put(GetQuizController());
  // DropDownController dropDown = DropDownController();
  TextEditingController droopDownController = TextEditingController();
  @override
  onInit() {
    super.onInit();
    fetchDocDetails();
  }

  fetchDocDetails() async {
    try {
      var response =
          await http.get(Uri.parse(url), headers: Constants().authHeader);
      // print(jsonDecode(response.body));
      // print(response.body.toString());
      // print('chud gaya kya??');
      print(response.statusCode);
      docDetails.value = doctorDataFromJson(response.body);

      // print(docDetails.value);
    } catch (er) {
      print(er);
    }
  }
}
