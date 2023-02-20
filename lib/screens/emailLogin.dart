import 'package:adv_eeg/screens/patient_login.dart';
import 'package:adv_eeg/screens/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../controllers/login_controller.dart';
// import 'package:get/get.dart';

// ignore: camel_case_types
class usernameLogin extends StatelessWidget {
  const usernameLogin({super.key, required this.role});
  final String role;

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // backgroundColor: Colors.blue,
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: loginController.isLoading.value,
          // progressIndicator: LiquidCircularProgressIndicator(),
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.black87, BlendMode.hardLight),
                    // colorFilter: ColorFilterLayer(colorFilter: ColorFilter.matrix(matrix)),
                    image: AssetImage(
                      'assets/bg1.png',
                    ),
                    fit: BoxFit.cover)),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            BackButton(
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      height: size.height * 0.1,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Login with your Username',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: size.height * 0.05,
                  // ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Username',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                  Material(
                    // elevation: 20,
                    color: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Material(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(color: Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            textAlign: TextAlign.start,
                            controller: loginController.username,
                            // // obscureText: true,
                            // onChanged: (value) {
                            //   username = value;
                            // },
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                //   hintStyle: TextStyle(color:Colors.black),
                                hintText: 'Enter your username',
                                hintStyle: TextStyle(color: Colors.white)
                                // icon: Icon(Icons.lock)
                                ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Password',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                  Material(
                    // elevation: 5,
                    color: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Material(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(color: Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            textAlign: TextAlign.start,
                            obscureText: true,
                            controller: loginController.password,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                //   hintStyle: TextStyle(color:Colors.black),
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(color: Colors.white)
                                // icon: Icon(Icons.lock)
                                ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  ),
                  // const Expanded(
                  //   child: SizedBox(
                  //     height: 80,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
                        onTap: () async {
                          await loginController.login();
                          // if (await loginController.login() == 200) {
                          //   Get.off(() => PatientLogin());
                          // }
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (BuildContext context) =>
                          //             const PatientLogin()));
                        },
                        child: const OptionButton(
                          text: 'Login',
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('New User?',
                              style: TextStyle(color: Colors.grey)),
                          TextButton(
                              onPressed: () {
                                Get.to(() => SignUpPage(role: 'USER'));
                              },
                              child: const Text('Sign up'))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
