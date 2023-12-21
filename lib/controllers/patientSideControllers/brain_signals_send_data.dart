import 'dart:convert';

import 'package:adv_eeg/screens/patientScreens/collectingData.dart';
import 'package:adv_eeg/screens/patientScreens/yogaScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_seria_changed/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../Constants/constants.dart';
import '../../screens/patientScreens/eegScreen.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

class BrainSignalsController extends GetxController {
  @override
  void dispose() {
    super.dispose();
    EegScreen().connection!.dispose();
  }

  var valueRecieved = 0.0.obs;
  var deviceId = ''.obs;
  var dataList = [].obs;
  final dio = Dio();
  final isLoading = false.obs;

  getPrediction() async {
    final interpreter = await tfl.Interpreter.fromAsset('assets/model.tflite');
    // Get.to(() => CollectingData());
    var output = 0.0;
    interpreter.run(dataList, output);
    print(output);
    // var url = '${predictionUrl}/predict_multiclass';
    // if (!isLoading.value) {
    //   try {
    //     isLoading.value = true;
    //     Get.off(() => CollectingData());
    //     // Get.snackbar('Data', dataList.sublist(dataList.length - 9).toString());
    //     var body = {"list": dataList};
    //     print(body);
    //     final response = await dio.post(url, data: body);
    //     print(response.statusCode);
    //     // Get.snackbar('StatusCode', response.statusCode.toString());
    //     // Get.snackbar('Body', response.data['prediction'].toString());

    //     if (response.statusCode == 200) {
    //       var data = response.data;
    //       print(data);

    //       valueRecieved.value = double.parse(data['prediction'].toString());
    //       await postPrediction();
    //       // Get.off(() => PatientLogin());
    //     }
    //   } catch (err) {
    //     print(err);
    //     Get.snackbar('Error', err.toString());
    //   }
    // }
  }

  postPrediction() async {
    var url = '${Constants.apiUrl}/brain-signal-score/';
    print('aaya???');
    try {
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
        isLoading.value = false;
        Get.bottomSheet(
          Material(
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  // color: Colors.white,
                  child: Center(
                    child: Text(
                      'Your Score is ${valueRecieved.value.toString()}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  child: Image.asset(
                    'assets/eeg.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.off(() => YogaScreen());
                    },
                    child: Text('Checkout Yoga'))
              ],
            ),
          ),
          elevation: 2,
          backgroundColor: Colors.transparent,
          shape: ShapeBorder.lerp(null, null, 0),
        );
        // Get.off(() => YogaScreen()
      }
    } catch (err) {
      print(err);
    }
  }
}
