import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'package:get/get.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_bluetooth_seria_changed/flutter_bluetooth_serial.dart';
import '../controllers/bluetoothConnection_controller.dart';
import '../controllers/brain_signals_send_data.dart';
import 'collectingData.dart';

class EegScreen extends StatelessWidget {
  EegScreen({super.key});
  BluetoothController bluetoothController = Get.put(BluetoothController());
  BrainSignalsController brainSignalsCont = Get.put(BrainSignalsController());
  BluetoothConnection? connection;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          // bluetoothController.results.value = [];
          // bluetoothController.startDiscovery();
        },
        child: Scaffold(
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
                inAsyncCall: bluetoothController.connecting.value,
                progressIndicator: SizedBox(
                  height: 100,
                  width: 100,
                  child: LiquidCircularProgressIndicator(
                    center: Text('Connecting to your device'),
                    // backgroundColor: Colors.amber,
                  ),
                ),
                child: Obx(
                  () => ListView.builder(
                    itemCount: bluetoothController.results.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () async {
                        // Some simplest connection :F
                        try {
                          bluetoothController.connecting.value = true;
                          connection = await BluetoothConnection.toAddress(
                              bluetoothController
                                  .results[index].device.address);
                          print(connection);
                          print('Connected to the device');
                          // Get.to(() => CollectingData());
                          connection!.input?.listen((var data) {
                            print(data);
                            print('Data incoming: ${ascii.decode(data)}');
                            brainSignalsCont.deviceId.value =
                                bluetoothController
                                    .results[index].device.address;
                            brainSignalsCont.valueRecieved.value =
                                double.parse(ascii.decode(data));
                            brainSignalsCont.postData(connection);
                            Get.off(() => CollectingData());
                            connection!.output.add(data); // Sending data

                            if (ascii.decode(data).contains('!')) {
                              connection!.finish(); // Closing connection
                              print('Disconnecting by local host');
                            }
                          }).onDone(() {
                            print('Disconnected by remote request');
                          });
                        } catch (exception) {
                          bluetoothController.connecting.value = false;
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
                              )
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Material(
                          //     elevation: 20,
                          //     child: Container(
                          //       margin: EdgeInsets.all(20),
                          //       child: Text(bluetoothController
                          //                   .results[index].device.name ==
                          //               null
                          //           ? bluetoothController
                          //               .results[index].device.address
                          //           : bluetoothController
                          //               .results[index].device.name!),
                          //     ),
                          //   ),
                          // ),
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
