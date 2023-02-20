import 'package:adv_eeg/models/profile_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Constants/constants.dart';

class GetProflieController extends GetxController {
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
}
