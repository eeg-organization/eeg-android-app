import 'package:adv_eeg/models/profile_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../Constants/constants.dart';
import '../models/brainScoreModel.dart';
import '../models/quiz_model.dart';

class GetProflieController extends GetxController {
  @override
  void onInit() async {
    await fetchProfile(GetStorage().read('loginDetails')['user']['uid']);
    super.onInit();
  }

  var profile = Profile().obs;
  var isLoading = false.obs;
  fetchProfile(String profileId) async {
    isLoading.value = true;
    try {
      var response = await http.get(
          Uri.parse('${Constants.apiUrl}/get-profile/$profileId'),
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
          Uri.parse(
              '${Constants.apiUrl}/get-profile-quizs/${GetStorage().read('loginDetails')['user']['uid']}'),
          headers: Constants().authHeader);
      print(response.body);
      isLoading(false);
      quiz.value = quizFromJson(response.body);
      // chartData.addAll(quiz.value.quizs.map((e) => ChartData(
      //     DateTime(e.createdAt.year, e.createdAt.month, e.createdAt.day,
      //         e.createdAt.hour, e.createdAt.minute, e.createdAt.second),
      //     e.score,e.data.questionare.type)));
    } catch (err) {
      print(err);
      isLoading(false);
    }
  }

  var brainScores = <BrainScoreModel>[].obs;
  fetchBrainScore() async {
    try {
      var response = await http.get(
          Uri.parse(
              '${Constants.apiUrl}/get-brainsignal-score/${GetStorage().read('loginDetails')['user']['uid']}'),
          headers: Constants().authHeader);
      print(response.body);
      isLoading(false);
      brainScores.value = brainScoreModelFromJson(response.body);
    } catch (err) {
      Get.snackbar('Error', 'Something went wrong');
      print(err);
    } finally {
      isLoading(false);
    }
  }

  logout() async {
    isLoading.value = true;
    try {
      var response = await http.get(Uri.parse('${Constants.apiUrl}/logout/'),
          headers: Constants().authHeader);
      print(response.body);
      print(response.statusCode);
    } catch (err) {
      print(err);
    } finally {
      isLoading.value = false;
    }
  }
}
