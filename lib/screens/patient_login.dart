import 'package:adv_eeg/controllers/getProfileController.dart';
import 'package:adv_eeg/screens/quiz_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_seria_changed/flutter_bluetooth_serial.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'eegScreen.dart';

class PatientLogin extends StatelessWidget {
  PatientLogin({Key? key}) : super(key: key);
  GetProflieController getProflieController = Get.put(GetProflieController());
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
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(
                    color: Colors.white,
                  ),
                  IconButton(
                      onPressed: () {
                        showMenu(
                            context: context,
                            position: RelativeRect.fromDirectional(
                                textDirection: TextDirection.rtl,
                                start: double.infinity,
                                top: 0,
                                end: double.infinity,
                                bottom: 0),
                            items: [
                              PopupMenuItem(
                                child: TextButton(
                                  onPressed: () {
                                    // Get.toNamed('/profile');
                                    getProflieController.fetchProfile(
                                        GetStorage()
                                            .read('loginDetails')['user_id']);
                                    showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        // transitionAnimationController: AnimationController(vsync: this),
                                        // isScrollControlled: true,/
                                        isDismissible: true,
                                        context: context,
                                        builder: (context) => Obx(
                                              () => ModalProgressHUD(
                                                inAsyncCall:
                                                    getProflieController
                                                        .isLoading.value,
                                                child: Container(
                                                  color: Colors.green,
                                                  child: Visibility(
                                                    visible:
                                                        !getProflieController
                                                            .isLoading.value,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.person,
                                                          size: 100,
                                                        ),
                                                        Text(
                                                            '${getProflieController.profile.value.name}'),
                                                        Text(
                                                            '${getProflieController.profile.value.username}'),
                                                        Text(
                                                            '${getProflieController.profile.value.age}'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.person),
                                      Text('Profile'),
                                    ],
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                              'Are you sure you want to logout?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text('No')),
                                            TextButton(
                                                onPressed: () {
                                                  GetStorage()
                                                      .remove('loginDetails');
                                                  Get.offAllNamed('/');
                                                },
                                                child: Text('Yes'))
                                          ],
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.logout),
                                        Text('Logout')
                                      ],
                                    )),
                              )
                            ]);
                      },
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ))
                ],
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
