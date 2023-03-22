import 'package:adv_eeg/controllers/counter_controller.dart';
import 'package:adv_eeg/screens/patient_login.dart';
import 'package:adv_eeg/screens/questions_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    CounterController counterController = Get.put(CounterController());
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black87, BlendMode.hardLight),
            image: AssetImage('assets/bg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
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
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Select the Quiz type',
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
                            'Quiz 1',
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
              Padding(
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
                              color: counterController.selectedValue.value != 2
                                  ? Colors.white
                                  : const Color(0xff0850FD))),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            'Quiz 2',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    if (counterController.selectedValue.value == 1) {
                      counterController.selectedValue.value = 0;
                      Get.off(() => const QuestionsPage(type: 'HAM_D'));
                    } else if (counterController.selectedValue.value == 2) {
                      counterController.selectedValue.value = 0;
                      Get.off(() => const QuestionsPage(type: 'BID'));
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
      ),
    );
  }
}
