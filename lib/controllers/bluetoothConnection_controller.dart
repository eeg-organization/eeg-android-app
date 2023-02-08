import 'dart:async';
// import 'dart:io';

import 'package:flutter_bluetooth_seria_changed/flutter_bluetooth_serial.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    // Permission.bluetooth.request();
    _startDiscovery();
    print(results);
  }

  RxList<String> devices = <String>[].obs;
  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  var results = <BluetoothDiscoveryResult>[].obs;
  var isDiscovering = false.obs;
  var connecting = false.obs;
  void _startDiscovery() async {
    // results.value = [];
    isDiscovering = true.obs;
    // print(await FlutterBluetoothSerial.instance.address);
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      print(r);
      final existingIndex = results
          .indexWhere((element) => element.device.address == r.device.address);
      if (existingIndex >= 0) {
        results[existingIndex] = r;
      } else {
        results.add(r);
      }
    });

    _streamSubscription!.onDone(() {
      isDiscovering.value = false;
    });
    print(results);
  }
}
