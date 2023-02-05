import 'dart:async';
import 'dart:convert';

import 'package:adv_egg/controllers/bluetoothConnection_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

class EegScreen extends StatefulWidget {
  const EegScreen({super.key});

  @override
  State<EegScreen> createState() => _EegScreenState();
}

class _EegScreenState extends State<EegScreen> {
  BluetoothController bluetoothController = Get.put(BluetoothController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: RefreshIndicator(
      onRefresh: () async {
        // bluetoothController.results.value = [];
        // bluetoothController.startDiscovery();
      },
      child: Scaffold(
          body: Obx(
        () => ListView.builder(
            itemCount: bluetoothController.results.length,
            itemBuilder: (context, index) => GestureDetector(
                onTap: () async {
                  // Some simplest connection :F
                  try {
                    BluetoothConnection connection =
                        await BluetoothConnection.toAddress(
                            bluetoothController.results[index].device.address);
                    print('Connected to the device');

                    connection.input?.listen((Uint8List data) {
                      print('Data incoming: ${ascii.decode(data)}');
                      connection.output.add(data); // Sending data

                      if (ascii.decode(data).contains('!')) {
                        connection.finish(); // Closing connection
                        print('Disconnecting by local host');
                      }
                    }).onDone(() {
                      print('Disconnected by remote request');
                    });
                  } catch (exception) {
                    print('Cannot connect, exception occured');
                    print(exception);
                  }
                },
                child: Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 20,
                      child: Container(
                          margin: EdgeInsets.all(20),
                          child: Text(
                              bluetoothController.results[index].device.name ==
                                      null
                                  ? bluetoothController
                                      .results[index].device.address
                                  : bluetoothController
                                      .results[index].device.name!)),
                    ),
                  ),
                ))),
      )),
    ));
  }
}
