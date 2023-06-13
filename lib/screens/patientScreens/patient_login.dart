// ignore_for_file: must_be_immutable

import 'package:adv_eeg/controllers/patientSideControllers/getProfileController.dart';
import 'package:adv_eeg/screens/landing.dart';
import 'package:adv_eeg/screens/patientScreens/quiz_page.dart';
import 'package:adv_eeg/screens/patientScreens/yogaScreen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_seria_changed/flutter_bluetooth_serial.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../utils/reportGenerator/eegReportGenerator.dart';
import '../../utils/reportGenerator/quizReportGenerator.dart';
import 'eegScreen.dart';

class PatientLogin extends StatelessWidget {
  PatientLogin({Key? key}) : super(key: key);
  GetProflieController getProflieController = Get.put(GetProflieController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: CustomDrawer(getProflieController: getProflieController),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: getProflieController.isLoading.value,
          child: Container(
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
                            Get.to(() => QuizPage(role: "USER",uid:  GetStorage().read('loginDetails')['user']['uid'],));
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
                          if (!GetPlatform.isAndroid) {
                            Get.snackbar('Alert',
                                'This feature is not available for your Platform');
                            return;
                          }
                          if (await FlutterBluetoothSerial.instance.state ==
                              BluetoothState.STATE_OFF) {
                            await FlutterBluetoothSerial.instance
                                .requestEnable();
                            if (await FlutterBluetoothSerial.instance.state ==
                                BluetoothState.STATE_OFF) {
                              Get.snackbar('Alert', 'Please turn on bluetooth');
                              return;
                            }
                          } await Get.to(
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
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.getProflieController,
  });

  final GetProflieController getProflieController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          child: Column(
        children: [
          DrawerHeader(
            child: Container(
              height: Get.height,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${getProflieController.profile.value.name}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '${getProflieController.profile.value.username}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            onTap: () async {
              await getProflieController.fetchQuiz();
              await generateQuizReport(getProflieController.quiz);
              // Get.to(() => QuizPage());
            },
            leading: Icon(Icons.quiz),
            title: Text('Fetch Previous Quiz Reports'),
          ),
          ListTile(
            onTap: () async {
              await getProflieController.fetchBrainScore();
              await generatEEGReport(getProflieController.brainScores);
              // Get.to(() => QuizPage());
            },
            leading: Icon(Icons.bluetooth),
            title: Text('Fetch Previous EEG Reports'),
          ),
          ListTile(
            onTap: () {
              Get.to(() => YogaScreen());
            },
            leading: Icon(Icons.person_outline_sharp),
            title: Text('Yoga'),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('No')),
                    TextButton(
                        onPressed: () async {
                          await getProflieController.logout();
                          GetStorage().erase();
                          Get.offAll(() => LandingPage());
                        },
                        child: Text('Yes'))
                  ],
                ),
              );
            },
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
        ],
      )),
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
              color: color != const Color(0xffFF7E1D)
                  ? Colors.white
                  : const Color(0xffFF7E1D)),
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
