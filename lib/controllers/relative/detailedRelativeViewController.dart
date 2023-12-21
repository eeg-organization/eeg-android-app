import 'dart:convert';

import 'package:get/get.dart';

import '../../Constants/constants.dart';
import '../../models/brainScoreModel.dart';
import '../../models/patients/quiz_model.dart';
import '../../models/profile_model.dart';
import '../../screens/doctorScreens/patientDetailedView(DocEnd).dart';
import 'package:http/http.dart' as http;

class RelativeDetailedController extends GetxController {
  RelativeDetailedController({required this.data});
  String data;
  @override
  Future onInit() async {
    await fetchProfile().whenComplete(() async =>
        await fetchQuiz().whenComplete(() async => await fetchBrainScore()));
    super.onInit();
  }

  var isLoading = false.obs;
  RxList<ChartData> chartData = <ChartData>[].obs;
  RxList<ChartData> brainScore = <ChartData>[].obs;
  var profile = Profile().obs;
  fetchProfile() async {
    isLoading.value = true;

    try {
      var response = await http.get(
          Uri.parse('${Constants.apiUrl}/get-profile/$data'),
          headers: Constants().authHeader);
      profile.value = profileFromJson(response.body);
    } catch (err) {
      // Error();
      print(err);
    }
  }

  var quiz = Quiz(quizs: []).obs;
  // var isLoading = false.obs;

  fetchQuiz() async {
    try {
      isLoading(true);
      var response = await http.get(
          Uri.parse('${Constants.apiUrl}/get-profile-quizs/${data}'),
          headers: Constants().authHeader);
      print(response.body);
      quiz.value = quizFromJson(response.body);
      chartData.addAll(quiz.value.quizs.map((e) => ChartData(
          DateTime(e.createdAt.year, e.createdAt.month, e.createdAt.day,
              e.createdAt.hour, e.createdAt.minute, e.createdAt.second),
          e.score,
          e.data.questionare.type)));
    } catch (err) {
      print(err);
    }
  }

  var brainScores = <BrainScoreModel>[].obs;
  fetchBrainScore() async {
    try {
      var response = await http.get(
          Uri.parse('${Constants.apiUrl}/get-brainsignal-score/${data}'),
          headers: Constants().authHeader);
      print(response.body);
      brainScores.value = brainScoreModelFromJson(
          jsonEncode(jsonDecode(response.body)['data']));
      brainScore.addAll(brainScores.map((e) => ChartData(
          DateTime(e.createdAt!.year, e.createdAt!.month, e.createdAt!.day,
              e.createdAt!.hour, e.createdAt!.minute, e.createdAt!.second),
          double.parse(e.score!).toInt(),
          e.deviceId)));
    } catch (err) {
      Get.snackbar('Error', 'Something went wrong');
      print(err);
    } finally {
      isLoading(false);
    }
  }
}
