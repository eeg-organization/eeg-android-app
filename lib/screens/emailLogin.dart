import 'package:adv_egg/controllers/question_controller.dart';
import 'package:adv_egg/screens/patient_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  // const EmailLogin({Key? key}) : super(key: key);

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  // final QuestionController questionController = Get.put(QuestionController());
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.blue,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                colorFilter:
                    ColorFilter.mode(Colors.black, BlendMode.softLight),
                // colorFilter: ColorFilterLayer(colorFilter: ColorFilter.matrix(matrix)),
                image: AssetImage(
                  'assets/bg1.png',
                ),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.15,
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Login with your E-mail',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
              Material(
                // elevation: 20,
                color: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: Colors.white)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        textAlign: TextAlign.start,
                        // obscureText: true,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            //   hintStyle: TextStyle(color:Colors.black),
                            hintText: 'Enter your Email',
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
                padding: EdgeInsets.all(8.0),
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
                  padding: const EdgeInsets.all(8.0),
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
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            //   hintStyle: TextStyle(color:Colors.black),
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(color: Colors.white)
                            // icon: Icon(Icons.lock)
                            ),
                        style: const TextStyle(
                            // color:Colors.white
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const PatientLogin()));
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 50))),
                    child: const Text(
                      'Login',
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('New User?',
                        style: TextStyle(color: Colors.grey)),
                    TextButton(onPressed: () {}, child: const Text('Sign up'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
