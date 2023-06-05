// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'package:adv_eeg/controllers/auth/signUpController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key, required this.role});
  final String role;
  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.put(SignUpController(role: role));
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
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: signUpController.isLoading.value,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/bg1.png',
                ),
                fit: BoxFit.cover,
                // opacity: 0.5,
                colorFilter:
                    ColorFilter.mode(Colors.black87, BlendMode.hardLight),
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  // verticalDirection: VerticalDirection.down,
                  children: [
                    SignUpTextField(
                      labelText: 'Username*',
                      hintText: 'Enter your username',
                      controller: signUpController.username,
                      obscureText: false,
                    ),
                    SignUpTextField(
                      labelText: 'Name*',
                      hintText: 'Enter your name',
                      controller: signUpController.name,
                      obscureText: false,
                    ),
                    SignUpTextField(
                      labelText: 'Age*',
                      controller: signUpController.age,
                      hintText: 'Enter your age',
                      obscureText: false,
                      inputType: TextInputType.number,
                    ),
                    SignUpTextField(
                      labelText: 'Email*',
                      hintText: 'Enter your email',
                      controller: signUpController.email,
                      obscureText: false,
                      inputType: TextInputType.emailAddress,
                    ),
                    SignUpTextField(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      controller: signUpController.password,
                      obscureText: true,
                    ),
                    SignUpTextField(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm your password',
                      controller: signUpController.confirmPassword,
                      obscureText: true,
                    ),
                    SignUpTextField(
                      labelText: 'Phone No.',
                      hintText: 'Enter your phone no.',
                      controller: signUpController.phoneNo,
                      obscureText: false,
                      inputType: TextInputType.phone,
                    ),
                    SignUpTextField(
                      labelText: 'Blood Pressure',
                      hintText: 'Enter your blood pressure',
                      controller: signUpController.bloodPressure,
                      obscureText: false,
                      inputType: TextInputType.number,
                    ),
                    GenderDropdown(signUpController: signUpController),
                    role != 'DOCTOR'
                        ? BloodGroupDropDown(signUpController: signUpController)
                        : Container(),
                    role != 'DOCTOR'
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                color: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side:
                                        const BorderSide(color: Colors.white)),
                                child: Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButton(
                                      underline: Text(''),

                                      isExpanded: true,
                                      alignment: Alignment.center,
                                      borderRadius: BorderRadius.circular(5),
                                      value: signUpController.doctor.value ==
                                              'DOCTOR'
                                          ? null
                                          : signUpController.doctor.value,
                                      hint: Text(
                                        '${role == 'USER' ? 'DOCTOR' : 'PATIENT'}*',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      // dropdownColor: Colors.white,
                                      style: TextStyle(color: Colors.white),
                                      onChanged: (value) => signUpController
                                          .doctor.value = value.toString(),
                                      items: signUpController
                                          .userList.value.data!
                                          .map(
                                        (e) {
                                          return DropdownMenuItem(
                                            value: e.username,
                                            child: Text(
                                              e.name.toString(),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    ElevatedButton(
                        onPressed: () async {
                          if ((signUpController.username.text != '' ||
                                  signUpController.username.text != null) &&
                              (signUpController.name.text != '' ||
                                  signUpController.name.text != null) &&
                              (signUpController.doctor.value != 'DOCTOR') &&
                              (signUpController.password.text != '' ||
                                  signUpController.password.text != null) &&
                              (signUpController.confirmPassword.text != '' ||
                                  signUpController.confirmPassword.text !=
                                      null) &&
                              (signUpController.password.text ==
                                  signUpController.confirmPassword.text))
                            await signUpController.createUser();
                          else {
                            Get.snackbar('Error', 'Please fill all the fields');
                          }
                        },
                        child: Text('Sign Up')),
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

class SignUpTextField extends StatelessWidget {
  SignUpTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    this.inputType,
  });
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? inputType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: Colors.white)),
        color: Colors.transparent,
        // borderRadius: BorderRadius.circular(20),
        child: TextField(
          autofocus: true,
          obscureText: obscureText,
          keyboardType: inputType,
          cursorHeight: 30,
          style: TextStyle(color: Colors.white),
          controller: controller,
          decoration: InputDecoration(
            disabledBorder: InputBorder.none,
            // contentPadding: EdgeInsets.all(8),
            fillColor: Colors.transparent,
            enabledBorder: InputBorder.none,
            labelText: labelText,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white),
            isDense: true,
            border: InputBorder.none,
            filled: true,
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class GenderDropdown extends StatelessWidget {
  const GenderDropdown({super.key, required this.signUpController});
  final SignUpController signUpController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Align(
        alignment: Alignment.topLeft,
        child: Material(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(color: Colors.white)),
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                isExpanded: true,
                underline: Text(''),
                alignment: Alignment.center,
                borderRadius: BorderRadius.circular(5),
                value: signUpController.gender.value == 'GENDER'
                    ? null
                    : signUpController.gender.value,
                hint: Text(
                  'GENDER*',
                  style: TextStyle(color: Colors.white),
                ),
                // dropdownColor: Colors.white,
                style: TextStyle(color: Colors.white),
                onChanged: (value) =>
                    signUpController.gender.value = value.toString(),
                items: [
                  DropdownMenuItem(
                    child: Text('Male'),
                    value: 'Male',
                  ),
                  DropdownMenuItem(
                    child: Text('Female'),
                    value: 'Female',
                  ),
                  DropdownMenuItem(
                    child: Text('Other'),
                    value: 'Other',
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

class BloodGroupDropDown extends StatelessWidget {
  const BloodGroupDropDown({super.key, required this.signUpController});
  final SignUpController signUpController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Align(
        alignment: Alignment.topLeft,
        child: Material(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(color: Colors.white)),
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: DropdownButton(
                isExpanded: true,
                underline: Text(''),
                alignment: Alignment.center,
                borderRadius: BorderRadius.circular(5),
                value: signUpController.bloodGroup.value == 'BLOOD GROUP'
                    ? null
                    : signUpController.bloodGroup.value,
                hint: Text(
                  'Blood Group*',
                  style: TextStyle(color: Colors.white),
                ),
                // dropdownColor: Colors.white,
                style: TextStyle(color: Colors.white),
                onChanged: (value) =>
                    signUpController.bloodGroup.value = value.toString(),
                items: [
                  DropdownMenuItem(
                    child: Text('A+'),
                    value: 'A_POSITIVE',
                  ),
                  DropdownMenuItem(
                    child: Text('A-'),
                    value: 'A_NEGATIVE',
                  ),
                  DropdownMenuItem(
                    child: Text('B+'),
                    value: 'B_POSITIVE+',
                  ),
                  DropdownMenuItem(
                    child: Text('B-'),
                    value: 'B_NEGATIVE',
                  ),
                  DropdownMenuItem(
                    child: Text('AB+'),
                    value: 'AB_POSITIVE',
                  ),
                  DropdownMenuItem(
                    child: Text('AB-'),
                    value: 'AB_NEGATIVE',
                  ),
                  DropdownMenuItem(
                    child: Text('O+'),
                    value: 'O_POSITIVE',
                  ),
                  DropdownMenuItem(
                    child: Text('O-'),
                    value: 'O_NEGATIVE',
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
