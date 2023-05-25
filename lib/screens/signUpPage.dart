import 'package:adv_eeg/controllers/signUpController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key, required this.role});
  final String role;
  SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/bg1.png',
            ),
            fit: BoxFit.cover,
            // opacity: 0.5,
            colorFilter: ColorFilter.mode(Colors.black87, BlendMode.hardLight),
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: SizedBox(
              height: Get.height,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                // verticalDirection: VerticalDirection.down,
                children: [
                  SignUpTextField(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    controller: signUpController.username,
                    obscureText: false,
                  ),
                  SignUpTextField(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    controller: signUpController.name,
                    obscureText: false,
                  ),
                  SignUpTextField(
                    labelText: 'Age',
                    controller: signUpController.age,
                    hintText: 'Enter your age',
                    obscureText: false,
                    inputType: TextInputType.number,
                  ),
                  SignUpTextField(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    controller: signUpController.email,
                    obscureText: false,
                    inputType: TextInputType.emailAddress,
                  ),
                  SignUpTextField(
                    labelText: 'Phone No.',
                    hintText: 'Enter your phone no.',
                    controller: signUpController.phoneNo,
                    obscureText: false,
                    inputType: TextInputType.phone,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(color: Colors.white)),
                        child: DropdownMenu(
                          trailingIcon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Sex',
                            style: TextStyle(color: Colors.white),
                          ),
                          leadingIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          textStyle: TextStyle(color: Colors.white),
                          // style: TextStyle(color: Colors.white),
                          dropdownMenuEntries: [
                            DropdownMenuEntry(label: 'Male', value: 'Male'),
                            DropdownMenuEntry(
                              label: 'Female',
                              value: 'Female',
                            ),
                            DropdownMenuEntry(
                              label: 'Other',
                              value: 'Other',
                            ),
                          ],
                          controller: signUpController.gender,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(color: Colors.white)),
                        child: DropdownMenu(
                          trailingIcon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          menuStyle: MenuStyle(
                            // visualDensity: VisualDensity.compact,
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                            // elevation: ,
                            // alignment: Alignment.topLeft,
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          hintText: 'Blood Group',
                          label: Text(
                            'Blood Group',
                            style: TextStyle(color: Colors.white),
                          ),
                          textStyle: TextStyle(color: Colors.white),
                          controller: signUpController.bloodGroup,
                          leadingIcon: Icon(
                            Icons.bloodtype,
                            color: Colors.white,
                          ),
                          enableSearch: true,
                          enableFilter: true,
                          dropdownMenuEntries: [
                            DropdownMenuEntry(
                                value: 'A_POSITIVE', label: 'A_POSITIVE'),
                            DropdownMenuEntry(
                                value: 'A_NEGATIVE', label: 'A_NEGATIVE'),
                            DropdownMenuEntry(
                                value: 'B_POSITIVE', label: 'B_POSITIVE'),
                            DropdownMenuEntry(
                                value: 'B_NEGATIVE', label: 'B_NEGATIVE'),
                            DropdownMenuEntry(
                                value: 'AB_POSITIVE', label: 'AB_POSITIVE'),
                            DropdownMenuEntry(
                                value: 'AB_NEGATIVE', label: 'AB_NEGATIVE'),
                            DropdownMenuEntry(
                                value: 'O_POSITIVE', label: 'O_POSITIVE'),
                            DropdownMenuEntry(
                                value: 'O_NEGATIVE', label: 'O_NEGATIVE'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //   child: Align(
                  //     alignment: Alignment.topLeft,
                  //     child: Material(
                  //       color: Colors.transparent,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(5),
                  //           side: const BorderSide(color: Colors.white)),
                  //       child: DropdownMenu(
                  //         trailingIcon: Icon(
                  //           Icons.arrow_drop_down,
                  //           color: Colors.white,
                  //         ),
                  //         menuStyle: MenuStyle(
                  //           // visualDensity: VisualDensity.compact,
                  //           shape: MaterialStateProperty.all(
                  //               RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(20),
                  //           )),
                  //           // elevation: ,
                  //           // alignment: Alignment.topLeft,
                  //           backgroundColor:
                  //               MaterialStateProperty.all(Colors.white),
                  //         ),
                  //         hintText: 'Doctor',
                  //         label: Text(
                  //           'Doctor',
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //         textStyle: TextStyle(color: Colors.white),
                  //         controller: signUpController.bloodGroup,
                  //         leadingIcon: Icon(
                  //           Icons.bloodtype,
                  //           color: Colors.white,
                  //         ),
                  //         enableSearch: true,
                  //         enableFilter: true,
                  //         dropdownMenuEntries: signUpController
                  //             .doctorList.value.data!
                  //             .map((e) => DropdownMenuEntry(
                  //                 value: e.username, label: e.name.toString()))
                  //             .toList(),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SignUpTextField(
                    labelText: 'Blood Pressure',
                    hintText: 'Enter your blood pressure',
                    controller: signUpController.bloodPressure,
                    obscureText: false,
                    inputType: TextInputType.number,
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
                  ElevatedButton(
                      onPressed: () async {
                        await signUpController.createUser();
                      },
                      child: Text('Sign Up')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpTextField extends StatelessWidget {
  const SignUpTextField({
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
        child: TextFormField(
          obscureText: obscureText,
          keyboardType: inputType,
          cursorHeight: 30,
          decoration: InputDecoration(
            disabledBorder: InputBorder.none,
            // contentPadding: EdgeInsets.all(8),
            // fillColor: Colors.black.withAlpha(100),
            labelText: labelText,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
            filled: true,
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
