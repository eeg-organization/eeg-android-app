import 'package:adv_egg/questions_page.dart';
import 'package:flutter/material.dart';
class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // boxShadow: [
          //   BoxShadow(color: Colors.black)
          // ],
          // backgroundBlendMode: BlendMode.color,
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black, BlendMode.softLight),
                image: AssetImage('assets/bg1.jpg'), fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.2,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Select the Quiz type',
                    style: TextStyle(fontSize: 30,color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const QuestionsPage()));
                          },
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 50))),
                          child: const Text('Quiz 1'))),
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 50))),
                          child: const Text('Quiz 2'))),),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 50))),
                          child: const Text('Quiz 3')))),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 50))),
                          child: const Text('Quiz 4')))),

              ],
          ),
        ),
      ),
    );
  }
}