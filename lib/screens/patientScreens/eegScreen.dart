// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_bluetooth_seria_changed/flutter_bluetooth_serial.dart';
import 'package:toast/toast.dart';
import '../../controllers/patientSideControllers/bluetoothConnection_controller.dart';
import '../../controllers/patientSideControllers/brain_signals_send_data.dart';
import 'collectingData.dart';

class EegScreen extends StatelessWidget {
  EegScreen({super.key});
  BluetoothController bluetoothController = Get.put(BluetoothController());
  BrainSignalsController brainSignalsCont = Get.put(BrainSignalsController());
  BluetoothConnection? connection;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          bluetoothController.results.value = [];
          bluetoothController.isDiscovering.value = true;
          bluetoothController.discoverBluetooth();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: BackButton(
              color: Colors.white,
              onPressed: () => Get.back(),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.black87, BlendMode.hardLight),
                    // colorFilter: ColorFilterLayer(colorFilter: ColorFilter.matrix(matrix)),
                    image: AssetImage(
                      'assets/bg1.png',
                    ),
                    fit: BoxFit.cover)),
            child: Obx(
              () => ModalProgressHUD(
                inAsyncCall: bluetoothController.connecting.value ||
                    (bluetoothController.connection.value != null &&
                        bluetoothController.connection.value!.isConnected),
                progressIndicator: SizedBox(
                  height: 200,
                  width: 200,
                  child: Column(
                    children: [
                      bluetoothController.connection.value != null &&
                              bluetoothController.connection.value!.isConnected
                          ? Musicvisulaizer()
                          : CircularProgressIndicator.adaptive(),
                      (bluetoothController.connection.value != null &&
                              bluetoothController.connection.value!.isConnected)
                          ? Text('Getting your Brain Signals',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white))
                          : bluetoothController.connecting.value
                              ? Text('Connecting to your device',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white))
                              : bluetoothController.isDiscovering.value
                                  ? Text(
                                      'Discovering Devices',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : const Text('')
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: BackButton(
                    //     color: Colors.white,
                    //     onPressed: () => Get.back(),
                    //   ),
                    // ),
                    Obx(
                      () => Expanded(
                        child: ListView.builder(
                          itemCount: bluetoothController.results.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () async {
                              // Some simplest connection :F
                              try {
                                bluetoothController.connecting.value = true;
                                connection =
                                    await BluetoothConnection.toAddress(
                                        bluetoothController
                                            .results[index].device.address);
                                bluetoothController.connection.value =
                                    connection;
                                brainSignalsCont.deviceId.value =
                                    bluetoothController
                                        .results[index].device.address;
                                // print(connection);
                                bluetoothController.connecting.value = false;
                                var t = DateTime.now().millisecondsSinceEpoch;
                                connection!.input?.listen((var data) {
                                  print(data);
                                  // Get.snackbar('Data', data.toString());
                                  print('Data incoming: ${ascii.decode(data)}');

                                  if (DateTime.fromMillisecondsSinceEpoch(t)
                                          .difference(DateTime.now())
                                          .inMinutes
                                          .abs() <
                                      1) {
                                    brainSignalsCont.dataList
                                        .add(double.parse(ascii.decode(data)));
                                  } else if (DateTime
                                              .fromMillisecondsSinceEpoch(t)
                                          .difference(DateTime.now())
                                          .inMinutes
                                          .abs() >=
                                      1) {
                                    brainSignalsCont.getPrediction();
                                    // connection!.output.add(data);
                                    connection!.finish(); // Sending data
                                    Get.off(() => CollectingData());
                                    // connection!.finish();
                                    if (ascii.decode(data).contains('!')) {
                                      connection!
                                          .finish(); // Closing connection
                                      print('Disconnecting by local host');
                                    }
                                  }
                                }).onDone(() {
                                  // Get.snackbar('Done', 'Done');
                                  print('Disconnected by remote request');
                                });
                              } catch (exception) {
                                bluetoothController.connecting.value = false;
                                // Get.snackbar('Error', exception.toString());
                                // Toast.show(
                                //   'Cannot Connect to your device. Some error occurred. Try again',
                                //   backgroundColor: Colors.black,
                                //   textStyle: GoogleFonts.inika(
                                //     color: Colors.white,
                                //     fontSize: 15,
                                //   ),
                                //   duration: 2,
                                // );
                                Get.snackbar('Error',
                                    'Cannot Connect to your device. Some error occurred. Try again',
                                    snackPosition: SnackPosition.BOTTOM,
                                    barBlur: 0);
                                print('Cannot connect, exception occured');
                                // print(exception);
                              }
                            },
                            child: Obx(() => ListTile(
                                  enableFeedback: true,
                                  // contentPadding: ,
                                  tileColor: Colors.black,
                                  iconColor: Colors.white,
                                  trailing: const Icon(Icons.bluetooth),
                                  textColor: Colors.white,
                                  // style: ListTileStyle.drawer,
                                  title: bluetoothController
                                              .results[index].device.name !=
                                          null
                                      ? Text(bluetoothController
                                          .results[index].device.name!)
                                      : null,
                                  subtitle: Text(bluetoothController
                                      .results[index].device.address),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}