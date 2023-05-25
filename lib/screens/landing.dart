// import 'dart:convert';

import 'package:adv_eeg/screens/adminSide.dart';
import 'package:adv_eeg/screens/emailLogin.dart';
import 'package:adv_eeg/screens/patient_login.dart';
import 'package:adv_eeg/screens/relativeSide.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;

import 'doctorView.dart';
// import 'usernameLogin.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    GetStorage box = GetStorage();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.blue,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                colorFilter:
                    ColorFilter.mode(Colors.black38, BlendMode.hardLight),
                image: AssetImage('assets/bg.png'),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(children: [
                SizedBox(
                  height: 50,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Hi there 👋',
                      style: TextStyle(
                          fontSize: 30,
                          // fontSize: size.width*0.5
                          color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '''Welcome''',
                      style: TextStyle(fontSize: 60, color: Colors.white

                          // fontSize: size.width*0.5
                          ),
                    ),
                  ),
                ),
              ]),
              Column(children: [
                Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                        onTap: () {
                          if (box.read('loginDetails') != null &&
                              box.read('loginDetails')['user']['role'] ==
                                  'USER') {
                            Get.to(() => PatientLogin());
                          } else {
                            Get.to(() => usernameLogin(
                                  role: 'USER',
                                ));
                          }
                        },
                        child: const LoginButtons(
                            starValue: 1, text: 'Login as User'))),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                    onTap: () {
                      if (box.read('loginDetails') != null &&
                          box.read('loginDetails')['user']['role'] ==
                              'DOCTOR') {
                        Get.to(() => const DoctorView());
                      } else {
                        Get.to(() => usernameLogin(
                              role: 'DOCTOR',
                            ));
                      }
                    },
                    child: const LoginButtons(
                      text: 'Login as Doctor',
                      starValue: 2,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                      onTap: () {
                        if (box.read('loginDetails') != null &&
                            box.read('loginDetails')['user']['role'] ==
                                'RELATIVE') {
                          Get.to(() => const RelativeSide());
                        } else {
                          Get.to(() => usernameLogin(
                                role: 'RELATIVE',
                              ));
                        }
                      },
                      child: const LoginButtons(
                        text: 'Login as Relative',
                        starValue: 3,
                      ),
                    )),
                // const SizedBox(height: 120),
                TextButton(
                    onPressed: () {
                      if (box.read('loginDetails') != null &&
                          box.read('loginDetails')['user']['role'] == 'ADMIN')
                        Get.to(() => AdminMain());
                      else {
                        Get.to(() => const usernameLogin(
                              role: 'ADMIN',
                            ));
                      }
                    },
                    child: const Text('ADMIN LOGIN'))
              ])
            ],
          ),
        ),
      ),
    );
  }
}

class LoginButtons extends StatelessWidget {
  const LoginButtons({super.key, this.starValue, this.text});
  final starValue;
  final text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  alignment: Alignment.bottomRight,
                  image: AssetImage(
                    'assets/Star $starValue.png',
                  ))),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset('assets/Vector 6.png'),
              )
            ],
          ),
        ),
      ],
    );
  }
}
