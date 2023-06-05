import 'dart:convert';

import 'package:adv_eeg/controllers/question_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../Constants/constants.dart';
import '../models/profile_model.dart';

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
    int sum = 0;
    for (int i = 0;
        i < questionController.question.value.questions.length;
        i++) {
      sum += i;
      options['${questionController.question.value.questions[i].question?.question}'] =
          questionController.options[i];
    }
    // print(options);
    // print(sum);
    // options.value = options;
  }

  var profile = Profile().obs;
  // options.value=
  fetchProfile(String profileId) async {
    try {
      var response = await http.get(
          Uri.parse('${Constants.apiUrl}/get-profile/$profileId'),
          headers: Constants().authHeader);
      // print(response.body);
      profile.value = profileFromJson(response.body);
    } catch (err) {
      isLoading.value = false;
      // Error();
      print(err);
    }
  }

  postData() async {
    isLoading.value = true;
    // RxString token = ''.obs;
    // await fetchProfile(
    //     GetStorage().read('loginDetails')['user']['related_to'][0]);
    // await FirebaseMessaging.instance
    //     .getToken()
    //     .then((value) => token.value = value!);
    try {
      print(profile.value.name);
      // print(questionController.question);
      // print(questionCo
      // ntroller.question.value.questionare?.uid);
      // print(GetStorage().read('loginDetails')['user']['uid']);
      var response = await http.post(Uri.parse(url),
          body: jsonEncode(
            {
              "data": questionController.question.value,
              "questionare": questionController.question.value.questionare?.uid,
              "options": options,
              "user": GetStorage().read('loginDetails')['user']['uid'],
            },
          ),
          headers: Constants().authHeader);
      isLoading.value = false;
      print(response.body);
      print(response.statusCode);

      return response.statusCode;
    } catch (er) {
      print(er);
      isLoading.value = false;
    }
  }

  
}
