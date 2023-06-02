
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
      chartData.addAll(quiz.value.quizs.map((e) => ChartData(
          DateTime(e.createdAt.year, e.createdAt.month, e.createdAt.day,
              e.createdAt.hour, e.createdAt.minute, e.createdAt.second),
          e.score,e.data.questionare.type)));
    } catch (err) {
      print(err);
      isLoading(false);
    }
  }
  fetchBrainScore()async{
     try {
      isLoading(true);
      var response = await http.get(
          Uri.parse('${Constants.apiUrl}/get-brainsignal-score/$uid'),
          headers: Constants().authHeader);
      print(response.body);
      isLoading(false);
      quiz.value = quizFromJson(response.body);
      chartData.addAll(quiz.value.quizs.map((e) => ChartData(
          DateTime(e.createdAt.year, e.createdAt.month, e.createdAt.day,
              e.createdAt.hour, e.createdAt.minute, e.createdAt.second),
          e.score,e.data.questionare.type)));
    } catch (err) {
      print(err);
      isLoading(false);
    }
  }
}
