import 'package:adv_egg/quiz_page.dart';
import 'package:flutter/material.dart';

class PatientLogin extends StatefulWidget {
  const PatientLogin({Key? key}) : super(key: key);

  @override
  State<PatientLogin> createState() => _PatientLoginState();
}

class _PatientLoginState extends State<PatientLogin> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
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
                'Login as Patient',
                style: TextStyle(fontSize: 30),
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
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const QuizPage()));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          minimumSize: MaterialStateProperty.all(
                              const Size(double.infinity, 50))),
                      child: const Text('Quiz'))),
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
                      child: const Text('EEG'))),
            )
          ],
        )),
      ),
    );
  }
}
