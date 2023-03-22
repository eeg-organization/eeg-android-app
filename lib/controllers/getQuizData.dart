import 'dart:ffi';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Constants/constants.dart';
import '../models/quiz_model.dart';
import '../screens/patientDetailedView(DocEnd).dart';

class GetQuizController extends GetxController {
  GetQuizController(this.uid);
  final String uid;
  RxList<ChartData> chartData = <ChartData>[].obs;
  @override
  void onInit() async {
    await fetchQuiz();

    super.onInit();
  }

  var QuizList = [].obs;
  var quiz = Quiz(quizs: []).obs;
  var isLoading = false.obs;

  fetchQuiz() async {
    try {
      isLoading(true);
      var response = await http.get(
          Uri.parse('${Constants.apiUrl}/get-profile-quizs/$uid'),
          headers: Constants().authHeader);
      print(response.body);
      isLoading(false);
      quiz.value = quizFromJson(response.body);
      chartData.addAll(quiz.value.quizs.map((e) =>
          ChartData(DateFormat('ddmmyyyy').format(e.createdAt), e.score)));
    } catch (err) {
      print(err);
      isLoading(false);
    }
  }
}
