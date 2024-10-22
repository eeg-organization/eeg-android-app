import 'package:adv_eeg/controllers/counter_controller.dart';
import 'package:adv_eeg/screens/patientScreens/patient_login.dart';
import 'package:adv_eeg/screens/patientScreens/questions_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({required this.role, required this.uid});
  final role, uid;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    CounterController counterController = Get.put(CounterController());
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios),
        //   // onPressed: () {
        //   //   // Get.to(() => LandingPage());
        //   //   Get.back();
        //   // },
        // ),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            // const Align(
            //   alignment: Alignment.topLeft,
            //   child: BackButton(
            //     color: Colors.white,
            //   ),
            // ),
            SizedBox(
              height: size.height * 0.2,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                role == "DOCTOR"
                    ? 'Select the Quiz type'
                    : "Please take the test",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: GestureDetector(
                onTap: () {
                  counterController.selectedValue.value = 1;
                },
                child: Obx(
                  () => Material(
                    color: counterController.selectedValue.value != 1
                        ? Colors.transparent
                        : const Color(0xff0850FD),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                            color: counterController.selectedValue.value != 1
                                ? Colors.white
                                : const Color(0xff0850FD))),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Center(
                        child: Text(
                          'BDI',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            role != 'USER'
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // Get.to(() => const QuestionsPage(type: 'BID'));
                        counterController.selectedValue.value = 2;
                      },
                      child: Obx(
                        () => Material(
                          color: counterController.selectedValue.value != 2
                              ? Colors.transparent
                              : const Color(0xff0850FD),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                  color:
                                      counterController.selectedValue.value != 2
                                          ? Colors.white
                                          : const Color(0xff0850FD))),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Center(
                              child: Text(
                                'HAM_D',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 64,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  if (counterController.selectedValue.value == 1) {
                    counterController.selectedValue.value = 0;
                    Get.off(() => QuestionsPage(
                          type: 'BID',
                          role: role,
                          uid: uid,
                        ));
                  } else if (counterController.selectedValue.value == 2) {
                    counterController.selectedValue.value = 0;
                    Get.off(() => QuestionsPage(
                          type: 'HAM_D',
                          role: role,
                          uid: uid,
                        ));
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(32),
                  width: 124,
                  child: const OptionButton(
                    color: Color(0xffFF7E1D),
                    text: 'Next',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
