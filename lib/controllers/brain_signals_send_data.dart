import 'dart:convert';

import 'package:dio/dio.dart';
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
    super.dispose();
    EegScreen().connection!.dispose();
  }

  var valueRecieved = 0.0.obs;
  var deviceId = ''.obs;
  var dataList = [].obs;
  final dio = Dio();

  getPrediction() async {
    // Get.to(() => CollectingData());
    var url = '${predictionUrl}/predict';
    // connection.finish();
    try {
      // Get.snackbar('Data', dataList.sublist(dataList.length - 9).toString());
      var body = {"list": dataList.sublist(dataList.length - 8)};
      print(body);
      final response = await dio.post(url, data: body);
      print(response.statusCode);
      // Get.snackbar('StatusCode', response.statusCode.toString());

      // Get.snackbar('Body', response.data);
      if (response.statusCode == 200) {
        var data = response.data;
        print(data);

        valueRecieved.value = double.parse(data['prediction'].toString());
        await postPrediction();
        // Get.off(() => PatientLogin());
      }
    } catch (err) {
      print(err);
      Get.snackbar('Error', err.toString());
    }
  }

  postPrediction() async {
    var url = '${Constants.apiUrl}/brain-signal-score/';
    print('aaya???');
    try {
      print(valueRecieved.value);
      print(deviceId.value);
      print(DateTime.now().millisecondsSinceEpoch);
      print(GetStorage().read('loginDetails')['user']['uid']);
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
        Get.off(() => PatientLogin());
      }
    } catch (err) {
      print(err);
    }
  }
}
