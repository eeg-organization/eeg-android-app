import 'dart:convert';

import 'package:adv_egg/controllers/question_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Constants/constants.dart';

class QuizController extends GetxController {
  final url = '${Constants.apiUrl}/create-quiz/';
  final QuestionController questionController = Get.put(QuestionController());

  var options = <String, int>{}.obs;
  mergeScoreAndQuestion() {
    for (int i = 0;
        i < questionController.question.value.questions!.length;
        i++) {
      options['${questionController.question.value.questions?[i].question?.question}'] =
          questionController.options[i];
    }
    // options.value = options;
    // print(options);
  }
  // options.value=

  postData() async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode(
            {
              "data": questionController.question.value,
              "questionare": questionController.question.value.questionare?.uid,
              "options": options,
              "user": "8516d8db-ab20-443e-8cfa-2b90a107ac34"
            },
          ),
          headers: Constants.header);
      // print(response.body);
      // print(response.statusCode);
      return response.statusCode;
    } catch (er) {
      print(er);
    }
  }
}
