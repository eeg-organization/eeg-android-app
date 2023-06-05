import 'package:adv_eeg/screens/patient_login.dart';
import 'package:adv_eeg/screens/yogaScreen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:toast/toast.dart';

import '../controllers/counter_controller.dart';
import '../controllers/question_controller.dart';
import '../controllers/quiz_controller.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({Key? key, required this.type}) : super(key: key);
  final type;
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    final QuizController quizController = Get.put(QuizController(type));
    final QuestionController questionController =
        Get.put(QuestionController(type));
    final CounterController counterController = Get.put(CounterController());
    var size = MediaQuery.of(context).size;
    return Obx(
      () => questionController.isLoading.value
          ? Scaffold(
              body: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      colorFilter:
                          ColorFilter.mode(Colors.black87, BlendMode.hardLight),
                      image: AssetImage('assets/bg1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(child: CircularProgressIndicator()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText(
                            'Please wait while we load the $type quiz for you',
                            style: GoogleFonts.inika(color: Colors.white)),
                      )
                    ],
                  )))
          : Obx(
              () => ModalProgressHUD(
                inAsyncCall: quizController.isLoading.value,
                progressIndicator: const CircularProgressIndicator(
                  backgroundColor: Colors.amber,
                ),
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                  extendBodyBehindAppBar: true,
                  body: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black87, BlendMode.hardLight),
                        image: AssetImage('assets/bg1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        children: [
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8),
                              child: StepProgressIndicator(
                                roundedEdges: const Radius.circular(8),
                                totalSteps: questionController
                                    .question.value.questions.length,
                                currentStep:
                                    counterController.current_step.value + 1,
                                selectedColor: const Color(0xff0850FD),
                              ),
                            ),
                          ),
                          Obx(
                            () => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  '${counterController.current_step.value + 1}/${questionController.question.value.questions.length}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: size.height * 0.025,
                          // ),
                          Obx(
                            () => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Visibility(
                                    visible: questionController
                                                .question
                                                .value
                                                .questions[counterController
                                                    .current_step.value]
                                                .question
                                                ?.question
                                                .contains('Question') ==
                                            false
                                        ? true
                                        : false,
                                    child: Expanded(
                                      child: AutoSizeText(
                                        ' ${questionController.question.value.questions[counterController.current_step.value].question?.question}',
                                        textAlign: TextAlign.center,
                                        //get question data from backend
                                        style: GoogleFonts.inter(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Visibility(
                                      visible: questionController
                                              .question
                                              .value
                                              .questions[counterController
                                                  .current_step.value]
                                              .question
                                              ?.description !=
                                          null,
                                      child: Tooltip(
                                        showDuration:
                                            const Duration(seconds: 5),
                                        triggerMode: TooltipTriggerMode.tap,
                                        message: questionController
                                                    .question
                                                    .value
                                                    .questions[counterController
                                                        .current_step.value]
                                                    .question
                                                    ?.description !=
                                                null
                                            ? '${questionController.question.value.questions[counterController.current_step.value].question?.description}'
                                            : '',
                                        child: const Icon(
                                          Icons.info,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.0025,
                          ),
                          Obx(
                            () => ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: questionController
                                  .question
                                  .value
                                  .questions[
                                      counterController.current_step.value]
                                  .options
                                  ?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    questionController.options[counterController
                                        .current_step.value] = index;
                                    // print(questionController.options);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8),
                                    child: Obx(
                                      () => Material(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            side: BorderSide(
                                                color: questionController
                                                                .options[
                                                            counterController
                                                                .current_step
                                                                .value] !=
                                                        index
                                                    ? Colors.white
                                                    : const Color(0xff0850FD))),
                                        color: questionController.options[
                                                    counterController
                                                        .current_step.value] ==
                                                index
                                            ? const Color(0xff0850FD)
                                            : Colors.transparent,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16.0,
                                              horizontal: 4,
                                            ),
                                            child: Text(
                                                '${questionController.question.value.questions[counterController.current_step.value].options?[index].option}',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Visibility(
                                    visible:
                                        counterController.current_step.value !=
                                            0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                        16,
                                      ),
                                      child: GestureDetector(
                                          onTap: () {
                                            if (counterController
                                                    .current_step.value !=
                                                0) {
                                              counterController.decrement();
                                            }
                                          },
                                          child: const OptionButton(
                                            text: '   Previous   ',
                                            color: Colors.transparent,
                                          )),
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width: size.width * 0.2,
                                // ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      16,
                                    ),
                                    child: GestureDetector(
                                        onTap: () async {
                                          if (counterController
                                                      .current_step.value !=
                                                  questionController
                                                          .question
                                                          .value
                                                          .questions
                                                          .length -
                                                      1 &&
                                              questionController.options[
                                                      counterController
                                                          .current_step
                                                          .value] !=
                                                  -1) {
                                            counterController.increment();
                                          } else if (counterController
                                                      .current_step.value ==
                                                  questionController
                                                          .question
                                                          .value
                                                          .questions
                                                          .length -
                                                      1 &&
                                              questionController.options[
                                                      counterController
                                                          .current_step
                                                          .value] !=
                                                  -1) {
                                            quizController
                                                .mergeScoreAndQuestion();
                                            if (await quizController
                                                    .postData() ==
                                                200) {
                                              Toast.show(
                                                  "Quiz Submitted Successfully ",
                                                  duration: Toast.lengthShort,
                                                  gravity: Toast.bottom);
                                              // Get.off(() => const QuizPage());
                                              // Navigator.pop(context);
                                              Get.off(() => YogaScreen());
                                            }
                                          }
                                        },
                                        child: OptionButton(
                                            text: counterController
                                                        .current_step.value !=
                                                    questionController
                                                            .question
                                                            .value
                                                            .questions
                                                            .length -
                                                        1
                                                ? '      Next      '
                                                : 'Submit',
                                            color: const Color(0xffFF7E1D))),
                                  ),
                                ),
                              ],
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
