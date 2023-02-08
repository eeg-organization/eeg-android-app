import 'dart:convert';

import 'package:adv_eeg/controllers/question_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../Constants/constants.dart';

class QuizController extends GetxController {
  String type;
  late QuestionController questionController;
  var isLoading = false.obs;
  QuizController(this.type);
  @override
  void onInit() {
    questionController = Get.put(QuestionController(type));
    super.onInit();
  }

  final url = '${Constants.apiUrl}/create-quiz/';

  var options = <String, int>{}.obs;
  mergeScoreAndQuestion() {
    for (int i = 0;
        i < questionController.question.value.questions!.length;
        i++) {
      options['${questionController.question.value.questions?[i].question?.question}'] =
          questionController.options[i];
    }
    print(options);
    // options.value = options;
  }
  // options.value=

  postData() async {
    isLoading.value = true;
    try {
      // print(questionController.question);
      // print(questionController.question.value.questionare?.uid);
      var response = await http.post(Uri.parse(url),
          body: jsonEncode(
            {
              "data": questionController.question.value,
              "questionare": questionController.question.value.questionare?.uid,
              "options": options,
              "user": GetStorage().read('loginDetails')['user_id']
            },
          ),
          headers: Constants().authHeader);
      isLoading.value = false;
      // print(response.body);
      // print(response.statusCode);

      return response.statusCode;
    } catch (er) {
      print(er);
      isLoading.value = false;
    }
  }
}
