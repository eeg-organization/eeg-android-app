import 'package:adv_egg/questions_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // boxShadow: [
          //   BoxShadow(color: Colors.black)
          // ],
          // backgroundBlendMode: BlendMode.color,
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.black,
              BlendMode.softLight,
            ),
            image: AssetImage('assets/bg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              SizedBox(
                height: size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const QuestionsPage(type: 'HAM_D'));
                  },
                  child: Material(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: Colors.white)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Quiz 1',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const QuestionsPage(type: 'BID'));
                  },
                  child: Material(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: Colors.white)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Quiz 2',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: size.height * 0.025,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
              //   child: Align(
              //       alignment: Alignment.bottomLeft,
              //       child: ElevatedButton(
              //           onPressed: () {
              //             Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>QuestionsPage(type: 'TYPE_3',)));
              //           },
              //           style: ButtonStyle(
              //               backgroundColor:
              //               MaterialStateProperty.all(Colors.black),
              //               minimumSize: MaterialStateProperty.all(
              //                   const Size(double.infinity, 50))),
              //           child: const Text('Quiz 3')))),
              // SizedBox(
              //   height: size.height * 0.025,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
              //   child: Align(
              //       alignment: Alignment.bottomLeft,
              //       child: ElevatedButton(
              //           onPressed: () {},
              //           style: ButtonStyle(
              //               backgroundColor:
              //               MaterialStateProperty.all(Colors.black),
              //               minimumSize: MaterialStateProperty.all(
              //                   const Size(double.infinity, 50))),
              //           child: const Text('Quiz 4')))),
            ],
          ),
        ),
      ),
    );
  }
}
