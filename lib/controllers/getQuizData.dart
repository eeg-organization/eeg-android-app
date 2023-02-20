import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Constants/constants.dart';
import '../models/quiz_model.dart';

class GetQuizController extends GetxController {
  var QuizList = [].obs;
  var quiz = Quiz().obs;
  fetchQuiz(String uid) async {
    try {
      var response = await http.get(
          Uri.parse('${Constants.apiUrl}/get-profile-quizs/$uid'),
          headers: Constants().authHeader);
      print(response.body);
      quiz.value = quizFromJson(response.body);
      QuizList.add(quiz);
    } catch (err) {
      print(err);
    }
  }
}
