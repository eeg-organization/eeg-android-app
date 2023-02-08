import 'dart:convert';

import 'package:adv_eeg/screens/patient_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'doctorView.dart';
import 'emailLogin.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    GetStorage box = GetStorage();
    return Scaffold(
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
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
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
              const Padding(
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
              SizedBox(
                height: size.height * 0.45,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                        onTap: () {
                          if (box.read('loginDetails') == null) {
                            Get.to(() => EmailLogin());
                          } else {
                            Get.to(() => const PatientLogin());
                          }
                        },
                        // style: ButtonStyle(
                        //     backgroundColor:
                        //         MaterialStateProperty.all(Colors.deepOrange),
                        //     minimumSize: MaterialStateProperty.all(
                        //         const Size(double.infinity, 50))),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5)),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  'Login as User',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset('assets/Star 1.png'),
                                  Image.asset('assets/Vector 6.png'),
                                ],
                              )
                            ], 
                          ),
                        ))),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: >)
                          Get.offAll(() => const DoctorView());
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepOrange),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Login as Doctor'),
                            Text('-->')
                          ],
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepOrange),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Login as Relative'),
                            Text('-->')
                          ],
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
