import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Constants/constants.dart';
import '../models/questions_model.dart';

class QuestionController extends GetxController {
  String type;
  QuestionController(this.type);
  @override
  void onInit() async {
    await getQuestions();
    isLoading.value = false;
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    question = baseResp().obs;
    options = [].obs;
    isLoading = true.obs;
  }

  var question = baseResp().obs;
  var options = [].obs;
  var quizResponse = ''.obs;
  var isLoading = true.obs;

  getQuestions() async {
    try {
      final url = '${Constants.apiUrl}/get-questionare/?type=$type';
      var response =
          await http.get(Uri.parse(url), headers: Constants().authHeader);
      // print(jsonDecode(response.body));

      question.value = baseResp.fromJson(jsonDecode(response.body));
      quizResponse.value = response.body;
      // print(question.value.questions);
      options.value = List.filled(question.value.questions!.length, -1);
    } catch (err) {
      // isLoading.value
      print(err);
    }
  }
}
