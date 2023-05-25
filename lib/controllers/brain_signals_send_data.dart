import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../Constants/constants.dart';
import '../screens/eegScreen.dart';
import '../screens/patient_login.dart';

class BrainSignalsController extends GetxController {
  // @override
  // Future onInit() async {
  //   // TODO: implement onInit
  //   super.onInit();
  //   await postData();
  // }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  //   EegScreen().connection!.dispose();
  // }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EegScreen().connection!.dispose();
  }

  var valueRecieved = 0.0.obs;
  var deviceId = ''.obs;

  postData(var connection) async {
    var url = '${Constants.apiUrl}/brain-signal-score/';
    print('aaya???');
    try {
      print(valueRecieved.value);
      print(deviceId.value);
      final response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "user": GetStorage().read('loginDetails')['user']['uid'],
            "timestamp": DateTime.now().millisecondsSinceEpoch,
            "device_id": deviceId.value,
            "score": valueRecieved.value
          }),
          headers: Constants().authHeader);
      // print(response.body);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) {
        connection.finish();
        Get.off(() => PatientLogin());
      }
    } catch (err) {
      print(err);
    }
  }
}
