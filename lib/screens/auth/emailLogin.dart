import 'package:adv_eeg/screens/patientScreens/patient_login.dart';
import 'package:adv_eeg/screens/auth/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../controllers/auth/login_controller.dart';
// import 'package:get/get.dart';

// ignore: camel_case_types
class usernameLogin extends StatelessWidget {
  const usernameLogin({super.key});
  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      extendBodyBehindAppBar: true,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Login with your Username',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Material(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: Colors.white)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.name,
                        controller: loginController.username,
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your username'
                            : null,

                        // // obscureText: true,
                        // onChanged: (value) {
                        //   username = value;
                        // },
                        decoration: const InputDecoration(
                            label: Text('Username'),
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 20),
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          controller: loginController.password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a value.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              // label: Text('Password'),
                              labelStyle:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              labelText: 'Password',
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
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                      onTap: () async {
                        await loginController.login();
                      },
                      child: const OptionButton(
                        text: 'Login',
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('New User?',
                        style: TextStyle(color: Colors.grey)),
                    TextButton(
                        onPressed: () {
                          Get.defaultDialog(
                              title: 'Select your role',
                              content: Column(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                        Get.to(() => SignUpPage(role: 'USER'));
                                      },
                                      child: const Text('Patient')),
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                        Get.to(
                                            () => SignUpPage(role: 'DOCTOR'));
                                      },
                                      child: const Text('Doctor')),
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                        Get.to(
                                            () => SignUpPage(role: 'RELATIVE'));
                                      },
                                      child: const Text('Relative')),
                                ],
                              ));
                          // Get.to(() => SignUpPage(role: role));
                        },
                        child: const Text('Sign up'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
