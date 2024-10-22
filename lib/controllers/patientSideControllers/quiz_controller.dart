import 'dart:convert';

import 'package:adv_eeg/controllers/patientSideControllers/question_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../Constants/constants.dart';
import '../../models/profile_model.dart';

class QuizController extends GetxController {
  String type;
  late QuestionController questionController;
  var isLoading = false.obs;

  QuizController(this.type);
  @override
  void onInit() async {
    questionController = Get.put(QuestionController(type));
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {}
    }

    if (permission == LocationPermission.deniedForever) {
    } else {
      Position position = await Geolocator.getCurrentPosition();
      latitude!.value = position.latitude.toString();
      longitude!.value = position.longitude.toString();
    }
    super.onInit();
  }

  final url = '${Constants.apiUrl}/create-quiz/';

  var options = <String, int>{}.obs;
  RxString? latitude = ''.obs;
  RxString? longitude = ''.obs;

  mergeScoreAndQuestion() {
    for (int i = 0;
        i < questionController.question.value.questions.length;
        i++) {
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

  var score = 0.obs;
  postData(String uid) async {
    isLoading.value = true;
    // RxString token = ''.obs;
    // await fetchProfile(
    //     GetStorage().read('loginDetails')['user']['related_to'][0]);
    // await FirebaseMessaging.instance
    //     .getToken()
    //     .then((value) => token.value = value!);
    try {
      // print(options);
      // print(profile.value.name);
      // // print(questionController.question);
      // // print(questionCo
      // // ntroller.question.value.questionare?.uid);
      // // print(GetStorage().read('loginDetails')['user']['uid']);
      // print({
      //   "data": questionController.question.value,
      //   "questionare": questionController.question.value.questionare?.uid,
      //   "options": options,
      //   "user": uid,
      // });
      var response = await http.post(Uri.parse(url),
          body: jsonEncode(
            {
              "data": questionController.question.value,
              "questionare": questionController.question.value.questionare?.uid,
              "options": options,
              "user": uid,
              "latitude": latitude?.value,
              "longitude": longitude?.value
            },
          ),
          headers: Constants().authHeader);
      isLoading.value = false;
      print(response.body);
      print(response.statusCode);
      score.value = jsonDecode(response.body)['score'];
      return response.statusCode;
    } catch (er) {
      print(er);
      isLoading.value = false;
    }
  }
}
