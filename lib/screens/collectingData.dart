import 'dart:convert';

import 'package:adv_eeg/controllers/bluetoothConnection_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/brain_signals_send_data.dart';

class CollectingData extends StatelessWidget {
  CollectingData({super.key});

  BrainSignalsController brainSignalsController =
      Get.put(BrainSignalsController());
  BluetoothController bluetoothController = Get.put(BluetoothController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                colorFilter:
                    ColorFilter.mode(Colors.black87, BlendMode.hardLight),
                image: AssetImage(
                  'assets/bg1.png',
                ),
                fit: BoxFit.cover)),
        child: Column(
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
            _Musicvisulaizer()
          ],
        ),
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
    // TODO: implement initState
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
    // TODO: implement dispose
    super.dispose();
    animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration.milliseconds,
      width: 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0x000fffff), Colors.cyan])),
      height: animation.value,
    );
  }
}

class _Musicvisulaizer extends StatelessWidget {
  _Musicvisulaizer({super.key});
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
