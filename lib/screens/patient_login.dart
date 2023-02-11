import 'package:adv_eeg/screens/quiz_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_seria_changed/flutter_bluetooth_serial.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'eegScreen.dart';

class PatientLogin extends StatelessWidget {
  const PatientLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                colorFilter:
                    ColorFilter.mode(Colors.black87, BlendMode.hardLight),
                image: AssetImage('assets/bg1.png'),
                fit: BoxFit.cover)),
        child: SafeArea(
            child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: BackButton(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Choose an Option',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 30,
                  )
                  // fontWeight: FontWeight.),
                  ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                      onTap: () {
                        Get.to(() => const QuizPage());
                      },
                      child: const OptionButton(
                        text: 'Quiz',
                        color: Colors.transparent,
                      ))),
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                    onTap: () async {
                      final BluetoothDevice? selectedDevice = await Get.to(
                          () => EegScreen(),
                          transition: Transition.cupertino);
                    },
                    child: const OptionButton(
                      text: 'EEG',
                      color: Colors.transparent,
                    ),
                  )),
            )
          ],
        )),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  const OptionButton({super.key, this.text, required this.color});
  final text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: color,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(
              color: color != Color(0xffFF7E1D)
                  ? Colors.white
                  : Color(0xffFF7E1D)),
          borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
