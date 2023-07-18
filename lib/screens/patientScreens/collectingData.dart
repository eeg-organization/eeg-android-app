
// ignore_for_file: must_be_immutable

import 'package:adv_eeg/controllers/patientSideControllers/bluetoothConnection_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/patientSideControllers/brain_signals_send_data.dart';

class CollectingData extends StatelessWidget {
  CollectingData({
    super.key,
  });

  BrainSignalsController brainSignalsController =
      Get.put(BrainSignalsController());
  BluetoothController bluetoothController = Get.put(BluetoothController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: Text(
              'Wait we are scanning your brain signals',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Musicvisulaizer()
        ],
      ),
    );
  }
}

class VisualComponent extends StatefulWidget {
  VisualComponent({super.key, required this.duration});
  final int duration;
  // final Color color;

  @override
  State<VisualComponent> createState() => _VisualComponentState();
}

class _VisualComponentState extends State<VisualComponent>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animController;
  @override
  void initState() {
    super.initState();
    animController = AnimationController(
        duration: Duration(milliseconds: widget.duration), vsync: this);
    final curvedAnimation =
        CurvedAnimation(parent: animController, curve: Curves.easeInOut);
    animation = Tween<double>(begin: 0, end: 100).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    animController.repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration.milliseconds,
      width: 5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromARGB(0, 0, 0, 0), Colors.cyan])),
      height: animation.value,
    );
  }
}
class Musicvisulaizer extends StatelessWidget {
  Musicvisulaizer({super.key});
  List<int> duration = [900, 700, 600, 800, 500];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(
          10,
          (index) => VisualComponent(
                duration: duration[index % 5],
                // color: colors[index % 4],
              )),
    );
  }
}
