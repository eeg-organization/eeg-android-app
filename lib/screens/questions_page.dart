import 'package:adv_egg/controllers/counter_controller.dart';
import 'package:adv_egg/controllers/question_controller.dart';
import 'package:adv_egg/controllers/quiz_controller.dart';
import 'package:adv_egg/screens/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({Key? key, required this.type}) : super(key: key);
  final type;
  @override
  Widget build(BuildContext context) {
    final QuizController quizController = Get.put(QuizController(type));
    final QuestionController questionController =
        Get.put(QuestionController(type));
    final CounterController counterController = Get.put(CounterController());
    var size = MediaQuery.of(context).size;
    return Obx(
      () => questionController.isLoading.value
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : ModalProgressHUD(
              inAsyncCall: quizController.isLoading.value,
              progressIndicator: CircularProgressIndicator(
                backgroundColor: Colors.amber,
              ),
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.black,
                ),
                resizeToAvoidBottomInset: false,
                body: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      colorFilter:
                          ColorFilter.mode(Colors.black87, BlendMode.hardLight),
                      image: AssetImage('assets/bg1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            child: StepProgressIndicator(
                              totalSteps: questionController
                                  .question.value.questions!.length,
                              currentStep:
                                  counterController.current_step.value + 1,
                              selectedColor: Colors.purple,
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
                                '${counterController.current_step.value + 1}/${questionController.question.value.questions!.length}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        Obx(
                          () => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Text(
                                  ' ${questionController.question.value.questions?[counterController.current_step.value].question?.question}', //get question data from backend
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Tooltip(
                                  showDuration: Duration(seconds: 5),
                                  triggerMode: TooltipTriggerMode.tap,
                                  message: questionController
                                              .question
                                              .value
                                              .questions?[counterController
                                                  .current_step.value]
                                              .question
                                              ?.description !=
                                          null
                                      ? '${questionController.question.value.questions?[counterController.current_step.value].question?.description}'
                                      : '',
                                  child: const Icon(
                                    Icons.info,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.0025,
                        ),
                        Expanded(
                          child: Obx(
                            () => ListView.builder(
                              itemCount: questionController
                                  .question
                                  .value
                                  .questions?[
                                      counterController.current_step.value]
                                  .options
                                  ?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    questionController.options[counterController
                                        .current_step.value] = index;
                                    print(questionController.options);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Obx(
                                      () => Material(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            side: const BorderSide(
                                                color: Colors.white)),
                                        color: questionController.options[
                                                    counterController
                                                        .current_step.value] ==
                                                index
                                            ? Colors.blueAccent
                                            : Colors.transparent,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8.0,
                                              horizontal: 4,
                                            ),
                                            child: Text(
                                              '${questionController.question.value.questions?[counterController.current_step.value].options?[index].option}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (counterController.current_step.value != 0)
                                Padding(
                                  padding: const EdgeInsets.all(
                                    16,
                                  ),
                                  child: ElevatedButton(
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                        Colors.black,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (counterController
                                              .current_step.value !=
                                          0) {
                                        counterController.decrement();
                                      }
                                    },
                                    child: const Text(
                                      'Previous',
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(
                                  16,
                                ),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (counterController.current_step.value !=
                                            questionController.question.value
                                                    .questions!.length -
                                                1 &&
                                        questionController.options[
                                                counterController
                                                    .current_step.value] !=
                                            -1) {
                                      counterController.increment();
                                    } else if (counterController
                                                .current_step.value ==
                                            questionController.question.value
                                                    .questions!.length -
                                                1 &&
                                        questionController.options[
                                                counterController
                                                    .current_step.value] !=
                                            -1) {
                                      quizController.mergeScoreAndQuestion();
                                      if (await quizController.postData() ==
                                          200) {
                                        Get.off(() => const QuizPage());
                                      }
                                    }
                                  },
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                      Color(
                                        0xffFF7E1D,
                                      ),
                                    ),
                                  ),
                                  child: counterController.current_step.value !=
                                          questionController.question.value
                                                  .questions!.length -
                                              1
                                      ? const Text(
                                          'Save & Next',
                                        )
                                      : const Text(
                                          'Submit',
                                        ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
