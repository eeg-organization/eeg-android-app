import 'package:adv_eeg/models/anyUserModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Constants/constants.dart';

class UsersController extends GetxController {
  UsersController(this.role);
  final String role;
  var users = User().obs;
  var doctors = User().obs;
  var relatives = User().obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      var response1 = await http.get(
          Uri.parse(
              '${Constants.apiUrl}/get-all-user-paticular-role?role=USER'),
          headers: Constants().authHeader);
      var response2 = await http.get(
          Uri.parse(
              '${Constants.apiUrl}/get-all-user-paticular-role?role=DOCTOR'),
          headers: Constants().authHeader);
      var response3 = await http.get(
          Uri.parse(
              '${Constants.apiUrl}/get-all-user-paticular-role?role=RELATIVE'),
          headers: Constants().authHeader);
      users.value = userFromJson(response1.body);
      doctors.value = userFromJson(response2.body);
      relatives.value = userFromJson(response3.body);
    } finally {
      isLoading(false);
    }
  }
}
