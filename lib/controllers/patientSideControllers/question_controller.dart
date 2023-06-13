import 'dart:convert';

import 'package:adv_eeg/screens/patientScreens/patient_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Constants/constants.dart';
import '../../models/patients/questions_model.dart';

class QuestionController extends GetxController {
  String type;
  QuestionController(this.type);
  @override
  void onInit() async {
    await getQuestions();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    question = baseResp(questions: []).obs;
    options = [].obs;
    isLoading = true.obs;
  }

  var   question = baseResp(questions: []).obs;
  var options = [].obs;
  var quizResponse = ''.obs;
  var isLoading = false.obs;

  getQuestions() async {
    isLoading(true);
    try {
      final url = '${Constants.apiUrl}/get-questionare/?type=$type';
      var response =
          await http.get(Uri.parse(url), headers: Constants().authHeader);
      // print(jsonDecode(response.body));

      question.value = baseResp.fromJson(jsonDecode(response.body));
      quizResponse.value = response.body;
      // print(question.value.questions);
      options.value = List.filled(question.value.questions.length, -1);
    } catch (err) {
      // isLoading.value
      Future.delayed(Duration(seconds: 2), () {
        Get.rawSnackbar(
            message: 'Something went wrong',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            margin: EdgeInsets.all(20),
            borderRadius: 10,
            duration: Duration(seconds: 2));
        isLoading(false);
        Get.off(() => PatientLogin());
      });
      print(err);
    } finally {
      isLoading(false);
    }
  }
}
