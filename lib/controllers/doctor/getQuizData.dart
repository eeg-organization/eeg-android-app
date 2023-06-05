import 'package:adv_eeg/models/brainScoreModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Constants/constants.dart';
import '../../models/patients/quiz_model.dart';
import '../../screens/doctorScreens/patientDetailedView(DocEnd).dart';

class GetQuizController extends GetxController {
  GetQuizController(this.uid);
  final String uid;
  RxList<ChartData> chartData = <ChartData>[].obs;

  @override
  void onInit() async {
    await fetchQuiz();

    super.onInit();
  }

  var brainScores = <BrainScoreModel>[].obs;
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
          e.score,
          e.data.questionare.type)));
    } catch (err) {
      print(err);
      isLoading(false);
    }
  }

  fetchBrainScore() async {
    try {
      var response = await http.get(
          Uri.parse('${Constants.apiUrl}/get-brainsignal-score/$uid'),
          headers: Constants().authHeader);
      print(response.body);
      isLoading(false);
      brainScores.value = brainScoreModelFromJson(response.body);
    } catch (err) {
      Get.snackbar('Error', 'Something went wrong');
      print(err);
    }
    finally{
      isLoading(false);
    }
  }
}
