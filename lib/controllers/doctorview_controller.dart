import 'dart:convert';

import 'package:adv_egg/models/doctor_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Constants/constants.dart';

class DoctorViewController extends GetxController {
  final url =
      '${Constants.apiUrl}/users-referring-doctor/c280ee21-c4d4-4801-8855-97b7c2996813';
  var docDetails = DoctorData(patientInfo: []).obs;
  TextEditingController searchText = TextEditingController();
  // DropDownController dropDown = DropDownController();
  TextEditingController droopDownController = TextEditingController();
  @override
  onInit() {
    super.onInit();
    fetchDocDetails();
  }

  fetchDocDetails() async {
    try {
      var response = await http.get(Uri.parse(url), headers: Constants.header);
      // print(jsonDecode(response.body));
      // print(response.body.toString());
      print('chud gaya kya??');
      docDetails.value = doctorDataFromJson(response.body);
      // print(docDetails.value);
    } catch (er) {
      print(er);
    }
  }
}
