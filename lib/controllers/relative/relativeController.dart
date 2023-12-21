
import 'package:adv_eeg/Constants/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../models/allRelatedUsers.dart';


class RelativeController extends GetxController {
  @override
  Future onInit() async {
    // TODO: implement onInit
    await getRelative();
    // await fetchQuiz();
    // await fetchBrainScore();
    super.onInit();
  }

  Rx<AllRelatedUser> data = AllRelatedUser().obs;

  var isLoading = false.obs;
  getRelative() async {
    try {
      isLoading(true);
      var response = await http.get(
          Uri.parse(
              '${Constants.apiUrl}/find-related-patient/${GetStorage().read('loginDetails')['user']['uid']}'),
          headers: Constants().authHeader);
      // print(response.body);
      data.value = allRelatedUserFromJson(response.body);
      print(data);
    } catch (err) {
      print(err);
    } finally {
      isLoading(false);
    }
  }
}
