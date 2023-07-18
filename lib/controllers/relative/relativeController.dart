import 'dart:convert';

import 'package:adv_eeg/Constants/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../models/brainScoreModel.dart';
import '../../models/patients/quiz_model.dart';
import '../../models/profile_model.dart';
import '../../screens/doctorScreens/patientDetailedView(DocEnd).dart';

class RelativeController extends GetxController {
  @override
  Future onInit() async {
    // TODO: implement onInit
    await getRelative();
    await fetchProfile();
    // await fetchQuiz();
    // await fetchBrainScore();
    super.onInit();
  }

  var data = ''.obs;
  RxList<ChartData> chartData = <ChartData>[].obs;
  RxList<ChartData> brainScore = <ChartData>[].obs;
  getRelative() async {
    var response = await http.get(Uri.parse(
        '${Constants.apiUrl}/find-related-patient/${GetStorage().read('loginDetails')['user']['uid']}'));
    print(response.body);
    data.value = jsonDecode(response.body)['message']['patient'][0];
  }

  var profile = Profile().obs;
  var isLoading = false.obs;
  fetchProfile() async {
    isLoading.value = true;
    await fetchBrainScore();
    await fetchQuiz();
    try {
      var response = await http.get(
          Uri.parse('${Constants.apiUrl}/get-profile/$data'),
          headers: Constants().authHeader);
      // print(response.body);
      isLoading.value = false;
      profile.value = profileFromJson(response.body);
    } catch (err) {
      isLoading.value = false;
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

  var brainScores = <BrainScoreModel>[].obs;
  fetchBrainScore() async {
    try {
      var response = await http.get(
          Uri.parse('${Constants.apiUrl}/get-brainsignal-score/${data}'),
          headers: Constants().authHeader);
      print(response.body);
      isLoading(false);
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
